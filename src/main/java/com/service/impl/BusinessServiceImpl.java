package com.service.impl;

import com.dao.BusinessMapper;
import com.pojo.Business;
import com.service.BusinessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @ClassName BusinessServiceImpl
 * @Description TODO
 * @Author hyj98
 * @Date 2022-12-01 14:24
 * @Version 1.0
 */
@Service("businessService")
public class BusinessServiceImpl implements BusinessService {

    @Autowired
    private BusinessMapper businessMapper;

    @Override
    public List<Business> queryBusinessByPage(Map<String, Object> map) {
        return businessMapper.selectBusinessByPage(map);
    }

    @Override
    public int queryCountOfBusiness(Map<String, Object> map) {
        return businessMapper.selectCountOfCustomer(map);
    }

    @Override
    public int saveBusiness(Business business) {
        return businessMapper.insertBusiness(business);
    }

    @Override
    public int deleteBusinessByIds(long[] ids) {
        return businessMapper.deleteBusinessByIds(ids);
    }

    @Override
    public Business queryBusinessById(long id) {
        return businessMapper.selectBusinessById(id);
    }

    @Override
    public int saveEditBusiness(Business business) {
        return businessMapper.updateBusiness(business);
    }
}
