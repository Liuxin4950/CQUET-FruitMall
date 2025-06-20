package org.example.emarketmall.service;

import java.util.Map;

/**
 * @Description: 数据统计Service接口
 * @author: system
 * @date: 2024年12月19日
 */
public interface DashboardService {

    /**
     * 获取仪表盘统计数据
     * @return 统计数据
     */
    Map<String, Object> getDashboardData() throws Exception;
}