package com.service;

import com.pojo.Business;

import java.util.List;
import java.util.Map;

public interface BusinessService {

    List<Business> queryBusinessByPage(Map<String,Object> map);

    int queryCountOfBusiness(Map<String,Object> map);

    int saveBusiness(Business business);

    int deleteBusinessByIds(long[] ids);

    Business queryBusinessById(long id);

    int saveEditBusiness(Business business);

}
