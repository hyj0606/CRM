package com.dao;

import com.pojo.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_customer
     *
     * @mbggenerated Mon Nov 28 15:36:29 CST 2022
     */
    int insert(Customer record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_customer
     *
     * @mbggenerated Mon Nov 28 15:36:29 CST 2022
     */
    int insertSelective(Customer record);

    /**
     * 查询客户信息
     * @param map
     * @return
     */
    List<Customer> selectCustomerByPage(Map<String,Object> map);

    /**
     * 查询记录数
     * @param map
     * @return
     */
    int selectCountOfCustomer(Map<String,Object> map);

    /**
     * 添加新客户信息
     * @param customer
     * @return
     */
    int insertCustomer(Customer customer);

    /**
     * 删除客户信息
     * @param ids
     * @return
     */
    int deleteCustomerByIds(String[] ids);

    /**
     * 查询所有客户信息
     * @return
     */
    List<Customer> selectAllCustomer();

    /**
     * 根据id查询客户信息
     * @param id
     * @return
     */
    Customer selectCustomerById(long id);

    /**
     * 保存修改的客户信息
     * @param customer
     * @return
     */
    int updateCustomer(Customer customer);
}