package com.service;

import com.pojo.Goods;

import java.util.List;
import java.util.Map;

public interface GoodsService {

    List<Goods> queryGoodsByPage(Map<String,Object> map);

    int queryCountOfGoods(Map<String,Object> map);

    int saveGoods(Goods goods);

    int deleteGoodsByIds(long[] ids);

    Goods queryGoodsById(long id);

    int saveEditGoods(Goods goods);

    List<Goods> queryAllGoods();

}
