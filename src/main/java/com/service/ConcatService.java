package com.service;

import com.pojo.Concat;

import java.util.List;
import java.util.Map;

public interface ConcatService {

    List<Concat> queryConcatByPage(Map<String, Object> map);

    int queryCountOfConcat(Map<String,Object> map);

    int saveConcat(Concat concat);

    int deleteConcatByIds(String[] ids);

    Concat queryConcatById(long id);

    int saveEditConcat(Concat concat);

}
