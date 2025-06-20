package org.example.emarketmall.service;

import org.example.emarketmall.entity.StaffInfo;

/**
 * 员工信息服务接口
 * @author system
 * @date 2024
 */
public interface StaffInfoService {
    
    /**
     * 管理员登录验证
     * @param loginName 登录名
     * @param password 密码
     * @return 登录成功的管理员信息
     */
    StaffInfo adminLogin(String loginName, String password);
    
    /**
     * 根据登录名查询管理员信息
     * @param loginName 登录名
     * @return 管理员信息
     */
    StaffInfo selectStaffInfoByLoginName(String loginName);
    
    /**
     * 根据姓名查询管理员信息
     * @param name 姓名
     * @return 管理员信息
     */
    StaffInfo selectStaffInfoByName(String name);
    
    /**
     * 根据ID查询管理员信息
     * @param id 管理员ID
     * @return 管理员信息
     */
    StaffInfo selectStaffInfoById(Integer id);
}