package org.example.emarketmall.req;

import org.example.emarketmall.common.BaseEntity;

import java.math.BigDecimal;

/**
 * @Description: 商品查询请求参数类
 * @author: system
 * @date: 2024年12月19日
 */
public class ProductQueryReq extends BaseEntity {
    
    /** 商品名称（模糊查询） */
    private String productName;
    
    /** 一级分类ID */
    private Integer oneCategoryId;
    
    /** 二级分类ID */
    private Integer twoCategoryId;
    
    /** 最低价格 */
    private BigDecimal minPrice;
    
    /** 最高价格 */
    private BigDecimal maxPrice;
    
    /** 是否有机食品 */
    private Boolean isOrganic;
    
    /** 是否季节性商品 */
    private Boolean isSeasonal;
    
    /** 产地 */
    private String originPlace;
    
    /** 上下架状态（1-上架，0-下架） */
    private Integer publishStatus;
    
    /** 排序字段（price-价格，sales-销量，rating-评分，createTime-创建时间） */
    private String sortField;
    
    /** 排序方式（asc-升序，desc-降序） */
    private String sortOrder;
    
    /** 页码 */
    private Integer pageNum;
    
    /** 每页数量 */
    private Integer pageSize;
    
    /** 是否只查询推荐商品 */
    private Boolean onlyRecommended;
    
    /** 搜索关键词（商品名称或描述） */
    private String keyword;
    
    // ========== Getter and Setter ==========
    
    public String getProductName() {
        return productName;
    }
    
    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    public Integer getOneCategoryId() {
        return oneCategoryId;
    }
    
    public void setOneCategoryId(Integer oneCategoryId) {
        this.oneCategoryId = oneCategoryId;
    }
    
    public Integer getTwoCategoryId() {
        return twoCategoryId;
    }
    
    public void setTwoCategoryId(Integer twoCategoryId) {
        this.twoCategoryId = twoCategoryId;
    }
    
    public BigDecimal getMinPrice() {
        return minPrice;
    }
    
    public void setMinPrice(BigDecimal minPrice) {
        this.minPrice = minPrice;
    }
    
    public BigDecimal getMaxPrice() {
        return maxPrice;
    }
    
    public void setMaxPrice(BigDecimal maxPrice) {
        this.maxPrice = maxPrice;
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
    
    public String getOriginPlace() {
        return originPlace;
    }
    
    public void setOriginPlace(String originPlace) {
        this.originPlace = originPlace;
    }
    
    public Integer getPublishStatus() {
        return publishStatus;
    }
    
    public void setPublishStatus(Integer publishStatus) {
        this.publishStatus = publishStatus;
    }
    
    public String getSortField() {
        return sortField;
    }
    
    public void setSortField(String sortField) {
        this.sortField = sortField;
    }
    
    public String getSortOrder() {
        return sortOrder;
    }
    
    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }
    
    public Integer getPageNum() {
        return pageNum != null ? pageNum : 1;
    }
    
    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }
    
    public Integer getPageSize() {
        return pageSize != null ? pageSize : 10;
    }
    
    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }
    
    public Boolean getOnlyRecommended() {
        return onlyRecommended;
    }
    
    public void setOnlyRecommended(Boolean onlyRecommended) {
        this.onlyRecommended = onlyRecommended;
    }
    
    public String getKeyword() {
        return keyword;
    }
    
    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }
    
    @Override
    public String toString() {
        return "ProductQueryReq{" +
                "productName='" + productName + '\'' +
                ", oneCategoryId=" + oneCategoryId +
                ", twoCategoryId=" + twoCategoryId +
                ", minPrice=" + minPrice +
                ", maxPrice=" + maxPrice +
                ", isOrganic=" + isOrganic +
                ", isSeasonal=" + isSeasonal +
                ", originPlace='" + originPlace + '\'' +
                ", publishStatus=" + publishStatus +
                ", sortField='" + sortField + '\'' +
                ", sortOrder='" + sortOrder + '\'' +
                ", pageNum=" + pageNum +
                ", pageSize=" + pageSize +
                ", onlyRecommended=" + onlyRecommended +
                ", keyword='" + keyword + '\'' +
                '}';
    }
}