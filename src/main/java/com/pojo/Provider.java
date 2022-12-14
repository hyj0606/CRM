package com.pojo;


public class Provider {

    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_provider.id
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_provider.provider_name
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    private String providerName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_provider.telphone
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    private String telphone;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_provider.email
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    private String email;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_provider.bank
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    private String bank;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_provider.net_address
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    private String netAddress;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_provider.address
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    private String address;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_provider.create_time
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    private String createTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_provider.create_uid
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    private Long createUid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_provider.desc_info
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    private String descInfo;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_provider.id
     *
     * @return the value of tb_provider.id
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_provider.id
     *
     * @param id the value for tb_provider.id
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_provider.provider_name
     *
     * @return the value of tb_provider.provider_name
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public String getProviderName() {
        return providerName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_provider.provider_name
     *
     * @param providerName the value for tb_provider.provider_name
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public void setProviderName(String providerName) {
        this.providerName = providerName == null ? null : providerName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_provider.telphone
     *
     * @return the value of tb_provider.telphone
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public String getTelphone() {
        return telphone;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_provider.telphone
     *
     * @param telphone the value for tb_provider.telphone
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public void setTelphone(String telphone) {
        this.telphone = telphone == null ? null : telphone.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_provider.email
     *
     * @return the value of tb_provider.email
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public String getEmail() {
        return email;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_provider.email
     *
     * @param email the value for tb_provider.email
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_provider.bank
     *
     * @return the value of tb_provider.bank
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public String getBank() {
        return bank;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_provider.bank
     *
     * @param bank the value for tb_provider.bank
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public void setBank(String bank) {
        this.bank = bank == null ? null : bank.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_provider.net_address
     *
     * @return the value of tb_provider.net_address
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public String getNetAddress() {
        return netAddress;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_provider.net_address
     *
     * @param netAddress the value for tb_provider.net_address
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public void setNetAddress(String netAddress) {
        this.netAddress = netAddress == null ? null : netAddress.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_provider.address
     *
     * @return the value of tb_provider.address
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public String getAddress() {
        return address;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_provider.address
     *
     * @param address the value for tb_provider.address
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_provider.create_time
     *
     * @return the value of tb_provider.create_time
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public String getCreateTime() {
        return createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_provider.create_time
     *
     * @param createTime the value for tb_provider.create_time
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_provider.create_uid
     *
     * @return the value of tb_provider.create_uid
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public Long getCreateUid() {
        return createUid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_provider.create_uid
     *
     * @param createUid the value for tb_provider.create_uid
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public void setCreateUid(Long createUid) {
        this.createUid = createUid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_provider.desc_info
     *
     * @return the value of tb_provider.desc_info
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public String getDescInfo() {
        return descInfo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_provider.desc_info
     *
     * @param descInfo the value for tb_provider.desc_info
     *
     * @mbggenerated Thu Dec 01 12:18:53 CST 2022
     */
    public void setDescInfo(String descInfo) {
        this.descInfo = descInfo == null ? null : descInfo.trim();
    }
}