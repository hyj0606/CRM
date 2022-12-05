package com.service.impl;

import com.dao.GoodsMapper;
import com.pojo.Goods;
import com.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @ClassName GoodsServiceImpl
 * @Description TODO
 * @Author hyj98
 * @Date 2022-12-02 14:11
 * @Version 1.0
 */
@Service("goodsService")
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private GoodsMapper goodsMapper;

    @Override
    public List<Goods> queryGoodsByPage(Map<String, Object> map) {
        return goodsMapper.selectGoodsByPage(map);
    }

    @Override
    public int queryCountOfGoods(Map<String, Object> map) {
        return goodsMapper.selectCountOfGoods(map);
    }

    @Override
    public int saveGoods(Goods goods) {
        return goodsMapper.insertGoods(goods);
    }

    @Override
    public int deleteGoodsByIds(long[] ids) {
        return goodsMapper.deleteGoodsByIds(ids);
    }

    @Override
    public Goods queryGoodsById(long id) {
        return goodsMapper.selectGoodsById(id);
    }

    @Override
    public int saveEditGoods(Goods goods) {
        return goodsMapper.updateGoods(goods);
    }

    @Override
    public List<Goods> queryAllGoods() {
        return goodsMapper.selectAllGoods();
    }
}
