package org.example.emarketmall.req;

import java.math.BigDecimal;
import java.util.List;

/**
 * @Description: 订单创建请求实体类
 * @author: system
 * @date: 2024年12月19日
 */
public class OrderCreateReq {
    /** 用户ID */
    private Integer userId;
    
    /** 收货人 */
    private String shippingUser;
    
    /** 收货地址 */
    private String address;
    
    /** 支付方式 */
    private Integer paymentMethod;
    
    /** 运费 */
    private BigDecimal shippingMoney;
    
    /** 优惠金额 */
    private BigDecimal districtMoney;
    
    /** 备注 */
    private String remark;
    
    /** 订单商品列表 */
    private List<OrderItemReq> orderItems;
    
    /** 购物车商品ID列表（从购物车下单时使用） */
    private List<Integer> cartIds;

    public OrderCreateReq() {
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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public List<OrderItemReq> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItemReq> orderItems) {
        this.orderItems = orderItems;
    }

    public List<Integer> getCartIds() {
        return cartIds;
    }

    public void setCartIds(List<Integer> cartIds) {
        this.cartIds = cartIds;
    }
}