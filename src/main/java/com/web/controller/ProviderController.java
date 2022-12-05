package com.web.controller;

import com.commons.contants.Contants;
import com.commons.domain.ReturnObject;
import com.commons.utils.DateUtils;
import com.pojo.Goods;
import com.pojo.Provider;
import com.pojo.User;
import com.service.ProviderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName ProviderController
 * @Description TODO
 * @Author hyj98
 * @Date 2022-12-02 11:50
 * @Version 1.0
 */
@Controller
public class ProviderController {

    @Autowired
    private ProviderService providerService;

    @RequestMapping("/workbench/supply/provider/index.do")
    public String index(){

        return "workbench/supply/provider/index";
    }

    @RequestMapping("/workbench/supply/provider/queryProviderByPage.do")
    @ResponseBody
    public Object queryProviderByPage(String providerName, String username, int pageNo, int pageSize){

        Map<String,Object> map = new HashMap<>();
        map.put("providerName",providerName);
        map.put("username",username);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("beginNo",(pageNo-1)*pageSize);

        List<Provider> providerList = providerService.queryProviderByPage(map);
        int count = providerService.queryCountOfProvider(map);

        //根据查询结果,生成响应数据
        Map<String,Object> retMap = new HashMap<>();
        retMap.put("providerList",providerList);
        retMap.put("count",count);

        return retMap;
    }

    @RequestMapping("/workbench/supply/provider/saveProvider.do")
    @ResponseBody
    public Object saveProvider(Provider provider, HttpSession session){

        User user = (User) session.getAttribute(Contants.SESSION_USER);

        //封装参数
        provider.setCreateUid(user.getId());//创建者ID
        String dateTime = DateUtils.formateDateTime(new Date());
        provider.setCreateTime(dateTime);
        ReturnObject returnObject = new ReturnObject();

        try {
            int ret = providerService.saveProvider(provider);

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

    @RequestMapping("/workbench/supply/provider/deleteProvider.do")
    @ResponseBody
    public Object deleteProvider(String[] id){
        ReturnObject returnObject = new ReturnObject();

        try {
            //调用service层,删除聊天记录
            int ret = providerService.deleteProviderByIds(id);

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

    @RequestMapping("/workbench/supply/provider/queryProviderById.do")
    @ResponseBody
    public Object queryProviderById(long id){

        Provider provider = providerService.queryProviderById(id);

        return provider;
    }

    @RequestMapping("/workbench/supply/provider/saveEditProvider.do")
    @ResponseBody
    public Object saveEditProvider(Provider provider){
        ReturnObject returnObject = new ReturnObject();
        try {
            int ret = providerService.saveEditProvider(provider);
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
