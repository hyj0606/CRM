package com.service.impl;

import com.dao.ConcatMapper;
import com.pojo.Concat;
import com.service.ConcatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @ClassName ConcatServiceImpl
 * @Description TODO
 * @Author hyj98
 * @Date 2022-11-29 16:21
 * @Version 1.0
 */
@Service("concatService")
public class ConcatServiceImpl implements ConcatService {

    @Autowired
    private ConcatMapper concatMapper;

    @Override
    public List<Concat> queryConcatByPage(Map<String, Object> map) {
        return concatMapper.selectConcatByPage(map);
    }

    @Override
    public int queryCountOfConcat(Map<String, Object> map) {
        return concatMapper.selectCountOfConcat(map);
    }

    @Override
    public int saveConcat(Concat concat) {
        return concatMapper.insertConcat(concat);
    }

    @Override
    public int deleteConcatByIds(String[] ids) {
        return concatMapper.deleteConcatByIds(ids);
    }

    @Override
    public Concat queryConcatById(long id) {
        return concatMapper.selectConcatById(id);
    }

    @Override
    public int saveEditConcat(Concat concat) {
        return concatMapper.updateConcat(concat);
    }
}
