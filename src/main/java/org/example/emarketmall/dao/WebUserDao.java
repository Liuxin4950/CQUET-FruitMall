package org.example.emarketmall.dao;

import org.example.emarketmall.req.UserUpdateReq;
import org.example.emarketmall.resl.UserInfoResl;

/**
 * @Description: Web端用户信息DAO接口
 * @author: system
 * @date: 2024年12月19日
 */
public interface WebUserDao {
    
    /**
     * 根据用户ID查询用户详细信息（包含统计信息）
     * @param userId 用户ID
     * @return 用户详细信息
     * @throws Exception
     */
    UserInfoResl selectUserInfoById(Integer userId) throws Exception;
    
    /**
     * 根据登录名查询用户详细信息
     * @param loginName 登录名
     * @return 用户详细信息
     * @throws Exception
     */
    UserInfoResl selectUserInfoByLoginName(String loginName) throws Exception;
    
    /**
     * 更新用户基本信息
     * @param userUpdateReq 用户更新请求
     * @return 影响行数
     * @throws Exception
     */
    int updateUserInfo(UserUpdateReq userUpdateReq) throws Exception;
    
    /**
     * 更新用户密码
     * @param userId 用户ID
     * @param newPassword 新密码（已加密）
     * @return 影响行数
     * @throws Exception
     */
    int updateUserPassword(Integer userId, String newPassword) throws Exception;
    
    /**
     * 验证用户旧密码
     * @param userId 用户ID
     * @param oldPassword 旧密码（已加密）
     * @return 是否匹配
     * @throws Exception
     */
    boolean verifyUserPassword(Integer userId, String oldPassword) throws Exception;
    
    /**
     * 更新用户最后登录时间
     * @param userId 用户ID
     * @return 影响行数
     * @throws Exception
     */
    int updateLastLoginTime(Integer userId) throws Exception;
    
    /**
     * 检查邮箱是否已存在（排除当前用户）
     * @param email 邮箱
     * @param excludeUserId 排除的用户ID
     * @return 是否存在
     * @throws Exception
     */
    boolean checkEmailExists(String email, Integer excludeUserId) throws Exception;
    
    /**
     * 检查手机号是否已存在（排除当前用户）
     * @param phone 手机号
     * @param excludeUserId 排除的用户ID
     * @return 是否存在
     * @throws Exception
     */
    boolean checkPhoneExists(String phone, Integer excludeUserId) throws Exception;
}