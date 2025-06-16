package org.example.emarketmall.entity;

import java.util.Date;

/**
 * 员工信息实体类
 * @author system
 * @date 2024
 */
public class StaffInfo {
    
    /** 删除标志 */
    private Integer delFlag;
    
    /** 创建者 */
    private String createdBy;
    
    /** 创建时间 */
    private Date createdTime;
    
    /** 更新者 */
    private String updatedBy;
    
    /** 更新时间 */
    private Date updatedTime;
    
    /** 备注 */
    private String remark;
    
    /** 员工ID */
    private Integer id;
    
    /** 登录名 */
    private String loginName;
    
    /** 姓名 */
    private String name;
    
    /** 员工类型 */
    private String staffType;
    
    /** 邮箱 */
    private String email;
    
    /** 手机号 */
    private String phoneNum;
    
    /** 性别 */
    private String gender;
    
    /** 头像 */
    private String avatar;
    
    /** 密码 */
    private String password;
    
    /** 状态 */
    private Integer status;
    
    /** 部门ID */
    private Integer deptId;
    
    public StaffInfo() {}
    
    public Integer getDelFlag() {
        return delFlag;
    }
    
    public void setDelFlag(Integer delFlag) {
        this.delFlag = delFlag;
    }
    
    public String getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
    
    public Date getCreatedTime() {
        return createdTime;
    }
    
    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }
    
    public String getUpdatedBy() {
        return updatedBy;
    }
    
    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }
    
    public Date getUpdatedTime() {
        return updatedTime;
    }
    
    public void setUpdatedTime(Date updatedTime) {
        this.updatedTime = updatedTime;
    }
    
    public String getRemark() {
        return remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getLoginName() {
        return loginName;
    }
    
    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getStaffType() {
        return staffType;
    }
    
    public void setStaffType(String staffType) {
        this.staffType = staffType;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhoneNum() {
        return phoneNum;
    }
    
    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getAvatar() {
        return avatar;
    }
    
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public Integer getStatus() {
        return status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    
    public Integer getDeptId() {
        return deptId;
    }
    
    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }
    
    @Override
    public String toString() {
        return "StaffInfo{" +
                "delFlag=" + delFlag +
                ", createdBy='" + createdBy + '\'' +
                ", createdTime=" + createdTime +
                ", updatedBy='" + updatedBy + '\'' +
                ", updatedTime=" + updatedTime +
                ", remark='" + remark + '\'' +
                ", id=" + id +
                ", loginName='" + loginName + '\'' +
                ", name='" + name + '\'' +
                ", staffType='" + staffType + '\'' +
                ", email='" + email + '\'' +
                ", phoneNum='" + phoneNum + '\'' +
                ", gender='" + gender + '\'' +
                ", avatar='" + avatar + '\'' +
                ", password='" + password + '\'' +
                ", status=" + status +
                ", deptId=" + deptId +
                '}';
    }
}