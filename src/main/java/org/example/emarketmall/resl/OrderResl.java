package org.example.emarketmall.resl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @Description: 订单响应实体类
 * @author: system
 * @date: 2024年12月19日
 */
public class OrderResl {
    /** 订单ID */
    private Integer id;
    
    /** 订单编号 */
    private String orderNum;
    
    /** 用户ID */
    private Integer userId;
    
    /** 用户名称 */
    private String userName;
    
    /** 收货人 */
    private String shippingUser;
    
    /** 收货地址 */
    private String address;
    
    /** 支付方式 */
    private Integer paymentMethod;
    
    /** 支付方式描述 */
    private String paymentMethodDesc;
    
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
    
    /** 订单状态描述 */
    private String orderStatusDesc;
    
    /** 支付交易号 */
    private String paymentTransactionId;
    
    /** 预计送达时间 */
    private Date expectedDeliveryTime;
    
    /** 创建时间 */
    private Date createdTime;
    
    /** 订单详情列表 */
    private List<OrderDetailResl> orderDetails;
    
    /** 商品总数量 */
    private Integer totalAmount;

    public OrderResl() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

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

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
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

    public String getPaymentMethodDesc() {
        return paymentMethodDesc;
    }

    public void setPaymentMethodDesc(String paymentMethodDesc) {
        this.paymentMethodDesc = paymentMethodDesc;
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

    public String getOrderStatusDesc() {
        return orderStatusDesc;
    }

    public void setOrderStatusDesc(String orderStatusDesc) {
        this.orderStatusDesc = orderStatusDesc;
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

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public List<OrderDetailResl> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetailResl> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public Integer getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Integer totalAmount) {
        this.totalAmount = totalAmount;
    }
}