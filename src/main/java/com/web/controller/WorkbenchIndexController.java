package com.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @ClassName WorkbenchIndexController
 * @Description 进入业务首页
 * @Author hyj98
 * @Date 2022-11-26 16:47
 * @Version 1.0
 */

@Controller
public class WorkbenchIndexController {

    @RequestMapping("/workbench/index.do")
    public String index(){
        //跳转到业务主页面
        return "workbench/index";
    }
}
