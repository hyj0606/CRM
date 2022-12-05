package com.pojo;

public class Chats {

    private User user;
    private Customer customer;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_chats.id
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_chats.cust_id
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    private Long custId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_chats.concat_type
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    private Integer concatType;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_chats.start_time
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    private String startTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_chats.chat_time
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    private Integer chatTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_chats.chat_content
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    private String chatContent;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_chats.create_time
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    private String createTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_chats.user_id
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    private Long createUid;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_chats.id
     *
     * @return the value of tb_chats.id
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_chats.id
     *
     * @param id the value for tb_chats.id
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_chats.cust_id
     *
     * @return the value of tb_chats.cust_id
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public Long getCustId() {
        return custId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_chats.cust_id
     *
     * @param custId the value for tb_chats.cust_id
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public void setCustId(Long custId) {
        this.custId = custId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_chats.concat_type
     *
     * @return the value of tb_chats.concat_type
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public Integer getConcatType() {
        return concatType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_chats.concat_type
     *
     * @param concatType the value for tb_chats.concat_type
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public void setConcatType(Integer concatType) {
        this.concatType = concatType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_chats.start_time
     *
     * @return the value of tb_chats.start_time
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public String getStartTime() {
        return startTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_chats.start_time
     *
     * @param startTime the value for tb_chats.start_time
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_chats.chat_time
     *
     * @return the value of tb_chats.chat_time
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public Integer getChatTime() {
        return chatTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_chats.chat_time
     *
     * @param chatTime the value for tb_chats.chat_time
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public void setChatTime(Integer chatTime) {
        this.chatTime = chatTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_chats.chat_content
     *
     * @return the value of tb_chats.chat_content
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public String getChatContent() {
        return chatContent;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_chats.chat_content
     *
     * @param chatContent the value for tb_chats.chat_content
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public void setChatContent(String chatContent) {
        this.chatContent = chatContent == null ? null : chatContent.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_chats.create_time
     *
     * @return the value of tb_chats.create_time
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public String getCreateTime() {
        return createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_chats.create_time
     *
     * @param createTime the value for tb_chats.create_time
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_chats.user_id
     *
     * @return the value of tb_chats.user_id
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public Long getCreateUid() {
        return createUid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_chats.user_id
     *
     * @param createUid the value for tb_chats.user_id
     *
     * @mbggenerated Mon Nov 28 15:55:36 CST 2022
     */
    public void setCreateUid(Long createUid) {
        this.createUid = createUid;
    }
}