package org.example.emarketmall.resl;

import org.example.emarketmall.common.BaseEntity;

import java.util.Date;

/**
 * @Description: 用户信息响应类 - 用于前端用户信息展示
 * @author: system
 * @date: 2024年12月19日
 */
public class UserInfoResl extends BaseEntity {
    
    /** 用户姓名 */
    private String name;
    
    /** 用户昵称 */
    private String nickname;
    
    /** 登录名 */
    private String loginName;
    
    /** 头像 */
    private String avatar;
    
    /** 邮箱 */
    private String email;
    
    /** 手机号 */
    private String phone;
    
    /** 注册时间 */
    private Date registerTime;
    
    /** 最后登录时间 */
    private Date lastLoginTime;
    
    /** 用户状态（1-正常，0-禁用） */
    private Integer status;
    
    /** 用户等级 */
    private Integer userLevel;
    
    /** 积分 */
    private Integer points;
    
    /** 订单总数 */
    private Integer orderCount;
    
    /** 消费总金额 */
    private java.math.BigDecimal totalAmount;
    
    // ========== Getter and Setter ==========
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getNickname() {
        return nickname;
    }
    
    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
    
    public String getLoginName() {
        return loginName;
    }
    
    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }
    
    public String getAvatar() {
        return avatar;
    }
    
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public Date getRegisterTime() {
        return registerTime;
    }
    
    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }
    
    public Date getLastLoginTime() {
        return lastLoginTime;
    }
    
    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }
    
    public Integer getStatus() {
        return status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    
    public Integer getUserLevel() {
        return userLevel;
    }
    
    public void setUserLevel(Integer userLevel) {
        this.userLevel = userLevel;
    }
    
    public Integer getPoints() {
        return points;
    }
    
    public void setPoints(Integer points) {
        this.points = points;
    }
    
    public Integer getOrderCount() {
        return orderCount;
    }
    
    public void setOrderCount(Integer orderCount) {
        this.orderCount = orderCount;
    }
    
    public java.math.BigDecimal getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(java.math.BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    @Override
    public String toString() {
        return "UserInfoResl{" +
                "name='" + name + '\'' +
                ", nickname='" + nickname + '\'' +
                ", loginName='" + loginName + '\'' +
                ", avatar='" + avatar + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", registerTime=" + registerTime +
                ", lastLoginTime=" + lastLoginTime +
                ", status=" + status +
                ", userLevel=" + userLevel +
                ", points=" + points +
                ", orderCount=" + orderCount +
                ", totalAmount=" + totalAmount +
                '}';
    }
}