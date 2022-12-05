package com.service.impl;

import com.dao.ProviderMapper;
import com.pojo.Goods;
import com.pojo.Provider;
import com.service.ProviderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @ClassName ProviderServiceImpl
 * @Description TODO
 * @Author hyj98
 * @Date 2022-12-02 15:42
 * @Version 1.0
 */
@Service("providerService")
public class ProviderServiceImpl implements ProviderService {

    @Autowired
    private ProviderMapper providerMapper;

    @Override
    public List<Provider> queryProviderByPage(Map<String, Object> map) {
        return providerMapper.selectProviderByPage(map);
    }

    @Override
    public int queryCountOfProvider(Map<String, Object> map) {
        return providerMapper.selectCountOfProvider(map);
    }

    @Override
    public int saveProvider(Provider provider) {
        return providerMapper.insertProvider(provider);
    }

    @Override
    public int deleteProviderByIds(String[] ids) {
        return providerMapper.deleteProviderByIds(ids);
    }

    @Override
    public List<Provider> queryAllProvider() {
        return providerMapper.selectAllProvider();
    }

    @Override
    public Provider queryProviderById(long id) {
        return providerMapper.selectProviderById(id);
    }

    @Override
    public int saveEditProvider(Provider provider) {
        return providerMapper.updateProvider(provider);
    }
}
