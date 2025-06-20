package org.example.emarketmall.dao.impl;

import cquet.aibd.soft.ObjectUtil;
import org.example.emarketmall.dao.WebUserDao;
import org.example.emarketmall.req.UserUpdateReq;
import org.example.emarketmall.resl.UserInfoResl;
import org.example.emarketmall.utils.StringUtils;

import java.util.Date;

/**
 * @Description: Web端用户信息DAO实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class WebUserDaoImpl implements WebUserDao {
    
    @Override
    public UserInfoResl selectUserInfoById(Integer userId) throws Exception {
        String sql = "SELECT u.id, u.name, u.nickname, u.loginName, u.avatar, u.email, u.phone, " +
                     "u.createdTime as registerTime, u.updatedTime as lastLoginTime, " +
                     "1 as status, 1 as userLevel, 0 as points, " +
                     "COALESCE(order_stats.orderCount, 0) as orderCount, " +
                     "COALESCE(order_stats.totalAmount, 0) as totalAmount " +
                     "FROM user_info u " +
                     "LEFT JOIN ( " +
                     "    SELECT userId, COUNT(*) as orderCount, SUM(paymentMoney) as totalAmount " +
                     "    FROM orders WHERE delFlag = 0 GROUP BY userId " +
                     ") order_stats ON u.id = order_stats.userId " +
                     "WHERE u.id = ? AND u.delFlag = 0";
        
        return new ObjectUtil<UserInfoResl>().getOne(sql, UserInfoResl.class, userId);
    }
    
    @Override
    public UserInfoResl selectUserInfoByLoginName(String loginName) throws Exception {
        String sql = "SELECT u.id, u.name, u.nickname, u.loginName, u.avatar, u.email, u.phone, " +
                     "u.createdTime as registerTime, u.updatedTime as lastLoginTime, " +
                     "1 as status, 1 as userLevel, 0 as points, " +
                     "COALESCE(order_stats.orderCount, 0) as orderCount, " +
                     "COALESCE(order_stats.totalAmount, 0) as totalAmount " +
                     "FROM user_info u " +
                     "LEFT JOIN ( " +
                     "    SELECT userId, COUNT(*) as orderCount, SUM(paymentMoney) as totalAmount " +
                     "    FROM orders WHERE delFlag = 0 GROUP BY userId " +
                     ") order_stats ON u.id = order_stats.userId " +
                     "WHERE u.loginName = ? AND u.delFlag = 0";
        
        return new ObjectUtil<UserInfoResl>().getOne(sql, UserInfoResl.class, loginName);
    }
    
    @Override
    public int updateUserInfo(UserUpdateReq userUpdateReq) throws Exception {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE user_info SET updatedTime = NOW() ");
        
        if (StringUtils.isNotEmpty(userUpdateReq.getName())) {
            sql.append(", name = ? ");
        }
        if (StringUtils.isNotEmpty(userUpdateReq.getNickname())) {
            sql.append(", nickname = ? ");
        }
        if (StringUtils.isNotEmpty(userUpdateReq.getAvatar())) {
            sql.append(", avatar = ? ");
        }
        if (StringUtils.isNotEmpty(userUpdateReq.getEmail())) {
            sql.append(", email = ? ");
        }
        if (StringUtils.isNotEmpty(userUpdateReq.getPhone())) {
            sql.append(", phone = ? ");
        }
        
        sql.append("WHERE id = ? AND delFlag = 0");
        
        // 构建参数数组
        java.util.List<Object> params = new java.util.ArrayList<>();
        if (StringUtils.isNotEmpty(userUpdateReq.getName())) {
            params.add(userUpdateReq.getName());
        }
        if (StringUtils.isNotEmpty(userUpdateReq.getNickname())) {
            params.add(userUpdateReq.getNickname());
        }
        if (StringUtils.isNotEmpty(userUpdateReq.getAvatar())) {
            params.add(userUpdateReq.getAvatar());
        }
        if (StringUtils.isNotEmpty(userUpdateReq.getEmail())) {
            params.add(userUpdateReq.getEmail());
        }
        if (StringUtils.isNotEmpty(userUpdateReq.getPhone())) {
            params.add(userUpdateReq.getPhone());
        }
        params.add(userUpdateReq.getUserId());
        
        return new ObjectUtil<>().update(sql.toString(), params.toArray());
    }
    
    @Override
    public int updateUserPassword(Integer userId, String newPassword) throws Exception {
        String sql = "UPDATE user_info SET password = ?, updatedTime = NOW() WHERE id = ? AND delFlag = 0";
        return new ObjectUtil<>().update(sql, newPassword, userId);
    }
    
    @Override
    public boolean verifyUserPassword(Integer userId, String oldPassword) throws Exception {
        String sql = "SELECT COUNT(*) FROM user_info WHERE id = ? AND password = ? AND delFlag = 0";
        Object result = new ObjectUtil<>().getOne(sql, Object.class, userId, oldPassword);
        return result != null && Integer.parseInt(result.toString()) > 0;
    }
    
    @Override
    public int updateLastLoginTime(Integer userId) throws Exception {
        String sql = "UPDATE user_info SET updatedTime = NOW() WHERE id = ? AND delFlag = 0";
        return new ObjectUtil<>().update(sql, userId);
    }
    
    @Override
    public boolean checkEmailExists(String email, Integer excludeUserId) throws Exception {
        String sql;
        Object result;
        
        if (excludeUserId != null) {
            sql = "SELECT COUNT(*) FROM user_info WHERE email = ? AND id != ? AND delFlag = 0";
            result = new ObjectUtil<>().getOne(sql, Object.class, email, excludeUserId);
        } else {
            sql = "SELECT COUNT(*) FROM user_info WHERE email = ? AND delFlag = 0";
            result = new ObjectUtil<>().getOne(sql, Object.class, email);
        }
        
        return result != null && Integer.parseInt(result.toString()) > 0;
    }
    
    @Override
    public boolean checkPhoneExists(String phone, Integer excludeUserId) throws Exception {
        String sql;
        Object result;
        
        if (excludeUserId != null) {
            sql = "SELECT COUNT(*) FROM user_info WHERE phone = ? AND id != ? AND delFlag = 0";
            result = new ObjectUtil<>().getOne(sql, Object.class, phone, excludeUserId);
        } else {
            sql = "SELECT COUNT(*) FROM user_info WHERE phone = ? AND delFlag = 0";
            result = new ObjectUtil<>().getOne(sql, Object.class, phone);
        }
        
        return result != null && Integer.parseInt(result.toString()) > 0;
    }
}