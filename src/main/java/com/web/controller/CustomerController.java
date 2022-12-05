package com.web.controller;

import com.commons.contants.Contants;
import com.commons.domain.ReturnObject;
import com.commons.utils.DateUtils;
import com.pojo.Customer;
import com.pojo.User;
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
 * @ClassName CustomerController
 * @Description TODO
 * @Author hyj98
 * @Date 2022-11-28 10:03
 * @Version 1.0
 */

@Controller
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private UserService userService;

    @RequestMapping("/workbench/customer/index.do")
    public String index(HttpServletRequest request){
        //调用service层方式,查询所有用户
        List<User> userList = userService.queryAllUsers();

        //把数据保存到request中
        request.setAttribute("userList",userList);
        
        return "workbench/customer/index";
    }

    @RequestMapping("/workbench/customer/queryCustomerByPage.do")
    @ResponseBody
    public Object queryCustomerByPage(String type, String status, String custName, int pageNo, int pageSize, HttpSession session ){

        //封装参数
        Map<String,Object> map = new HashMap<>();
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        map.put("userId",user.getId());
        map.put("custName",custName);
        map.put("type",type);
        map.put("status",status);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("beginNo",(pageNo-1)*pageSize);

        //调用service层,查询数据
        List<Customer> customerList = customerService.queryCustomerByPage(map);
        int count = customerService.queryCountOfCustomer(map);
        //根据查询结果,生成响应数据
        Map<String, Object> retMap = new HashMap<>();
        retMap.put("customerList",customerList);
        retMap.put("count",count);

        return retMap;
    }


    @RequestMapping("/workbench/customer/saveCustomer.do")
    @ResponseBody
    public Object saveCustomer(Customer customer, HttpSession session){

        User user = (User) session.getAttribute(Contants.SESSION_USER);

        //封装参数
        customer.setCreateUid(user.getId());//创建者ID
        String dateTime = DateUtils.formateDateTime(new Date());
        customer.setCreateTime(dateTime);
        ReturnObject returnObject = new ReturnObject();

        try {
            int ret = customerService.saveCustomer(customer);

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

    @RequestMapping("/workbench/customer/deleteCustomer.do")
    @ResponseBody
    public Object deleteCustomer(String[] id){
        ReturnObject returnObject = new ReturnObject();
        try {
            //调用service层,删除市场活动
            int ret = customerService.deleteCustomerByIds(id);
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

    @RequestMapping("/workbench/customer/queryCustomerById.do")
    @ResponseBody
    public Object queryCustomerById(long id){

        //调用service层,查询市场活动
        Customer customer = customerService.queryCustomerById(id);

        //根据查询结果返回响应类型
        return customer;
    }

    @RequestMapping("/workbench/customer/saveEditCustomer.do")
    @ResponseBody
    public Object saveEditCustomer(Customer customer){
        ReturnObject returnObject = new ReturnObject();

        try {
            int ret = customerService.saveEditCustomer(customer);
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
