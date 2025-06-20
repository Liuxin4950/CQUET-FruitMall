package org.example.emarketmall.enums;

/**
 * @Description: 订单状态枚举
 * @author: system
 * @date: 2024年12月19日
 */
public enum OrderStatus {
    PENDING_PAYMENT(1, "待支付"),
    PAID(2, "已支付"),
    SHIPPED(3, "已发货"),
    COMPLETED(4, "已完成"),
    CANCELLED(5, "已取消");

    private final Integer code;
    private final String description;

    OrderStatus(Integer code, String description) {
        this.code = code;
        this.description = description;
    }

    public Integer getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }

    /**
     * 根据状态码获取枚举
     * @param code 状态码
     * @return 订单状态枚举
     */
    public static OrderStatus getByCode(Integer code) {
        if (code == null) {
            return null;
        }
        for (OrderStatus status : OrderStatus.values()) {
            if (status.getCode().equals(code)) {
                return status;
            }
        }
        return null;
    }

    /**
     * 根据状态码获取描述
     * @param code 状态码
     * @return 状态描述
     */
    public static String getDescriptionByCode(Integer code) {
        OrderStatus status = getByCode(code);
        return status != null ? status.getDescription() : "未知状态";
    }

    /**
     * 判断是否为有效状态
     * @param code 状态码
     * @return 是否有效
     */
    public static boolean isValidStatus(Integer code) {
        return getByCode(code) != null;
    }
}