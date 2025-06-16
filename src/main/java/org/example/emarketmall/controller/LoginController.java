package org.example.emarketmall.controller;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.entity.StaffInfo;
import org.example.emarketmall.entity.UserInfo;
import org.example.emarketmall.dao.StaffInfoDao;
import org.example.emarketmall.dao.impl.StaffInfoDaoImpl;
import org.example.emarketmall.service.user.login.LoginService;
import org.example.emarketmall.utils.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Description: 用户登录控制器
 * @author: april
 * @date: 2022年06月08日 23:17
 */
@WebServlet("/login")
public class LoginController extends HttpServlet {
    private LoginService loginService = new LoginService();
    private StaffInfoDao staffInfoDao = new StaffInfoDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doProcessRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doProcessRequest(req, resp);
    }

    private void doProcessRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserInfo userInfo = ServletUtils.getObjectFromPayload(req, UserInfo.class);

        if (userInfo != null && userInfo.getLoginName() != null) {
            ServletUtils.renderString(resp, JSON.toJSONString(ajaxLogin(req, userInfo.getLoginName(), userInfo.getPassword(), false)));
        } else {
            resp.sendRedirect("/login.jsp");
        }
    }

    private AjaxResult ajaxLogin(HttpServletRequest req, String loginName, String password, Boolean rememberMe) {
        try {
            // 1. 先查询管理员表
            StaffInfo staffInfo = staffInfoDao.selectStaffInfoByLoginName(loginName);
            if (staffInfo != null) {
                // 验证管理员密码
                if (password.equals(staffInfo.getPassword())) {
                    req.getSession().setAttribute("staffInfo", staffInfo);
                    req.getSession().setAttribute("userType", "admin");
                    req.getSession().setAttribute("loginName", loginName);
                    
                    AjaxResult result = AjaxResult.success("管理员登录成功");
                    result.put("userType", "admin");
                    result.put("redirectUrl", "/admin/index.jsp");
                    return result;
                } else {
                    return AjaxResult.error("管理员密码错误");
                }
            }
            
            // 2. 如果管理员表中没有，再查询普通用户表
            if (!rememberMe) {
                UserInfo userInfo = loginService.login(loginName, password);
                if (userInfo != null) {
                    req.getSession().setAttribute("userInfo", userInfo);
                    req.getSession().setAttribute("userType", "user");
                    req.getSession().setAttribute("loginName", loginName);
                    
                    AjaxResult result = AjaxResult.success("用户登录成功");
                    result.put("userType", "user");
                    result.put("redirectUrl", "/web/index.jsp");
                    return result;
                }
            }
        } catch (Exception e) {
            return AjaxResult.error("登录异常：" + e.getMessage());
        }
        return AjaxResult.error("用户不存在或密码错误");
    }
}
