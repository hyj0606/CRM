package com.service;

import com.pojo.Chats;
import com.pojo.Customer;

import java.util.List;
import java.util.Map;

public interface ChatsService {

    List<Chats> queryChatsByPage(Map<String,Object> map);

    int queryCountOfChats(Map<String,Object> map);

    int saveChats(Chats chats);

    int deleteChatsByIds(String[] ids);

    Chats queryChatsById(long id);

    int saveEditChats(Chats chats);

}
