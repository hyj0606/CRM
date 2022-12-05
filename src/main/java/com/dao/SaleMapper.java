package com.dao;

import com.pojo.Chats;
import com.pojo.Sale;

import java.util.List;
import java.util.Map;

public interface SaleMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_sale
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    int insert(Sale record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_sale
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    int insertSelective(Sale record);

    /**
     * 查询销售记录
     * @param map
     * @return
     */
    List<Sale> selectSaleByPage(Map<String,Object> map);

    /**
     * 销售记录总数
     * @param map
     * @return
     */
    int selectCountOfSale(Map<String,Object> map);

    /**
     * 添加新销售记录
     * @param sale
     * @return
     */
    int insertSale(Sale sale);

    /**
     * 删除销售记录
     * @param ids
     * @return
     */
    int deleteSaleByIds(long[] ids);

    /**
     * 根据id查询销售记录
     * @param id
     * @return
     */
    Sale selectSaleById(long id);

    /**
     * 保存修改销售记录信息
     * @param sale
     * @return
     */
    int updateSale(Sale sale);
}