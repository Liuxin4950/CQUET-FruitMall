package org.example.emarketmall.entity;

import org.example.emarketmall.common.BaseEntity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 商品信息
 */
public class ProductInfo extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 商品编码
     */
    private String productCode;

    /**
     * 商品名称
     */
    private String productName;

    /**
     * 一级分类ID
     */
    private Integer oneCategoryId;

    /**
     * 二级分类ID
     */
    private Integer twoCategoryId;

    /**
     * 商品价格
     */
    private BigDecimal price;

    /**
     * 上下架状态
     */
    private Integer publishStatus;

    /**
     * 生成日期
     */
    private Date productionDate;

    /**
     * 商品有效期（天数）
     */
    private Integer shelfLife;

    /**
     * 商品描述
     */
    private String description;

    /**
     * 产地
     */
    private String originPlace;

    /**
     * 储存方式
     */
    private String storageMethod;

    /**
     * 营养信息
     */
    private String nutritionInfo;

    /**
     * 重量单位
     */
    private String weightUnit;

    /**
     * 是否有机食品
     */
    private Boolean isOrganic;

    /**
     * 是否季节性商品
     */
    private Boolean isSeasonal;

    /**
     * 折扣价格
     */
    private BigDecimal discountPrice;

    /**
     * 库存数量
     */
    private Integer stock;

    /**
     * 商品图片URL
     */
    private String imageUrl;

    /**
     * 商品编码
     */
    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    /**
     * 商品编码
     */
    public String getProductCode() {
        return productCode;
    }

    /**
     * 商品名称
     */
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /**
     * 商品名称
     */
    public String getProductName() {
        return productName;
    }

    /**
     * 一级分类ID
     */
    public void setOneCategoryId(Integer oneCategoryId) {
        this.oneCategoryId = oneCategoryId;
    }

    /**
     * 一级分类ID
     */
    public Integer getOneCategoryId() {
        return oneCategoryId;
    }

    /**
     * 二级分类ID
     */
    public void setTwoCategoryId(Integer twoCategoryId) {
        this.twoCategoryId = twoCategoryId;
    }

    /**
     * 二级分类ID
     */
    public Integer getTwoCategoryId() {
        return twoCategoryId;
    }

    /**
     * 商品价格
     */
    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    /**
     * 商品价格
     */
    public BigDecimal getPrice() {
        return price;
    }

    /**
     * 上下架状态
     */
    public void setPublishStatus(Integer publishStatus) {
        this.publishStatus = publishStatus;
    }

    /**
     * 上下架状态
     */
    public Integer getPublishStatus() {
        return publishStatus;
    }

    /**
     * 生成日期
     */
    public void setProductionDate(Date productionDate) {
        this.productionDate = productionDate;
    }

    /**
     * 生成日期
     */
    public Date getProductionDate() {
        return productionDate;
    }

    /**
     * 商品有效期（天数）
     */
    public void setShelfLife(Integer shelfLife) {
        this.shelfLife = shelfLife;
    }

    /**
     * 商品有效期（天数）
     */
    public Integer getShelfLife() {
        return shelfLife;
    }

    /**
     * 商品描述
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * 商品描述
     */
    public String getDescription() {
        return description;
    }

    /**
     * 产地
     */
    public void setOriginPlace(String originPlace) {
        this.originPlace = originPlace;
    }

    /**
     * 产地
     */
    public String getOriginPlace() {
        return originPlace;
    }

    /**
     * 储存方式
     */
    public void setStorageMethod(String storageMethod) {
        this.storageMethod = storageMethod;
    }

    /**
     * 储存方式
     */
    public String getStorageMethod() {
        return storageMethod;
    }

    /**
     * 营养信息
     */
    public void setNutritionInfo(String nutritionInfo) {
        this.nutritionInfo = nutritionInfo;
    }

    /**
     * 营养信息
     */
    public String getNutritionInfo() {
        return nutritionInfo;
    }

    /**
     * 重量单位
     */
    public void setWeightUnit(String weightUnit) {
        this.weightUnit = weightUnit;
    }

    /**
     * 重量单位
     */
    public String getWeightUnit() {
        return weightUnit;
    }

    /**
     * 是否有机食品
     */
    public void setIsOrganic(Boolean isOrganic) {
        this.isOrganic = isOrganic;
    }

    /**
     * 是否有机食品
     */
    public Boolean getIsOrganic() {
        return isOrganic;
    }

    /**
     * 是否季节性商品
     */
    public void setIsSeasonal(Boolean isSeasonal) {
        this.isSeasonal = isSeasonal;
    }

    /**
     * 是否季节性商品
     */
    public Boolean getIsSeasonal() {
        return isSeasonal;
    }

    /**
     * 折扣价格
     */
    public void setDiscountPrice(BigDecimal discountPrice) {
        this.discountPrice = discountPrice;
    }

    /**
     * 折扣价格
     */
    public BigDecimal getDiscountPrice() {
        return discountPrice;
    }

    /**
     * 库存数量
     */
    public void setStock(Integer stock) {
        this.stock = stock;
    }

    /**
     * 库存数量
     */
    public Integer getStock() {
        return stock;
    }

    /**
     * 商品图片URL
     */
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    /**
     * 商品图片URL
     */
    public String getImageUrl() {
        return imageUrl;
    }

    @Override
    public String toString() {
        return "ProductInfo{" +
                "id=" + getId() + '\'' +
                "productCode=" + productCode + '\'' +
                "productName=" + productName + '\'' +
                "oneCategoryId=" + oneCategoryId + '\'' +
                "twoCategoryId=" + twoCategoryId + '\'' +
                "price=" + price + '\'' +
                "publishStatus=" + publishStatus + '\'' +
                "productionDate=" + productionDate + '\'' +
                "shelfLife=" + shelfLife + '\'' +
                "description=" + description + '\'' +
                "originPlace=" + originPlace + '\'' +
                "storageMethod=" + storageMethod + '\'' +
                "nutritionInfo=" + nutritionInfo + '\'' +
                "weightUnit=" + weightUnit + '\'' +
                "isOrganic=" + isOrganic + '\'' +
                "isSeasonal=" + isSeasonal + '\'' +
                "discountPrice=" + discountPrice + '\'' +
                "stock=" + stock + '\'' +
                "imageUrl=" + imageUrl + '\'' +
                "delFlag=" + getDelFlag() + '\'' +
                "createBy=" + getCreatedBy() + '\'' +
                "createTime=" + getCreatedTime() + '\'' +
                "updateBy=" + getUpdatedBy() + '\'' +
                "updateTime=" + getUpdatedTime() + '\'' +
                "REMARK=" + getRemark() + '\'' +
                '}';
    }
}
