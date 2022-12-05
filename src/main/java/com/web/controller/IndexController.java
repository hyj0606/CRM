package com.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @ClassName IndexController
 * @Description 进入登录界面入口
 * @Author hyj98
 * @Date 2022-11-25 17:05
 * @Version 1.0
 */
@Controller
public class IndexController {

    /*
    * 理论上: 给Controller方法分配url: http://localhost:8080/CRM/
    * 为了简便,协议://ip:port/应用名称必须省去,用/代表应用根目录下的/
    * */
    @RequestMapping("/")
    public String index(){
        //请求转发
        return "index";//理论上: /WEB-INF/pages/index.jsp 实际上: index(前缀和后缀在视图解析器中)
    }

}
