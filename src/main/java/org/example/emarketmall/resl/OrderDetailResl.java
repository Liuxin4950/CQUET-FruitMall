package org.example.emarketmall.resl;

import java.math.BigDecimal;

/**
 * @Description: 订单详情响应实体类
 * @author: system
 * @date: 2024年12月19日
 */
public class OrderDetailResl {
    /** 订单详情ID */
    private Integer id;
    
    /** 订单ID */
    private Integer orderId;
    
    /** 商品ID */
    private Integer productId;
    
    /** 商品编码 */
    private String productCode;
    
    /** 商品名称 */
    private String productName;
    
    /** 购买数量 */
    private Integer amount;
    
    /** 商品价格 */
    private BigDecimal productPrice;
    
    /** 小计金额 */
    private BigDecimal subtotal;
    
    /** 商品图片 */
    private String imageUrl;
    
    /** 商品描述 */
    private String description;
    
    /** 商品重量单位 */
    private String weightUnit;
    
    /** 商品产地 */
    private String originPlace;

    public OrderDetailResl() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public BigDecimal getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(BigDecimal productPrice) {
        this.productPrice = productPrice;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getWeightUnit() {
        return weightUnit;
    }

    public void setWeightUnit(String weightUnit) {
        this.weightUnit = weightUnit;
    }

    public String getOriginPlace() {
        return originPlace;
    }

    public void setOriginPlace(String originPlace) {
        this.originPlace = originPlace;
    }
}