package com.web.controller;

import com.commons.contants.Contants;
import com.commons.domain.ReturnObject;
import com.commons.utils.DateUtils;
import com.pojo.User;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.support.JstlUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName UserController
 * @Description TODO
 * @Author hyj98
 * @Date 2022-11-25 22:02
 * @Version 1.0
 */

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * url要和当前controller方法处理完请求之后，响应信息返回的页面的资源目录保持一致
     * @return
     */
    @RequestMapping("/settings/qx/user/toLogin.do")
    public String toLogin(){

        //请求转发到登录界面
        return "settings/qx/user/login";
    }

    @RequestMapping("/settings/qx/user/login.do")/*响应信息的位置就是url*/
    @ResponseBody
    public Object login(String username, String password, HttpServletRequest request, HttpServletResponse response, HttpSession session){
        //封装参数
        Map<String,Object> map = new HashMap<>();
        map.put("username",username);
        map.put("password",password);

        //调用service层方法,查询用户
        User user = userService.queryUserByNameAndPwd(map);

        //根据查询结果,,生成响应信息
        ReturnObject returnObject = new ReturnObject();
        if (user==null){
            //登录失败,用户名或密码错误
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("用户名或密码错误");
        }else {//进一步判断账号是否合法
            //登录成功
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);

            //将登录时间存入至数据表中
            user.setLastLoginTime(DateUtils.formateDateTime(new Date()));
            userService.updateUserById(user);

            //把user保存到session中
            session.setAttribute(Contants.SESSION_USER,user);
         }
        return returnObject;
    }

    @RequestMapping("/workbench/update/index.do")
    @ResponseBody
    public Object update(User user,HttpSession session){
        ReturnObject returnObject = new ReturnObject();

        User user1 = (User) session.getAttribute(Contants.SESSION_USER);
        user.setId(user1.getId());
        user.setUsername(user1.getUsername());
        if (user.getPassword().equals(user1.getPassword())){
            returnObject.setRetData(Contants.RETURN_OBJECT_CODE_SUCCESS);
        }
        try {
            int ret = userService.updateUserById(user);
            if (ret > 0) {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("系统忙,请稍后...");
            }
        }catch (Exception e){
            e.printStackTrace();
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("系统忙,请稍后...");
        }
        return returnObject;
    }

    @RequestMapping("/settings/qx/user/logout.do")
    public String logout(HttpSession session){
        //销毁session
        session.invalidate();

        //跳转到首页
        return "redirect:/"; //借助springMVC来重定向,response.sendRedirect("/CRM/");
    }

}
