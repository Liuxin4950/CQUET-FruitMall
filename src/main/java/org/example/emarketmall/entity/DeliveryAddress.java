package org.example.emarketmall.entity;

import org.example.emarketmall.common.BaseEntity;

/**
 * @Description: 收货地址实体类
 * @author: 若若
 * @date: 2024年12月19日
 */
public class DeliveryAddress extends BaseEntity {
    private Integer userId;
    private String receiverName;
    private String phone;
    private String province;
    private String city;
    private String district;
    private String detailAddress;
    private Boolean isDefault;

    public DeliveryAddress() {
    }

    public DeliveryAddress(Integer userId, String receiverName, String phone, String province, String city, String district, String detailAddress, Boolean isDefault) {
        this.userId = userId;
        this.receiverName = receiverName;
        this.phone = phone;
        this.province = province;
        this.city = city;
        this.district = district;
        this.detailAddress = detailAddress;
        this.isDefault = isDefault;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getDetailAddress() {
        return detailAddress;
    }

    public void setDetailAddress(String detailAddress) {
        this.detailAddress = detailAddress;
    }

    public Boolean getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(Boolean isDefault) {
        this.isDefault = isDefault;
    }

    /**
     * 获取完整地址
     */
    public String getFullAddress() {
        return province + city + district + detailAddress;
    }

    @Override
    public String toString() {
        return "DeliveryAddress{" +
                "id=" + getId() +
                ", userId=" + userId +
                ", receiverName='" + receiverName + '\'' +
                ", phone='" + phone + '\'' +
                ", province='" + province + '\'' +
                ", city='" + city + '\'' +
                ", district='" + district + '\'' +
                ", detailAddress='" + detailAddress + '\'' +
                ", isDefault=" + isDefault +
                '}';
    }
}