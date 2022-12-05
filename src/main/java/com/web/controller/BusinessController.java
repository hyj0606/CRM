package com.web.controller;

import com.commons.contants.Contants;
import com.commons.domain.ReturnObject;
import com.commons.utils.DateUtils;
import com.pojo.Business;
import com.pojo.Customer;
import com.pojo.Role;
import com.pojo.User;
import com.service.BusinessService;
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
 * @ClassName BusinessController
 * @Description TODO
 * @Author hyj98
 * @Date 2022-11-30 16:17
 * @Version 1.0
 */

@Controller
public class BusinessController {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private UserService userService;

    @Autowired
    private BusinessService businessService;

    @RequestMapping("/workbench/business/index.do")
    public String index(HttpServletRequest request){

        //调用service层方式,查询所有用户
        List<User> userList = userService.queryAllUsers();
        List<Customer> customerList = customerService.queryAllCustomer();

        //把数据保存到request中
        request.setAttribute("userList",userList);
        request.setAttribute("customerList",customerList);

        return "workbench/business/index";
    }

    @RequestMapping("/workbench/business/queryBusinessByPage.do")
    @ResponseBody
    public Object queryBusinessByPage(String custName, String busiType, String busiStatus, int pageNo, int pageSize ){
        //封装参数
        Map<String,Object> map = new HashMap<>();
        map.put("custName",custName);
        map.put("busiType",busiType);
        map.put("busiStatus",busiStatus);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("beginNo",(pageNo-1)*pageSize);

        //调用service层,查询数据
        List<Business> businessList = businessService.queryBusinessByPage(map);
        int count = businessService.queryCountOfBusiness(map);

        //根据查询结果,生成响应数据
        Map<String,Object> retMap = new HashMap<>();
        retMap.put("businessList",businessList);
        retMap.put("count",count);
        return retMap;
    }

    @RequestMapping("/workbench/business/saveBusiness.do")
    @ResponseBody
    public Object saveBusiness(Business business, HttpSession session){
        User user = (User) session.getAttribute(Contants.SESSION_USER);

        //封装参数
        business.setCreateTime(DateUtils.formateDateTime(new Date()));
        business.setCreateUid(user.getId());
        ReturnObject returnObject = new ReturnObject();

        //调用service层,传递数据对象
        try {
            int ret = businessService.saveBusiness(business);

            if (ret > 0) {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("系统忙,请稍后重试.....");
            }
        }catch (Exception e){
            e.printStackTrace();
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("系统忙,请稍后重试.....");
        }
        return returnObject;
    }

    @RequestMapping("/workbench/business/deleteBusiness.do")
    @ResponseBody
    public Object deleteBusiness(long[] id){
        ReturnObject returnObject = new ReturnObject();

        try {
            //调用service层,删除商机管理
            int ret = businessService.deleteBusinessByIds(id);
            if (ret > 0){
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            }else {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("系统忙请稍后");
            }

        }catch (Exception e){
            e.printStackTrace();
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("系统忙请稍后");
        }
        return returnObject;
    }

    @RequestMapping("/workbench/business/queryBusinessById.do")
    @ResponseBody
    public Object queryBusinessById(long id){

        Business business = businessService.queryBusinessById(id);

        return business;
    }

    @RequestMapping("/workbench/business/saveEditBusiness.do")
    @ResponseBody
    public Object saveEditBusiness(Business business){
        ReturnObject returnObject = new ReturnObject();

        try {
            int ret = businessService.saveEditBusiness(business);
            if (ret > 0) {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            } else {
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
