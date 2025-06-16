package org.example.emarketmall.dao;

import org.example.emarketmall.entity.StaffInfo;

/**
 * 员工信息数据访问接口
 * @author system
 * @date 2024
 */
public interface StaffInfoDao {
    
    /**
     * 根据登录名查询员工信息
     * @param loginName 登录名
     * @return 员工信息
     */
    StaffInfo selectStaffInfoByLoginName(String loginName);
    
    /**
     * 根据姓名查询员工信息
     * @param name 姓名
     * @return 员工信息
     */
    StaffInfo selectStaffInfoByName(String name);
    
    /**
     * 根据ID查询员工信息
     * @param id 员工ID
     * @return 员工信息
     */
    StaffInfo selectStaffInfoById(Integer id);
}