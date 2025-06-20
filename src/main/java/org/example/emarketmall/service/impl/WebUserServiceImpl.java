package org.example.emarketmall.service.impl;

import org.example.emarketmall.dao.WebUserDao;
import org.example.emarketmall.dao.impl.WebUserDaoImpl;
import org.example.emarketmall.entity.UserInfo;
import org.example.emarketmall.req.UserUpdateReq;
import org.example.emarketmall.resl.UserInfoResl;
import org.example.emarketmall.service.WebUserService;
import org.example.emarketmall.utils.DateUtils;
import org.example.emarketmall.utils.StringUtils;

import java.util.regex.Pattern;

/**
 * @Description: Web端用户信息Service实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class WebUserServiceImpl implements WebUserService {
    
    private WebUserDao webUserDao;
    
    public WebUserServiceImpl() {
        this.webUserDao = new WebUserDaoImpl();
    }
    
    @Override
    public UserInfoResl selectUserInfoById(Integer userId) throws Exception {
        if (userId == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        
        UserInfoResl userInfo = webUserDao.selectUserInfoById(userId);
        if (userInfo == null) {
            throw new RuntimeException("用户不存在");
        }
        
        return userInfo;
    }
    
    @Override
    public UserInfoResl selectUserInfoByLoginName(String loginName) throws Exception {
        if (StringUtils.isEmpty(loginName)) {
            throw new IllegalArgumentException("登录名不能为空");
        }
        
        UserInfoResl userInfo = webUserDao.selectUserInfoByLoginName(loginName);
        if (userInfo == null) {
            throw new RuntimeException("用户不存在");
        }
        
        return userInfo;
    }
    
    @Override
    public boolean updateUserInfo(UserUpdateReq userUpdateReq) throws Exception {
        // 验证请求参数
        String validationMsg = validateUserUpdateReq(userUpdateReq);
        if (validationMsg != null) {
            throw new IllegalArgumentException(validationMsg);
        }
        
        // 检查邮箱是否已被其他用户使用
        if (!StringUtils.isEmpty(userUpdateReq.getEmail())) {
            boolean emailExists = webUserDao.checkEmailExists(userUpdateReq.getEmail(), userUpdateReq.getUserId());
            if (emailExists) {
                throw new RuntimeException("邮箱已被其他用户使用");
            }
        }
        
        // 检查手机号是否已被其他用户使用
        if (!StringUtils.isEmpty(userUpdateReq.getPhone())) {
            boolean phoneExists = webUserDao.checkPhoneExists(userUpdateReq.getPhone(), userUpdateReq.getUserId());
            if (phoneExists) {
                throw new RuntimeException("手机号已被其他用户使用");
            }
        }
        
        // 设置更新时间
        userUpdateReq.setUpdatedTime(DateUtils.getTime());
        
        return webUserDao.updateUserInfo(userUpdateReq) > 0;
    }
    
    @Override
    public boolean updateUserPassword(UserUpdateReq userUpdateReq) throws Exception {
        // 验证密码更新请求
        String validationMsg = validatePasswordUpdateReq(userUpdateReq);
        if (validationMsg != null) {
            throw new IllegalArgumentException(validationMsg);
        }
        
        // 验证旧密码
        boolean isOldPasswordCorrect = webUserDao.verifyUserPassword(userUpdateReq.getUserId(), userUpdateReq.getOldPassword());
        if (!isOldPasswordCorrect) {
            throw new RuntimeException("旧密码不正确");
        }
        
        // 设置更新时间
        userUpdateReq.setUpdatedTime(DateUtils.getTime());
        
        return webUserDao.updateUserPassword(userUpdateReq.getUserId(), userUpdateReq.getNewPassword()) > 0;
    }
    
    @Override
    public String validateUserUpdateReq(UserUpdateReq userUpdateReq) throws Exception {
        if (userUpdateReq == null) {
            return "请求参数不能为空";
        }
        
        if (userUpdateReq.getUserId() == null) {
            return "用户ID不能为空";
        }
        
        // 验证姓名
        if (!StringUtils.isEmpty(userUpdateReq.getName())) {
            if (userUpdateReq.getName().length() > 50) {
                return "姓名长度不能超过50个字符";
            }
        }
        
        // 验证昵称
        if (!StringUtils.isEmpty(userUpdateReq.getNickname())) {
            if (userUpdateReq.getNickname().length() > 50) {
                return "昵称长度不能超过50个字符";
            }
        }
        
        // 验证邮箱格式
        if (!StringUtils.isEmpty(userUpdateReq.getEmail())) {
            String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
            if (!Pattern.matches(emailRegex, userUpdateReq.getEmail())) {
                return "邮箱格式不正确";
            }
        }
        
        // 验证手机号格式
        if (!StringUtils.isEmpty(userUpdateReq.getPhone())) {
            String phoneRegex = "^1[3-9]\\d{9}$";
            if (!Pattern.matches(phoneRegex, userUpdateReq.getPhone())) {
                return "手机号格式不正确";
            }
        }
        
        return null; // 验证通过
    }
    
    @Override
    public String validatePasswordUpdateReq(UserUpdateReq userUpdateReq) throws Exception {
        if (userUpdateReq == null) {
            return "请求参数不能为空";
        }
        
        if (userUpdateReq.getUserId() == null) {
            return "用户ID不能为空";
        }
        
        if (StringUtils.isEmpty(userUpdateReq.getOldPassword())) {
            return "旧密码不能为空";
        }
        
        if (StringUtils.isEmpty(userUpdateReq.getNewPassword())) {
            return "新密码不能为空";
        }
        
        if (StringUtils.isEmpty(userUpdateReq.getConfirmPassword())) {
            return "确认新密码不能为空";
        }
        
        // 验证新密码长度
        if (userUpdateReq.getNewPassword().length() < 6 || userUpdateReq.getNewPassword().length() > 20) {
            return "新密码长度必须在6-20个字符之间";
        }
        
        // 验证新密码和确认密码是否一致
        if (!userUpdateReq.getNewPassword().equals(userUpdateReq.getConfirmPassword())) {
            return "新密码和确认密码不一致";
        }
        
        // 验证新密码和旧密码不能相同
        if (userUpdateReq.getNewPassword().equals(userUpdateReq.getOldPassword())) {
            return "新密码不能与旧密码相同";
        }
        
        return null; // 验证通过
    }
    
    @Override
    public boolean updateLastLoginTime(Integer userId) throws Exception {
        if (userId == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        
        return webUserDao.updateLastLoginTime(userId) > 0;
    }
}