package org.example.emarketmall.req;

import java.math.BigDecimal;

/**
 * @Description: 购物车请求实体类
 * @author: system
 * @date: 2024年12月19日
 */
public class CartReq {
    /** 购物车ID（更新时使用） */
    private Integer id;
    
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

    public CartReq() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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
}