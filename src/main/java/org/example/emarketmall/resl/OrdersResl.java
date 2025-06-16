package org.example.emarketmall.resl;

import org.example.emarketmall.common.BaseEntity;
import org.example.emarketmall.entity.OrderDetail;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @Description: 订单管理响应类 - 用于多表查询返回
 * @author: system
 * @date: 2024年12月19日
 */
public class OrdersResl extends BaseEntity {
    
    // ========== 订单基本信息 ==========
    /** 订单编号 */
    private String orderNum;
    
    /** 用户ID */
    private Integer userId;
    
    /** 收货人 */
    private String shippingUser;
    
    /** 收货地址 */
    private String address;
    
    /** 支付方式 */
    private Integer paymentMethod;
    
    /** 订单金额 */
    private BigDecimal orderMoney;
    
    /** 运费 */
    private BigDecimal shippingMoney;
    
    /** 优惠金额 */
    private BigDecimal districtMoney;
    
    /** 实付金额 */
    private BigDecimal paymentMoney;
    
    /** 支付时间 */
    private Date payTime;
    
    /** 收货时间 */
    private Date receiveTime;
    
    /** 发货时间 */
    private Date shipTime;
    
    /** 订单状态 */
    private Integer orderStatus;
    
    /** 支付交易号 */
    private String paymentTransactionId;
    
    /** 预计送达时间 */
    private Date expectedDeliveryTime;
    
    // ========== 用户信息字段 ==========
    /** 用户姓名 */
    private String userName;
    
    /** 用户登录名 */
    private String userLoginName;
    
    /** 用户头像 */
    private String userAvatar;
    
    /** 用户邮箱 */
    private String userEmail;
    
    /** 用户手机号 */
    private String userPhone;
    
    // ========== 订单详情信息 ==========
    /** 订单详情列表 */
    private List<OrderDetail> orderDetails;
    
    /** 订单商品总数量 */
    private Integer totalProductCount;
    
    /** 订单商品种类数 */
    private Integer productTypeCount;

    public OrdersResl() {
    }

    // ========== Getter and Setter ==========
    
    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getShippingUser() {
        return shippingUser;
    }

    public void setShippingUser(String shippingUser) {
        this.shippingUser = shippingUser;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(Integer paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public BigDecimal getOrderMoney() {
        return orderMoney;
    }

    public void setOrderMoney(BigDecimal orderMoney) {
        this.orderMoney = orderMoney;
    }

    public BigDecimal getShippingMoney() {
        return shippingMoney;
    }

    public void setShippingMoney(BigDecimal shippingMoney) {
        this.shippingMoney = shippingMoney;
    }

    public BigDecimal getDistrictMoney() {
        return districtMoney;
    }

    public void setDistrictMoney(BigDecimal districtMoney) {
        this.districtMoney = districtMoney;
    }

    public BigDecimal getPaymentMoney() {
        return paymentMoney;
    }

    public void setPaymentMoney(BigDecimal paymentMoney) {
        this.paymentMoney = paymentMoney;
    }

    public Date getPayTime() {
        return payTime;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    public Date getReceiveTime() {
        return receiveTime;
    }

    public void setReceiveTime(Date receiveTime) {
        this.receiveTime = receiveTime;
    }

    public Date getShipTime() {
        return shipTime;
    }

    public void setShipTime(Date shipTime) {
        this.shipTime = shipTime;
    }

    public Integer getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Integer orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getPaymentTransactionId() {
        return paymentTransactionId;
    }

    public void setPaymentTransactionId(String paymentTransactionId) {
        this.paymentTransactionId = paymentTransactionId;
    }

    public Date getExpectedDeliveryTime() {
        return expectedDeliveryTime;
    }

    public void setExpectedDeliveryTime(Date expectedDeliveryTime) {
        this.expectedDeliveryTime = expectedDeliveryTime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserLoginName() {
        return userLoginName;
    }

    public void setUserLoginName(String userLoginName) {
        this.userLoginName = userLoginName;
    }

    public String getUserAvatar() {
        return userAvatar;
    }

    public void setUserAvatar(String userAvatar) {
        this.userAvatar = userAvatar;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public Integer getTotalProductCount() {
        return totalProductCount;
    }

    public void setTotalProductCount(Integer totalProductCount) {
        this.totalProductCount = totalProductCount;
    }

    public Integer getProductTypeCount() {
        return productTypeCount;
    }

    public void setProductTypeCount(Integer productTypeCount) {
        this.productTypeCount = productTypeCount;
    }

    @Override
    public String toString() {
        return "OrdersResl{" +
                "id=" + getId() +
                ", orderNum='" + orderNum + '\'' +
                ", userId=" + userId +
                ", shippingUser='" + shippingUser + '\'' +
                ", address='" + address + '\'' +
                ", paymentMethod=" + paymentMethod +
                ", orderMoney=" + orderMoney +
                ", shippingMoney=" + shippingMoney +
                ", districtMoney=" + districtMoney +
                ", paymentMoney=" + paymentMoney +
                ", payTime=" + payTime +
                ", receiveTime=" + receiveTime +
                ", shipTime=" + shipTime +
                ", orderStatus=" + orderStatus +
                ", paymentTransactionId='" + paymentTransactionId + '\'' +
                ", expectedDeliveryTime=" + expectedDeliveryTime +
                ", userName='" + userName + '\'' +
                ", userLoginName='" + userLoginName + '\'' +
                ", userAvatar='" + userAvatar + '\'' +
                ", userEmail='" + userEmail + '\'' +
                ", userPhone='" + userPhone + '\'' +
                ", totalProductCount=" + totalProductCount +
                ", productTypeCount=" + productTypeCount +
                ", delFlag=" + getDelFlag() +
                ", createdBy='" + getCreatedBy() + '\'' +
                ", createdTime='" + getCreatedTime() + '\'' +
                ", updatedBy='" + getUpdatedBy() + '\'' +
                ", updatedTime='" + getUpdatedTime() + '\'' +
                ", remark='" + getRemark() + '\'' +
                '}';
    }
}