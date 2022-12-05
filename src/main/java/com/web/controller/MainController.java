package com.web.controller;

import com.pojo.Customer;
import com.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName MainController
 * @Description TODO
 * @Author hyj98
 * @Date 2022-11-26 22:23
 * @Version 1.0
 */

@Controller
public class MainController {

    @Autowired
    private CustomerService customerService;

    @RequestMapping("/workbench/main/index.do")
    public String index(){
        //跳转到main/index.jsp
        return "workbench/main/index";
    }

    @RequestMapping("/workbench/main/queryCustomerByPage.do")
    @ResponseBody
    public Object queryCustomerByPage(String type, String status, int pageNo, int pageSize ){

        //封装参数
        Map<String,Object> map = new HashMap<>();
        map.put("type",type);
        map.put("status",status);
        map.put("type",type);
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

}
