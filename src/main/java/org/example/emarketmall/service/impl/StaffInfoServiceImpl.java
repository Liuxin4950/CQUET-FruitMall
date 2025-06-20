package org.example.emarketmall.service.impl;

import org.apache.shiro.crypto.hash.Md5Hash;
import org.example.emarketmall.common.BaseException;
import org.example.emarketmall.dao.StaffInfoDao;
import org.example.emarketmall.dao.impl.StaffInfoDaoImpl;
import org.example.emarketmall.entity.StaffInfo;
import org.example.emarketmall.service.StaffInfoService;
import org.example.emarketmall.utils.LogUtils;
import org.example.emarketmall.utils.StringUtils;

/**
 * 员工信息服务实现类
 * @author system
 * @date 2024
 */
public class StaffInfoServiceImpl implements StaffInfoService {
    
    private StaffInfoDao staffInfoDao;
    
    public StaffInfoServiceImpl() {
        this.staffInfoDao = new StaffInfoDaoImpl();
    }
    
    public StaffInfoServiceImpl(StaffInfoDao staffInfoDao) {
        this.staffInfoDao = staffInfoDao;
    }
    
    @Override
    public StaffInfo adminLogin(String loginName, String password) {
        String module = "staff_info";
        
        // 参数校验
        if (StringUtils.isEmpty(loginName) || StringUtils.isEmpty(password)) {
            throw new BaseException(module, "登录名和密码不能为空", null);
        }
        
        // 登录名长度校验
        if (loginName.length() < 2 || loginName.length() > 20) {
            throw new BaseException(module, "登录名长度应在2-20个字符之间", null);
        }
        
        // 密码长度校验
        if (password.length() < 6 || password.length() > 20) {
            throw new BaseException(module, "密码长度应在6-20个字符之间", null);
        }
        
        // 查询管理员信息
        StaffInfo staffInfo = staffInfoDao.selectStaffInfoByLoginName(loginName);
        if (staffInfo == null) {
            System.out.println("管理员登录失败：用户名不存在 - " + loginName);
            throw new BaseException(module, "用户名或密码错误", null);
        }
        
        // 密码验证 - 使用MD5加密后比较
        String encryptedPassword = new Md5Hash(password).toHex();
        System.out.println("登录请求，登录名：" + loginName + ", 密码：" + encryptedPassword);
        if (!encryptedPassword.equals(staffInfo.getPassword())) {
            System.out.println("管理员登录失败：密码错误 - " + loginName);
            throw new BaseException(module, "用户名或密码错误", null);
        }
        
        // 状态检查
        if (staffInfo.getStatus() == null || staffInfo.getStatus() != 1) {
            System.out.println("管理员登录失败：账户已禁用 - " + loginName);
            throw new BaseException(module, "账户已被禁用，请联系系统管理员", null);
        }
        
        // 删除标志检查
        if (staffInfo.getDelFlag() == null || staffInfo.getDelFlag() != 0) {
            System.out.println("管理员登录失败：账户已删除 - " + loginName);
            throw new BaseException(module, "账户不存在", null);
        }
        
        System.out.println("管理员登录成功：" + loginName + " - " + staffInfo.getName());
        return staffInfo;
    }
    
    @Override
    public StaffInfo selectStaffInfoByLoginName(String loginName) {
        if (StringUtils.isEmpty(loginName)) {
            return null;
        }
        return staffInfoDao.selectStaffInfoByLoginName(loginName);
    }
    
    @Override
    public StaffInfo selectStaffInfoByName(String name) {
        if (StringUtils.isEmpty(name)) {
            return null;
        }
        return staffInfoDao.selectStaffInfoByName(name);
    }
    
    @Override
    public StaffInfo selectStaffInfoById(Integer id) {
        if (id == null || id <= 0) {
            return null;
        }
        return staffInfoDao.selectStaffInfoById(id);
    }
    

}