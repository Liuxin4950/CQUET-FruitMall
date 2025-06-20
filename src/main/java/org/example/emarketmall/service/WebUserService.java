package org.example.emarketmall.service;

import org.example.emarketmall.req.UserUpdateReq;
import org.example.emarketmall.resl.UserInfoResl;

/**
 * @Description: Web端用户信息Service接口
 * @author: system
 * @date: 2024年12月19日
 */
public interface WebUserService {
    
    /**
     * 根据用户ID查询用户详细信息
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
     * @return 操作结果
     * @throws Exception
     */
    boolean updateUserInfo(UserUpdateReq userUpdateReq) throws Exception;
    
    /**
     * 更新用户密码
     * @param userUpdateReq 用户更新请求（包含旧密码和新密码）
     * @return 操作结果
     * @throws Exception
     */
    boolean updateUserPassword(UserUpdateReq userUpdateReq) throws Exception;
    
    /**
     * 验证用户信息更新请求
     * @param userUpdateReq 用户更新请求
     * @return 验证结果消息，null表示验证通过
     * @throws Exception
     */
    String validateUserUpdateReq(UserUpdateReq userUpdateReq) throws Exception;
    
    /**
     * 验证密码更新请求
     * @param userUpdateReq 用户更新请求
     * @return 验证结果消息，null表示验证通过
     * @throws Exception
     */
    String validatePasswordUpdateReq(UserUpdateReq userUpdateReq) throws Exception;
    
    /**
     * 更新用户最后登录时间
     * @param userId 用户ID
     * @return 操作结果
     * @throws Exception
     */
    boolean updateLastLoginTime(Integer userId) throws Exception;
}