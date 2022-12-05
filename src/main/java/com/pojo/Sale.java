package com.pojo;


public class Sale {

    private User user;

    private Customer customer;
    
    private Goods goods;

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

    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_sale.id
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_sale.cust_id
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    private Long custId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_sale.goods_id
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    private Long goodsId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_sale.order_num
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    private Integer orderNum;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_sale.order_price
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    private Double orderPrice;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_sale.sale_time
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    private String saleTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_sale.create_time
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    private String createTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_sale.create_uid
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    private Long createUid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_sale.sale_discount
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    private Double saleDiscount;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_sale.sale_uid
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    private Long saleUid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_sale.desc_info
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    private String descInfo;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_sale.id
     *
     * @return the value of tb_sale.id
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_sale.id
     *
     * @param id the value for tb_sale.id
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_sale.cust_id
     *
     * @return the value of tb_sale.cust_id
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public Long getCustId() {
        return custId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_sale.cust_id
     *
     * @param custId the value for tb_sale.cust_id
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public void setCustId(Long custId) {
        this.custId = custId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_sale.goods_id
     *
     * @return the value of tb_sale.goods_id
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public Long getGoodsId() {
        return goodsId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_sale.goods_id
     *
     * @param goodsId the value for tb_sale.goods_id
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public void setGoodsId(Long goodsId) {
        this.goodsId = goodsId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_sale.order_num
     *
     * @return the value of tb_sale.order_num
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public Integer getOrderNum() {
        return orderNum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_sale.order_num
     *
     * @param orderNum the value for tb_sale.order_num
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_sale.order_price
     *
     * @return the value of tb_sale.order_price
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public Double getOrderPrice() {
        return orderPrice;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_sale.order_price
     *
     * @param orderPrice the value for tb_sale.order_price
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public void setOrderPrice(Double orderPrice) {
        this.orderPrice = orderPrice;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_sale.sale_time
     *
     * @return the value of tb_sale.sale_time
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public String getSaleTime() {
        return saleTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_sale.sale_time
     *
     * @param saleTime the value for tb_sale.sale_time
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public void setSaleTime(String saleTime) {
        this.saleTime = saleTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_sale.create_time
     *
     * @return the value of tb_sale.create_time
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public String getCreateTime() {
        return createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_sale.create_time
     *
     * @param createTime the value for tb_sale.create_time
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_sale.create_uid
     *
     * @return the value of tb_sale.create_uid
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public Long getCreateUid() {
        return createUid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_sale.create_uid
     *
     * @param createUid the value for tb_sale.create_uid
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public void setCreateUid(Long createUid) {
        this.createUid = createUid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_sale.sale_discount
     *
     * @return the value of tb_sale.sale_discount
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public Double getSaleDiscount() {
        return saleDiscount;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_sale.sale_discount
     *
     * @param saleDiscount the value for tb_sale.sale_discount
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public void setSaleDiscount(Double saleDiscount) {
        this.saleDiscount = saleDiscount;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_sale.sale_uid
     *
     * @return the value of tb_sale.sale_uid
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public Long getSaleUid() {
        return saleUid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_sale.sale_uid
     *
     * @param saleUid the value for tb_sale.sale_uid
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public void setSaleUid(Long saleUid) {
        this.saleUid = saleUid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_sale.desc_info
     *
     * @return the value of tb_sale.desc_info
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public String getDescInfo() {
        return descInfo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_sale.desc_info
     *
     * @param descInfo the value for tb_sale.desc_info
     *
     * @mbggenerated Thu Dec 01 12:16:24 CST 2022
     */
    public void setDescInfo(String descInfo) {
        this.descInfo = descInfo == null ? null : descInfo.trim();
    }
}