package org.example.emarketmall.dao;

import java.util.Map;
import java.util.List;

/**
 * @Description: 数据统计DAO接口
 * @author: system
 * @date: 2024年12月19日
 */
public interface DashboardDao {

    /**
     * 获取用户总数
     * @return 用户总数
     */
    int getTotalUserCount() throws Exception;

    /**
     * 获取今日新增用户数
     * @return 今日新增用户数
     */
    int getTodayNewUserCount() throws Exception;

    /**
     * 获取订单总数
     * @return 订单总数
     */
    int getTotalOrderCount() throws Exception;

    /**
     * 获取今日订单数
     * @return 今日订单数
     */
    int getTodayOrderCount() throws Exception;

    /**
     * 获取今日销售额
     * @return 今日销售额
     */
    double getTodaySales() throws Exception;

    /**
     * 获取最近7天的订单统计
     * @return 最近7天订单统计数据
     */
    List<Map<String, Object>> getRecentOrderStats() throws Exception;

    /**
     * 获取最近7天的用户注册统计
     * @return 最近7天用户注册统计数据
     */
    List<Map<String, Object>> getRecentUserStats() throws Exception;

    /**
     * 获取订单状态分布
     * @return 订单状态分布数据
     */
    List<Map<String, Object>> getOrderStatusDistribution() throws Exception;
}