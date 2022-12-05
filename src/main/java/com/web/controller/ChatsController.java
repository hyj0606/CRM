package com.web.controller;

import com.commons.contants.Contants;
import com.commons.domain.ReturnObject;
import com.commons.utils.DateUtils;
import com.pojo.Chats;
import com.pojo.Customer;
import com.pojo.User;
import com.service.ChatsService;
import com.service.CustomerService;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName ChatsController
 * @Description TODO
 * @Author hyj98
 * @Date 2022-11-28 16:16
 * @Version 1.0
 */
@Controller
public class ChatsController {

    @Autowired
    private ChatsService chatsService;

    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    @RequestMapping("/workbench/chats/index.do")
    public String index(HttpServletRequest request){

        //调用service层方式,查询所有用户
        List<User> userList = userService.queryAllUsers();
        List<Customer> customerList = customerService.queryAllCustomer();

        //把数据保存到request中
        request.setAttribute("userList",userList);
        request.setAttribute("customerList",customerList);

        //跳转到chats/index.jsp
        return "workbench/chats/index";
    }

    @RequestMapping("/workbench/chats/queryChatsByPage.do")
    @ResponseBody
    public Object queryChatsByPage(HttpSession session, String username, String custName, String concatType, int pageNo, int pageSize){

        User user = (User) session.getAttribute(Contants.SESSION_USER);

        //封装参数
        Map<String, Object> map = new HashMap<>();
        map.put("username",username);
        map.put("custName",custName);
        map.put("concatType",concatType);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("beginNo",(pageNo-1)*pageSize);
        map.put("userId",user.getId());

        //调用service层,查询数据
        List<Chats> chatsList = chatsService.queryChatsByPage(map);
        int count = chatsService.queryCountOfChats(map);
        //根据查询结果,生成响应数据
        Map<String, Object> retMap = new HashMap<>();
        retMap.put("chatsList",chatsList);
        retMap.put("count",count);
        return retMap;
    }


    @RequestMapping("/workbench/chats/saveChats.do")
    @ResponseBody
    public Object saveChats(Chats chats, HttpSession session){
        User user = (User) session.getAttribute(Contants.SESSION_USER);

        //封装数据
        chats.setCreateUid(user.getId());  //创建者ID
        chats.setCreateTime(DateUtils.formateDateTime(new Date()));//创建时间
        ReturnObject returnObject = new ReturnObject();

        try {
            //调用service层,传递数据对象
            int ret = chatsService.saveChats(chats);

            if (ret > 0){
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            }else {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("系统忙,请稍后重试....");
            }
        }catch (Exception e){
            e.printStackTrace();
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("系统忙,请稍后重试....");
        }

        return returnObject;
    }

    @RequestMapping("/workbench/chats/deleteChats.do")
    @ResponseBody
    public Object deleteChats(String[] id){
        ReturnObject returnObject = new ReturnObject();

        try {
            //调用service层,删除聊天记录
            int ret = chatsService.deleteChatsByIds(id);

            if (ret > 0){
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            }else {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("系统忙,请稍后重试....");
            }
        }catch (Exception e){
            e.printStackTrace();
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("系统忙,请稍后重试....");
        }
        return returnObject;
    }

    @RequestMapping("/workbench/chats/queryChatsById.do")
    @ResponseBody
    public Object queryChatsById(long id){

        Chats chats = chatsService.queryChatsById(id);

        return chats;
    }

    @RequestMapping("/workbench/chats/saveEditChats.do")
    @ResponseBody
    public Object saveEditChats(Chats chats){
        ReturnObject returnObject = new ReturnObject();
        try {
            int ret = chatsService.saveEditChats(chats);
            if (ret > 0){
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            }else {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("系统忙,请稍后重试....");
            }
        }catch (Exception e){
            e.printStackTrace();
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("系统忙,请稍后重试....");
        }
        return returnObject;
    }

}
