package com.dao;

import com.pojo.User;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_user
     *
     * @mbggenerated Sun Nov 27 18:41:12 CST 2022
     */
    int insert(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_user
     *
     * @mbggenerated Sun Nov 27 18:41:12 CST 2022
     */
    int insertSelective(User record);

    /**
     * 根据账号和密码查询用户
     * @param map
     * @return
     */
    User selectUserByNameAndPwd(Map<String,Object> map);

    /**
     * 查询所有用户
     * @return
     */
    List<User> selectAllUsers();

    /**
     * 修改用户资料
     * @param user
     * @return
     */
    int updateUserById(User user);

}