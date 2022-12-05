package com.service;

import com.pojo.Goods;
import com.pojo.Sale;

import java.util.List;
import java.util.Map;

public interface SaleService {

    List<Sale> querySaleByPage(Map<String,Object> map);

    int queryCountOfSale(Map<String,Object> map);

    int saveSale(Sale sale);

    int deleteSaleByIds(long[] ids);

    Sale querySaleById(long id);

    int saveEditSale(Sale sale);

}
