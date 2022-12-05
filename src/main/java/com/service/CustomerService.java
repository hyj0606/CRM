package com.service;

import com.pojo.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerService {

    List<Customer> queryCustomerByPage(Map<String,Object> map);

    int queryCountOfCustomer(Map<String,Object> map);

    int saveCustomer(Customer customer);

    int deleteCustomerByIds(String[] ids);

    List<Customer> queryAllCustomer();

    Customer queryCustomerById(long id);

    int saveEditCustomer(Customer customer);

}
