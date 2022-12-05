package com.service;

import com.pojo.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    User queryUserByNameAndPwd(Map<String,Object> map);

    int updateUserById(User user);

    List<User> queryAllUsers();

}
