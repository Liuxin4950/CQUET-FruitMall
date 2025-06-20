package org.example.emarketmall.req;

import java.util.Date;

/**
 * @Description: 订单查询请求实体类
 * @author: system
 * @date: 2024年12月19日
 */
public class OrderQueryReq {
    /** 用户ID */
    private Integer userId;
    
    /** 订单编号 */
    private String orderNum;
    
    /** 订单状态 */
    private Integer orderStatus;
    
    /** 开始时间 */
    private Date startTime;
    
    /** 结束时间 */
    private Date endTime;
    
    /** 页码 */
    private Integer pageNum;
    
    /** 每页大小 */
    private Integer pageSize;
    
    /** 排序字段 */
    private String orderBy;
    
    /** 排序方向 */
    private String sortOrder;

    public OrderQueryReq() {
        this.pageNum = 1;
        this.pageSize = 10;
        this.orderBy = "createdTime";
        this.sortOrder = "DESC";
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }

    public Integer getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Integer orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

    public String getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }
}