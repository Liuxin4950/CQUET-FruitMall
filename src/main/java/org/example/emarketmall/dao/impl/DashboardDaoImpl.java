package org.example.emarketmall.dao.impl;

import org.example.emarketmall.dao.DashboardDao;

import java.util.*;

/**
 * @Description: 数据统计DAO实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class DashboardDaoImpl implements DashboardDao {

    @Override
    public int getTotalUserCount() throws Exception {
        // 模拟数据，实际项目中应该查询数据库
        return 150;
    }

    @Override
    public int getTodayNewUserCount() throws Exception {
        // 模拟数据
        return 5;
    }

    @Override
    public int getTotalOrderCount() throws Exception {
        // 模拟数据
        return 320;
    }

    @Override
    public int getTodayOrderCount() throws Exception {
        // 模拟数据
        return 12;
    }

    @Override
    public double getTodaySales() throws Exception {
        // 模拟数据
        return 2580.50;
    }

    @Override
    public List<Map<String, Object>> getRecentOrderStats() throws Exception {
        // 模拟最近7天订单统计数据
        List<Map<String, Object>> result = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        for (int i = 6; i >= 0; i--) {
            cal.add(Calendar.DAY_OF_MONTH, -i);
            Map<String, Object> data = new HashMap<>();
            data.put("date", String.format("%04d-%02d-%02d", 
                cal.get(Calendar.YEAR), 
                cal.get(Calendar.MONTH) + 1, 
                cal.get(Calendar.DAY_OF_MONTH)));
            data.put("count", (int)(Math.random() * 20) + 5);
            result.add(data);
            cal = Calendar.getInstance(); // 重置日历
        }
        return result;
    }

    @Override
    public List<Map<String, Object>> getRecentUserStats() throws Exception {
        // 模拟最近7天用户注册统计数据
        List<Map<String, Object>> result = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        for (int i = 6; i >= 0; i--) {
            cal.add(Calendar.DAY_OF_MONTH, -i);
            Map<String, Object> data = new HashMap<>();
            data.put("date", String.format("%04d-%02d-%02d", 
                cal.get(Calendar.YEAR), 
                cal.get(Calendar.MONTH) + 1, 
                cal.get(Calendar.DAY_OF_MONTH)));
            data.put("count", (int)(Math.random() * 10) + 1);
            result.add(data);
            cal = Calendar.getInstance(); // 重置日历
        }
        return result;
    }

    @Override
    public List<Map<String, Object>> getOrderStatusDistribution() throws Exception {
        // 模拟订单状态分布数据
        List<Map<String, Object>> result = new ArrayList<>();
        
        Map<String, Object> status1 = new HashMap<>();
        status1.put("status", "待付款");
        status1.put("count", 25);
        result.add(status1);
        
        Map<String, Object> status2 = new HashMap<>();
        status2.put("status", "待发货");
        status2.put("count", 18);
        result.add(status2);
        
        Map<String, Object> status3 = new HashMap<>();
        status3.put("status", "已完成");
        status3.put("count", 245);
        result.add(status3);
        
        Map<String, Object> status4 = new HashMap<>();
        status4.put("status", "已取消");
        status4.put("count", 32);
        result.add(status4);
        
        return result;
    }
}