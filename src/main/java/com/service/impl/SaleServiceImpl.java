package com.service.impl;

import com.dao.SaleMapper;

import com.pojo.Sale;
import com.service.SaleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @ClassName SaleServiceImpl
 * @Description TODO
 * @Author hyj98
 * @Date 2022-12-03 19:58
 * @Version 1.0
 */
@Service("saleService")
public class SaleServiceImpl implements SaleService {

    @Autowired
    private SaleMapper saleMapper;

    @Override
    public List<Sale> querySaleByPage(Map<String, Object> map) {
        return saleMapper.selectSaleByPage(map);
    }

    @Override
    public int queryCountOfSale(Map<String, Object> map) {
        return saleMapper.selectCountOfSale(map);
    }

    @Override
    public int saveSale(Sale sale) {
        return saleMapper.insertSale(sale);
    }

    @Override
    public int deleteSaleByIds(long[] ids) {
        return saleMapper.deleteSaleByIds(ids);
    }

    @Override
    public Sale querySaleById(long id) {
        return saleMapper.selectSaleById(id);
    }

    @Override
    public int saveEditSale(Sale sale) {
        return saleMapper.updateSale(sale);
    }
}
