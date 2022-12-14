package com.dao;

import com.pojo.Chats;
import com.pojo.Goods;
import com.pojo.Provider;

import java.util.List;
import java.util.Map;

public interface ProviderMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_provider
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    int insert(Provider record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_provider
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    int insertSelective(Provider record);

    /**
     * 查询供应商
     * @param map
     * @return
     */
    List<Provider> selectProviderByPage(Map<String,Object> map);

    /**
     * 查询总数
     * @param map
     * @return
     */
    int selectCountOfProvider(Map<String,Object> map);

    /**
     * 添加供应商
     * @param provider
     * @return
     */
    int insertProvider(Provider provider);

    /**
     * 查询所有供应商
     * @return
     */
    List<Provider> selectAllProvider();

    /**
     * 删除供应商
     * @param ids
     * @return
     */
    int deleteProviderByIds(String[] ids);

    /**
     * 根据id查询供应商
     * @param id
     * @return
     */
    Provider selectProviderById(long id);

    /**
     * 保存修改供应商信息
     * @param provider
     * @return
     */
    int updateProvider(Provider provider);

}