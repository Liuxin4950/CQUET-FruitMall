package org.example.emarketmall.dao.impl;

import cquet.aibd.soft.ObjectUtil;
import org.example.emarketmall.dao.StaffInfoDao;
import org.example.emarketmall.entity.StaffInfo;

/**
 * 员工信息数据访问实现类
 * @author system
 * @date 2024
 */
public class StaffInfoDaoImpl implements StaffInfoDao {
    
    @Override
    public StaffInfo selectStaffInfoByLoginName(String loginName) {
        String sql = "SELECT * FROM staff_info WHERE login_name = ? AND delFlag = 0 AND status = 1";
        return new ObjectUtil<StaffInfo>().getOne(sql, StaffInfo.class, loginName);
    }
    
    @Override
    public StaffInfo selectStaffInfoByName(String name) {
        String sql = "SELECT * FROM staff_info WHERE name = ? AND delFlag = 0 AND status = 1";
        return new ObjectUtil<StaffInfo>().getOne(sql, StaffInfo.class, name);
    }
    
    @Override
    public StaffInfo selectStaffInfoById(Integer id) {
        String sql = "SELECT * FROM staff_info WHERE id = ? AND delFlag = 0";
        return new ObjectUtil<StaffInfo>().getOne(sql, StaffInfo.class, id);
    }
}