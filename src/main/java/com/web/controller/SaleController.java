package com.web.controller;

import com.commons.contants.Contants;
import com.commons.domain.ReturnObject;
import com.commons.utils.DateUtils;
import com.pojo.*;
import com.service.CustomerService;
import com.service.GoodsService;
import com.service.SaleService;
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
 * @ClassName SaleController
 * @Description TODO
 * @Author hyj98
 * @Date 2022-12-02 11:35
 * @Version 1.0
 */
@Controller
public class SaleController {

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private UserService userService;

    @Autowired
    private SaleService saleService;

    @RequestMapping("/workbench/sale/index.do")
    public String index(HttpServletRequest request){

        //调用service层方式,查询所有用户
        List<User> userList = userService.queryAllUsers();
        List<Customer> customerList = customerService.queryAllCustomer();
        List<Goods> goodsList = goodsService.queryAllGoods();

        //把数据保存到request中
        request.setAttribute("userList",userList);
        request.setAttribute("customerList",customerList);
        request.setAttribute("goodsList",goodsList);

        return "workbench/sale/index";
    }

    @RequestMapping("/workbench/sale/querySaleByPage.do")
    @ResponseBody
    public Object querySaleByPage(String custName, String goodsName, int pageNo, int pageSize){

        //封装参数
        Map<String, Object> map = new HashMap<>();
        map.put("custName",custName);
        map.put("goodsName",goodsName);
        map.put("pageSize",pageSize);
        map.put("beginNo",(pageNo-1)*pageSize);

        //调用service层,查询数据
        List<Sale> saleList = saleService.querySaleByPage(map);
        int count = saleService.queryCountOfSale(map);
        //根据查询结果,生成响应数据
        Map<String, Object> retMap = new HashMap<>();
        retMap.put("saleList",saleList);
        retMap.put("count",count);
        return retMap;
    }

    @RequestMapping("/workbench/sale/saveSale.do")
    @ResponseBody
    public Object saveSale(Sale sale, HttpSession session){
        User user = (User) session.getAttribute(Contants.SESSION_USER);

        //封装参数
        sale.setCreateTime(DateUtils.formateDateTime(new Date()));
        sale.setCreateUid(user.getId());
        ReturnObject returnObject = new ReturnObject();

        //调用service层,传递数据对象
        try {
            int ret = saleService.saveSale(sale);

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

    @RequestMapping("/workbench/sale/deleteSale.do")
    @ResponseBody
    public Object deleteSale(long[] id){
        ReturnObject returnObject = new ReturnObject();

        try {
            //调用service层,删除商机管理
            int ret = saleService.deleteSaleByIds(id);
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

    @RequestMapping("/workbench/sale/querySaleById.do")
    @ResponseBody
    public Object querySaleById(long id){

        Sale sale = saleService.querySaleById(id);

        return sale;
    }

    @RequestMapping("/workbench/sale/saveEditSale.do")
    @ResponseBody
    public Object saveEditSale(Sale sale){
        ReturnObject returnObject = new ReturnObject();

        try {
            int ret = saleService.saveEditSale(sale);
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
