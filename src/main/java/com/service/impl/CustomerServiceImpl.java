package com.service.impl;

import com.dao.CustomerMapper;
import com.pojo.Customer;
import com.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @ClassName CustomerServiceImpl
 * @Description TODO
 * @Author hyj98
 * @Date 2022-11-27 21:05
 * @Version 1.0
 */
@Service("customerService")
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public List<Customer> queryCustomerByPage(Map<String, Object> map) {
        return customerMapper.selectCustomerByPage(map);
    }

    @Override
    public int queryCountOfCustomer(Map<String, Object> map) {
        return customerMapper.selectCountOfCustomer(map);
    }

    @Override
    public int saveCustomer(Customer customer) {
        return customerMapper.insertCustomer(customer);
    }

    @Override
    public int deleteCustomerByIds(String[] ids) {
        return customerMapper.deleteCustomerByIds(ids);
    }

    @Override
    public List<Customer> queryAllCustomer() {
        return customerMapper.selectAllCustomer();
    }

    @Override
    public Customer queryCustomerById(long id) {
        return customerMapper.selectCustomerById(id);
    }

    @Override
    public int saveEditCustomer(Customer customer) {
        return customerMapper.updateCustomer(customer);
    }


}
