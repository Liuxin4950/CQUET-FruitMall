package org.example.emarketmall.entity;

import org.example.emarketmall.common.BaseEntity;

import java.math.BigDecimal;

/**
 * @Description: 购物车实体类
 * @author: system
 * @date: 2024年12月19日
 */
public class OrderCart extends BaseEntity {
    /** 商品ID */
    private String productId;
    
    /** 购买数量 */
    private Integer amount;
    
    /** 商品价格 */
    private BigDecimal price;
    
    /** 用户ID */
    private Integer userId;
    
    /** 是否选中 */
    private Boolean isSelected;
    
    /** 商品名称 */
    private String productName;
    
    /** 商品图片 */
    private String productPic;
    
    /** 商品信息 */
    private ProductInfo productInfo;

    public OrderCart() {
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Boolean getIsSelected() {
        return isSelected;
    }

    public void setIsSelected(Boolean isSelected) {
        this.isSelected = isSelected;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductPic() {
        return productPic;
    }

    public void setProductPic(String productPic) {
        this.productPic = productPic;
    }

    public ProductInfo getProductInfo() {
        return productInfo;
    }

    public void setProductInfo(ProductInfo productInfo) {
        this.productInfo = productInfo;
    }

    @Override
    public String toString() {
        return "OrderCart{" +
                "id=" + getId() +
                ", productId='" + productId + '\'' +
                ", amount=" + amount +
                ", price=" + price +
                ", userId=" + userId +
                ", isSelected=" + isSelected +
                ", productName='" + productName + '\'' +
                ", productPic='" + productPic + '\'' +
                ", delFlag=" + getDelFlag() +
                ", createdBy='" + getCreatedBy() + '\'' +
                ", createdTime='" + getCreatedTime() + '\'' +
                ", updatedBy='" + getUpdatedBy() + '\'' +
                ", updatedTime='" + getUpdatedTime() + '\'' +
                ", remark='" + getRemark() + '\'' +
                '}';
    }
}