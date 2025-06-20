package org.example.emarketmall.req;

import java.math.BigDecimal;

/**
 * @Description: 订单商品项请求实体类
 * @author: system
 * @date: 2024年12月19日
 */
public class OrderItemReq {
    /** 商品ID */
    private Integer productId;
    
    /** 商品名称 */
    private String productName;
    
    /** 购买数量 */
    private Integer amount;
    
    /** 商品价格 */
    private BigDecimal productPrice;

    public OrderItemReq() {
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
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
}