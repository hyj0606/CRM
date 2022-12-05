package com.web.controller;

import com.commons.contants.Contants;
import com.commons.domain.ReturnObject;
import com.commons.utils.DateUtils;
import com.commons.utils.UUIDUtils;
import com.pojo.Concat;
import com.pojo.Customer;
import com.pojo.User;
import com.service.ConcatService;
import com.service.CustomerService;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.nativejdbc.OracleJdbc4NativeJdbcExtractor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName ConcatController
 * @Description TODO
 * @Author hyj98
 * @Date 2022-11-29 15:07
 * @Version 1.0
 */
@Controller
public class ConcatController {

    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private ConcatService concatService;

    @RequestMapping("/workbench/concat/index.do")
    public String index(HttpServletRequest request){

        //调用service层方式,查询所有用户
        List<User> userList = userService.queryAllUsers();
        List<Customer> customerList = customerService.queryAllCustomer();

        //把数据保存到request中
        request.setAttribute("userList",userList);
        request.setAttribute("customerList",customerList);

        return "workbench/concat/index";
    }

    @RequestMapping("/workbench/concat/queryConcatByPage.do")
    @ResponseBody
    public Object queryConcatByPage(String username, String custName, String concatName , int pageNo, int pageSize){

        //封装参数
        Map<String,Object> map = new HashMap<>();
        map.put("custName",custName);
        map.put("concatName",concatName);
        map.put("username",username);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("beginNo",(pageNo-1)*pageSize);

        //调用service层,查询数据
        List<Concat> concatList = concatService.queryConcatByPage(map);
        int count = concatService.queryCountOfConcat(map);

        //根据查询结果,生成响应数据
        Map<String,Object> retMap = new HashMap<>();
        retMap.put("concatList",concatList);
        retMap.put("count",count);
        return retMap;
    }

    @RequestMapping("/workbench/concat/saveConcat.do")
    @ResponseBody
    public Object saveConcat(Concat concat, HttpSession session,@RequestParam("imgFile") MultipartFile imgFile) throws IOException {
        ReturnObject returnObject = new ReturnObject();
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        concat.setCreateId(user.getId());
        concat.setCreateTime(DateUtils.formateDateTime(new Date()));

        String parent = "D:/Code/SSM/Project/BdqnCRM/src/main/webapp/image/";
        String goodsImgFile = imgFile.getOriginalFilename();
        String substring = goodsImgFile.substring(goodsImgFile.lastIndexOf("."));
        String photo = parent + UUIDUtils.getUUID()+substring ;
        imgFile.transferTo(new File(photo));
        concat.setPhoto(photo);

        try {
            int ret = concatService.saveConcat(concat);
            if (ret > 0) {
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

    @RequestMapping("/workbench/concat/deleteConcat.do")
    @ResponseBody
    public Object deleteConcat(String[] id){
        ReturnObject returnObject = new ReturnObject();

        try {
            //调用service层,实现删除添加的传递
            int ret = concatService.deleteConcatByIds(id);
            if (ret > 0){
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            }else {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("系统忙,请稍后重试");
            }

        }catch (Exception e){
            e.printStackTrace();
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("系统忙,请稍后重试");
        }
        return returnObject;
    }

    @RequestMapping("/workbench/concat/queryConcatById.do")
    @ResponseBody
    public Object queryConcatById(long id){
        Concat concat = concatService.queryConcatById(id);

        return concat;
    }

    @RequestMapping("/workbench/concat/saveEditConcat.do")
    @ResponseBody
    public Object saveEditConcat(Concat concat,@RequestParam("imgFile") MultipartFile imgFile){
        ReturnObject returnObject = new ReturnObject();

        try {

            String parent = "D:/Code/SSM/Project/BdqnCRM/src/main/webapp/image/";
            String goodsImgFile = imgFile.getOriginalFilename();
            String substring = goodsImgFile.substring(goodsImgFile.lastIndexOf("."));
            String photo = parent + UUIDUtils.getUUID()+substring ;
            imgFile.transferTo(new File(photo));
            concat.setPhoto(photo);

            int ret = concatService.saveEditConcat(concat);
            if (ret > 0){
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            }else {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("系统忙,请稍后重试...");
            }
        }catch (Exception e){
            e.printStackTrace();
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("系统忙,请稍后重试...");
        }

        return returnObject;
    }

}
