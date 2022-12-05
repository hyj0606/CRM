package com.service.impl;

import com.dao.ChatsMapper;
import com.pojo.Chats;
import com.pojo.Customer;
import com.service.ChatsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @ClassName ChatsServiceImpl
 * @Description TODO
 * @Author hyj98
 * @Date 2022-11-28 16:13
 * @Version 1.0
 */
@Service("chatsService")
public class ChatsServiceImpl implements ChatsService {

    @Autowired
    private ChatsMapper chatsMapper;

    @Override
    public List<Chats> queryChatsByPage(Map<String, Object> map) {
        return chatsMapper.selectChatsByPage(map);
    }

    @Override
    public int queryCountOfChats(Map<String, Object> map) {
        return chatsMapper.selectCountOfChats(map);
    }

    @Override
    public int saveChats(Chats chats) {
        return chatsMapper.insertChats(chats);
    }

    @Override
    public int deleteChatsByIds(String[] ids) {
        return chatsMapper.deleteChatsByIds(ids);
    }

    @Override
    public Chats queryChatsById(long id) {
        return chatsMapper.selectChatsById(id);
    }

    @Override
    public int saveEditChats(Chats chats) {
        return chatsMapper.updateChats(chats);
    }
}
