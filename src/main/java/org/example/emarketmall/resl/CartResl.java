package org.example.emarketmall.resl;

import java.math.BigDecimal;

/**
 * @Description: 购物车响应实体类
 * @author: system
 * @date: 2024年12月19日
 */
public class CartResl {
    /** 购物车ID */
    private Integer id;
    
    /** 商品ID */
    private String productId;
    
    /** 商品编码 */
    private String productCode;
    
    /** 商品名称 */
    private String productName;
    
    /** 购买数量 */
    private Integer amount;
    
    /** 商品价格 */
    private BigDecimal price;
    
    /** 小计金额 */
    private BigDecimal subtotal;
    
    /** 用户ID */
    private Integer userId;
    
    /** 是否选中 */
    private Boolean isSelected;
    
    /** 商品图片 */
    private String productPic;
    
    /** 商品描述 */
    private String description;
    
    /** 商品重量单位 */
    private String weightUnit;
    
    /** 商品产地 */
    private String originPlace;
    
    /** 商品库存 */
    private Integer stock;
    
    /** 是否有库存 */
    private Boolean hasStock;

    public CartResl() {
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
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

    public String getProductPic() {
        return productPic;
    }

    public void setProductPic(String productPic) {
        this.productPic = productPic;
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

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public Boolean getHasStock() {
        return hasStock;
    }

    public void setHasStock(Boolean hasStock) {
        this.hasStock = hasStock;
    }
}