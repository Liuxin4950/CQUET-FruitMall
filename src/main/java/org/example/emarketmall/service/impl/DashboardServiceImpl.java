package org.example.emarketmall.service.impl;

import org.example.emarketmall.dao.DashboardDao;
import org.example.emarketmall.dao.impl.DashboardDaoImpl;
import org.example.emarketmall.service.DashboardService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description: 数据统计Service实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class DashboardServiceImpl implements DashboardService {

    private DashboardDao dashboardDao;

    public DashboardServiceImpl() {
        this.dashboardDao = new DashboardDaoImpl();
    }

    @Override
    public Map<String, Object> getDashboardData() throws Exception {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 基础统计数据
            Map<String, Object> basicStats = new HashMap<>();
            basicStats.put("totalUsers", dashboardDao.getTotalUserCount());
            basicStats.put("todayNewUsers", dashboardDao.getTodayNewUserCount());
            basicStats.put("totalOrders", dashboardDao.getTotalOrderCount());
            basicStats.put("todayOrders", dashboardDao.getTodayOrderCount());
            basicStats.put("todaySales", dashboardDao.getTodaySales());
            result.put("basicStats", basicStats);
            
            // 图表数据
            result.put("recentOrderStats", dashboardDao.getRecentOrderStats());
            result.put("recentUserStats", dashboardDao.getRecentUserStats());
            result.put("orderStatusDistribution", dashboardDao.getOrderStatusDistribution());
            
            // 模拟在线用户数（实际项目中可以通过Session管理或Redis实现）
            int onlineUsers = (int)(Math.random() * 100) + 20; // 20-120之间的随机数
            result.put("onlineUsers", onlineUsers);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("获取仪表盘数据失败: " + e.getMessage());
        }
        
        return result;
    }
}