package org.example.emarketmall.enums;

/**
 * @Description: 支付方式枚举
 * @author: system
 * @date: 2024年12月19日
 */
public enum PaymentMethod {
    ALIPAY(1, "支付宝"),
    WECHAT_PAY(2, "微信支付"),
    BANK_CARD(3, "银行卡"),
    CASH_ON_DELIVERY(4, "货到付款");

    private final Integer code;
    private final String description;

    PaymentMethod(Integer code, String description) {
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
     * 根据支付方式码获取枚举
     * @param code 支付方式码
     * @return 支付方式枚举
     */
    public static PaymentMethod getByCode(Integer code) {
        if (code == null) {
            return null;
        }
        for (PaymentMethod method : PaymentMethod.values()) {
            if (method.getCode().equals(code)) {
                return method;
            }
        }
        return null;
    }

    /**
     * 根据支付方式码获取描述
     * @param code 支付方式码
     * @return 支付方式描述
     */
    public static String getDescriptionByCode(Integer code) {
        PaymentMethod method = getByCode(code);
        return method != null ? method.getDescription() : "未知支付方式";
    }

    /**
     * 判断是否为有效支付方式
     * @param code 支付方式码
     * @return 是否有效
     */
    public static boolean isValidMethod(Integer code) {
        return getByCode(code) != null;
    }
}