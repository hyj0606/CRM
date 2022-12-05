package com.service;

import com.pojo.Provider;

import java.util.List;
import java.util.Map;

public interface ProviderService {

    List<Provider> queryProviderByPage(Map<String,Object> map);

    int queryCountOfProvider(Map<String,Object> map);

    int saveProvider(Provider provider);

    int deleteProviderByIds(String[] ids);

    List<Provider> queryAllProvider();

    Provider queryProviderById(long id);

    int saveEditProvider(Provider provider);
}
