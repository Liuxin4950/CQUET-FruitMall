package org.example.emarketmall.resl;

import org.example.emarketmall.common.BaseEntity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @Description: 商品展示响应类 - 用于前端商品展示的多表查询返回
 * @author: system
 * @date: 2024年12月19日
 */
public class ProductDisplayResl extends BaseEntity {
    
    // ========== 商品基本信息 ==========
    /** 商品编码 */
    private String productCode;
    
    /** 商品名称 */
    private String productName;
    
    /** 商品价格 */
    private BigDecimal price;
    
    /** 折扣价格 */
    private BigDecimal discountPrice;
    
    /** 商品描述 */
    private String description;
    
    /** 商品图片URL */
    private String imageUrl;
    
    /** 库存数量 */
    private Integer stock;
    
    /** 上下架状态 */
    private Integer publishStatus;
    
    /** 产地 */
    private String originPlace;
    
    /** 是否有机食品 */
    private Boolean isOrganic;
    
    /** 是否季节性商品 */
    private Boolean isSeasonal;
    
    /** 重量单位 */
    private String weightUnit;
    
    /** 营养信息 */
    private String nutritionInfo;
    
    /** 储存方式 */
    private String storageMethod;
    
    /** 生产日期 */
    private Date productionDate;
    
    /** 商品有效期（天数） */
    private Integer shelfLife;
    
    // ========== 分类信息 ==========
    /** 一级分类ID */
    private Integer oneCategoryId;
    
    /** 一级分类名称 */
    private String oneCategoryName;
    
    /** 二级分类ID */
    private Integer twoCategoryId;
    
    /** 二级分类名称 */
    private String twoCategoryName;
    
    // ========== 扩展信息 ==========
    /** 销量（用于推荐排序） */
    private Integer salesCount;
    
    /** 评分（用于推荐排序） */
    private BigDecimal rating;
    
    /** 是否推荐商品 */
    private Boolean isRecommended;
    
    /** 推荐权重 */
    private Integer recommendWeight;
    
    // ========== Getter and Setter ==========
    
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
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public BigDecimal getDiscountPrice() {
        return discountPrice;
    }
    
    public void setDiscountPrice(BigDecimal discountPrice) {
        this.discountPrice = discountPrice;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public Integer getStock() {
        return stock;
    }
    
    public void setStock(Integer stock) {
        this.stock = stock;
    }
    
    public Integer getPublishStatus() {
        return publishStatus;
    }
    
    public void setPublishStatus(Integer publishStatus) {
        this.publishStatus = publishStatus;
    }
    
    public String getOriginPlace() {
        return originPlace;
    }
    
    public void setOriginPlace(String originPlace) {
        this.originPlace = originPlace;
    }
    
    public Boolean getIsOrganic() {
        return isOrganic;
    }
    
    public void setIsOrganic(Boolean isOrganic) {
        this.isOrganic = isOrganic;
    }
    
    public Boolean getIsSeasonal() {
        return isSeasonal;
    }
    
    public void setIsSeasonal(Boolean isSeasonal) {
        this.isSeasonal = isSeasonal;
    }
    
    public String getWeightUnit() {
        return weightUnit;
    }
    
    public void setWeightUnit(String weightUnit) {
        this.weightUnit = weightUnit;
    }
    
    public String getNutritionInfo() {
        return nutritionInfo;
    }
    
    public void setNutritionInfo(String nutritionInfo) {
        this.nutritionInfo = nutritionInfo;
    }
    
    public String getStorageMethod() {
        return storageMethod;
    }
    
    public void setStorageMethod(String storageMethod) {
        this.storageMethod = storageMethod;
    }
    
    public Date getProductionDate() {
        return productionDate;
    }
    
    public void setProductionDate(Date productionDate) {
        this.productionDate = productionDate;
    }
    
    public Integer getShelfLife() {
        return shelfLife;
    }
    
    public void setShelfLife(Integer shelfLife) {
        this.shelfLife = shelfLife;
    }
    
    public Integer getOneCategoryId() {
        return oneCategoryId;
    }
    
    public void setOneCategoryId(Integer oneCategoryId) {
        this.oneCategoryId = oneCategoryId;
    }
    
    public String getOneCategoryName() {
        return oneCategoryName;
    }
    
    public void setOneCategoryName(String oneCategoryName) {
        this.oneCategoryName = oneCategoryName;
    }
    
    public Integer getTwoCategoryId() {
        return twoCategoryId;
    }
    
    public void setTwoCategoryId(Integer twoCategoryId) {
        this.twoCategoryId = twoCategoryId;
    }
    
    public String getTwoCategoryName() {
        return twoCategoryName;
    }
    
    public void setTwoCategoryName(String twoCategoryName) {
        this.twoCategoryName = twoCategoryName;
    }
    
    public Integer getSalesCount() {
        return salesCount;
    }
    
    public void setSalesCount(Integer salesCount) {
        this.salesCount = salesCount;
    }
    
    public BigDecimal getRating() {
        return rating;
    }
    
    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }
    
    public Boolean getIsRecommended() {
        return isRecommended;
    }
    
    public void setIsRecommended(Boolean isRecommended) {
        this.isRecommended = isRecommended;
    }
    
    public Integer getRecommendWeight() {
        return recommendWeight;
    }
    
    public void setRecommendWeight(Integer recommendWeight) {
        this.recommendWeight = recommendWeight;
    }
    
    @Override
    public String toString() {
        return "ProductDisplayResl{" +
                "productCode='" + productCode + '\'' +
                ", productName='" + productName + '\'' +
                ", price=" + price +
                ", discountPrice=" + discountPrice +
                ", description='" + description + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", stock=" + stock +
                ", publishStatus=" + publishStatus +
                ", originPlace='" + originPlace + '\'' +
                ", isOrganic=" + isOrganic +
                ", isSeasonal=" + isSeasonal +
                ", oneCategoryName='" + oneCategoryName + '\'' +
                ", twoCategoryName='" + twoCategoryName + '\'' +
                ", salesCount=" + salesCount +
                ", rating=" + rating +
                ", isRecommended=" + isRecommended +
                '}';
    }
}