package org.example.emarketmall.controller.web;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.req.UserUpdateReq;
import org.example.emarketmall.resl.UserInfoResl;
import org.example.emarketmall.service.WebUserService;
import org.example.emarketmall.service.impl.WebUserServiceImpl;
import org.example.emarketmall.utils.ServletUtils;
import org.example.emarketmall.utils.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @Description: Web端用户信息控制器
 * @author: system
 * @date: 2024年12月19日
 */
@WebServlet("/web/user")
public class WebUserController extends HttpServlet {
    
    private WebUserService webUserService = new WebUserServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doProcessRequest(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doProcessRequest(req, resp);
    }
    
    private void doProcessRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        String opt = req.getParameter("opt");
        String id = req.getParameter("id");
        String loginName = req.getParameter("loginName");
        
        System.out.println("WebUserController - opt: " + opt + ", id: " + id + ", loginName: " + loginName);
        
        if (StringUtils.isEmpty(opt)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("操作选项opt内容异常")));
            return;
        }
        
        try {
            switch (opt) {
                case "info":
                    // 查询用户信息
                    handleUserInfo(req, resp, id, loginName);
                    break;
                case "profile":
                    // 获取当前登录用户信息
                    handleUserProfile(req, resp);
                    break;
                case "update":
                    // 更新用户基本信息
                    handleUpdateUserInfo(req, resp);
                    break;
                case "updatePassword":
                    // 更新用户密码
                    handleUpdatePassword(req, resp);
                    break;
                case "updateLoginTime":
                    // 更新最后登录时间
                    handleUpdateLoginTime(req, resp);
                    break;
                default:
                    ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("不支持的操作类型: " + opt)));
                    break;
            }
        } catch (Exception e) {
            System.err.println("WebUserController处理请求时发生错误: " + e.getMessage());
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("服务器内部错误: " + e.getMessage())));
        }
    }
    
    /**
     * 处理用户信息查询
     */
    private void handleUserInfo(HttpServletRequest req, HttpServletResponse resp, String id, String loginName) throws Exception {
        UserInfoResl userInfo = null;
        
        if (!StringUtils.isEmpty(id)) {
            try {
                Integer userId = Integer.parseInt(id);
                userInfo = webUserService.selectUserInfoById(userId);
            } catch (NumberFormatException e) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户ID格式不正确")));
                return;
            }
        } else if (!StringUtils.isEmpty(loginName)) {
            userInfo = webUserService.selectUserInfoByLoginName(loginName);
        } else {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户ID或登录名不能为空")));
            return;
        }
        
        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(userInfo)));
    }
    
    /**
     * 处理获取当前登录用户信息
     */
    private void handleUserProfile(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        HttpSession session = req.getSession();
        Object userIdObj = session.getAttribute("userId");
        Object loginNameObj = session.getAttribute("loginName");
        
        if (userIdObj == null && loginNameObj == null) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户未登录")));
            return;
        }
        
        UserInfoResl userInfo = null;
        
        if (userIdObj != null) {
            try {
                Integer userId = Integer.parseInt(userIdObj.toString());
                userInfo = webUserService.selectUserInfoById(userId);
            } catch (NumberFormatException e) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户ID格式不正确")));
                return;
            }
        } else if (loginNameObj != null) {
            userInfo = webUserService.selectUserInfoByLoginName(loginNameObj.toString());
        }
        
        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(userInfo)));
    }
    
    /**
     * 处理更新用户基本信息
     */
    private void handleUpdateUserInfo(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // 检查用户是否登录
        HttpSession session = req.getSession();
        Object userIdObj = session.getAttribute("userId");
        
        if (userIdObj == null) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户未登录")));
            return;
        }
        
        UserUpdateReq userUpdateReq = ServletUtils.getObjectFromPayload(req, UserUpdateReq.class);
        if (userUpdateReq == null) {
            // 从URL参数获取更新信息
            userUpdateReq = new UserUpdateReq();
            String name = req.getParameter("name");
            String nickname = req.getParameter("nickname");
            String avatar = req.getParameter("avatar");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            
            userUpdateReq.setId(Integer.parseInt(userIdObj.toString()));
            if (!StringUtils.isEmpty(name)) {
                userUpdateReq.setName(name);
            }
            if (!StringUtils.isEmpty(nickname)) {
                userUpdateReq.setNickname(nickname);
            }
            if (!StringUtils.isEmpty(avatar)) {
                userUpdateReq.setAvatar(avatar);
            }
            if (!StringUtils.isEmpty(email)) {
                userUpdateReq.setEmail(email);
            }
            if (!StringUtils.isEmpty(phone)) {
                userUpdateReq.setPhone(phone);
            }
        } else {
            // 确保更新的是当前登录用户的信息
            userUpdateReq.setId(Integer.parseInt(userIdObj.toString()));
        }
        
        boolean result = webUserService.updateUserInfo(userUpdateReq);
        if (result) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("用户信息更新成功")));
        } else {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户信息更新失败")));
        }
    }
    
    /**
     * 处理更新用户密码
     */
    private void handleUpdatePassword(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // 检查用户是否登录
        HttpSession session = req.getSession();
        Object userIdObj = session.getAttribute("userId");
        
        if (userIdObj == null) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户未登录")));
            return;
        }
        
        UserUpdateReq userUpdateReq = ServletUtils.getObjectFromPayload(req, UserUpdateReq.class);
        if (userUpdateReq == null) {
            // 从URL参数获取密码信息
            userUpdateReq = new UserUpdateReq();
            String oldPassword = req.getParameter("oldPassword");
            String newPassword = req.getParameter("newPassword");
            String confirmNewPassword = req.getParameter("confirmNewPassword");
            
            userUpdateReq.setId(Integer.parseInt(userIdObj.toString()));
            userUpdateReq.setOldPassword(oldPassword);
            userUpdateReq.setNewPassword(newPassword);
            userUpdateReq.setConfirmPassword(confirmNewPassword);
        } else {
            // 确保更新的是当前登录用户的密码
            userUpdateReq.setId(Integer.parseInt(userIdObj.toString()));
        }
        
        boolean result = webUserService.updateUserPassword(userUpdateReq);
        if (result) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("密码更新成功")));
        } else {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("密码更新失败")));
        }
    }
    
    /**
     * 处理更新最后登录时间
     */
    private void handleUpdateLoginTime(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // 检查用户是否登录
        HttpSession session = req.getSession();
        Object userIdObj = session.getAttribute("userId");
        
        if (userIdObj == null) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户未登录")));
            return;
        }
        
        try {
            Integer userId = Integer.parseInt(userIdObj.toString());
            boolean result = webUserService.updateLastLoginTime(userId);
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("登录时间更新成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("登录时间更新失败")));
            }
        } catch (NumberFormatException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户ID格式不正确")));
        }
    }
}