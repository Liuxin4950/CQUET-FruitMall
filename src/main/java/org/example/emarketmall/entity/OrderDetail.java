package org.example.emarketmall.entity;

import org.example.emarketmall.common.BaseEntity;

import java.math.BigDecimal;

/**
 * @Description: 订单详情实体类
 * @author: system
 * @date: 2024年12月19日
 */
public class OrderDetail extends BaseEntity {
    /** 订单ID */
    private Integer orderId;
    
    /** 商品ID */
    private Integer productId;
    
    /** 商品名称 */
    private String productName;
    
    /** 购买数量 */
    private Integer amount;
    
    /** 商品价格 */
    private BigDecimal productPrice;
    
    /** 商品信息 */
    private ProductInfo productInfo;

    public OrderDetail() {
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

    public ProductInfo getProductInfo() {
        return productInfo;
    }

    public void setProductInfo(ProductInfo productInfo) {
        this.productInfo = productInfo;
    }

    @Override
    public String toString() {
        return "OrderDetail{" +
                "id=" + getId() +
                ", orderId=" + orderId +
                ", productId=" + productId +
                ", productName='" + productName + '\'' +
                ", amount=" + amount +
                ", productPrice=" + productPrice +
                ", delFlag=" + getDelFlag() +
                ", createdBy='" + getCreatedBy() + '\'' +
                ", createdTime='" + getCreatedTime() + '\'' +
                ", updatedBy='" + getUpdatedBy() + '\'' +
                ", updatedTime='" + getUpdatedTime() + '\'' +
                ", remark='" + getRemark() + '\'' +
                '}';
    }
}