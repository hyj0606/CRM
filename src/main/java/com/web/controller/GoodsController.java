package com.web.controller;

import com.commons.contants.Contants;
import com.commons.domain.ReturnObject;
import com.commons.utils.DateUtils;
import com.commons.utils.UUIDUtils;
import com.pojo.*;
import com.service.GoodsService;
import com.service.ProviderService;
import org.springframework.beans.factory.annotation.Autowired;
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
 * @ClassName GoodsController
 * @Description TODO
 * @Author hyj98
 * @Date 2022-12-02 11:49
 * @Version 1.0
 */

@Controller
public class GoodsController {

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private ProviderService providerService;

    @RequestMapping("/workbench/supply/goods/index.do")
    public String index(HttpServletRequest request){

        List<Provider> providerList = providerService.queryAllProvider();

        request.setAttribute("providerList",providerList);

        return "workbench/supply/goods/index";
    }

    @RequestMapping("/workbench/supply/goods/queryGoodsByPage.do")
    @ResponseBody
    public Object queryGoodsByPage(String providerName, String goodsName, int pageNo,int pageSize){

        Map<String,Object> map = new HashMap<>();
        map.put("providerName",providerName);
        map.put("goodsName",goodsName);
        map.put("pageNo",pageNo);
        map.put("pageSize",pageSize);
        map.put("beginNo",(pageNo-1)*pageSize);

        List<Goods> goodsList = goodsService.queryGoodsByPage(map);
        int count = goodsService.queryCountOfGoods(map);

        //根据查询结果,生成响应数据
        Map<String,Object> retMap = new HashMap<>();
        retMap.put("goodsList",goodsList);
        retMap.put("count",count);

        return retMap;
    }

    @RequestMapping("/workbench/supply/goods/saveGoods.do")
    @ResponseBody
    public Object saveGoods(HttpSession session,Goods goods, @RequestParam("imgFile") MultipartFile imgFile) throws IOException {

        User user = (User) session.getAttribute(Contants.SESSION_USER);

        //封装参数

        goods.setCreateUid(user.getId());//创建者ID
        String dateTime = DateUtils.formateDateTime(new Date());
        goods.setCreateTime(dateTime);

        String parent = "D:/Code/SSM/Project/BdqnCRM/src/main/webapp/image/";

        String goodsImgFile = imgFile.getOriginalFilename();
        String substring = goodsImgFile.substring(goodsImgFile.lastIndexOf("."));
        String goodsImg = parent + UUIDUtils.getUUID()+substring ;

        imgFile.transferTo(new File(goodsImg));

        goods.setGoodsImg(goodsImg);

        System.out.println(goodsImg);

        ReturnObject returnObject = new ReturnObject();

        try {
            int ret = goodsService.saveGoods(goods);

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

    @RequestMapping("/workbench/supply/goods/deleteGoods.do")
    @ResponseBody
    public Object deleteGoods(long[] id){
        ReturnObject returnObject = new ReturnObject();

        try {
            //调用service层,删除聊天记录
            int ret = goodsService.deleteGoodsByIds(id);

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

    @RequestMapping("/workbench/supply/goods/queryGoodsById.do")
    @ResponseBody
    public Object queryGoodsById(long id){

        Goods goods = goodsService.queryGoodsById(id);

        return goods;
    }

    @RequestMapping("/workbench/supply/goods/saveEditGoods.do")
    @ResponseBody
    public Object saveEditGoods(Goods goods, @RequestParam("imgFile") MultipartFile imgFile){
        ReturnObject returnObject = new ReturnObject();
        try {

            String parent = "D:/Code/SSM/Project/BdqnCRM/src/main/webapp/image/";
            String goodsImgFile = imgFile.getOriginalFilename();
            String substring = goodsImgFile.substring(goodsImgFile.lastIndexOf("."));
            String goodsImg = parent + UUIDUtils.getUUID()+substring ;
            goods.setGoodsImg(goodsImg);

            imgFile.transferTo(new File(goodsImg));

            goods.setGoodsImg(goodsImg);

            int ret = goodsService.saveEditGoods(goods);
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
