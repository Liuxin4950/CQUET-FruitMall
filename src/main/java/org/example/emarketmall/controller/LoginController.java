package org.example.emarketmall.controller;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.common.BaseException;
import org.example.emarketmall.entity.StaffInfo;
import org.example.emarketmall.entity.UserInfo;
import org.example.emarketmall.service.StaffInfoService;
import org.example.emarketmall.service.impl.StaffInfoServiceImpl;
import org.example.emarketmall.service.user.login.LoginService;
import org.example.emarketmall.utils.ServletUtils;
import org.example.emarketmall.utils.StringUtils;

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
    private StaffInfoService staffInfoService = new StaffInfoServiceImpl();

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
            System.out.println("登录请求，登录名：" + loginName + ", 记住我：" + rememberMe);
            
            // 参数校验
            if (StringUtils.isEmpty(loginName) || StringUtils.isEmpty(password)) {
                return AjaxResult.error("登录名和密码不能为空");
            }
            
            // 1. 先尝试管理员登录
            try {
                StaffInfo staffInfo = staffInfoService.adminLogin(loginName, password);
                System.out.println(staffInfo);

                if (staffInfo != null) {
                    System.out.println("管理员登录成功：" + staffInfo.getLoginName());
                    // 设置会话信息
                    req.getSession().setAttribute("staffInfo", staffInfo);
                    req.getSession().setAttribute("userType", "admin");
                    req.getSession().setAttribute("loginName", loginName);
                    
                    AjaxResult result = AjaxResult.success("管理员登录成功");
                    result.put("userType", "admin");
                    result.put("redirectUrl", "/admin/index.jsp");
                    return result;
                }
            } catch (BaseException e) {
                System.out.println("管理员登录失败：" + e.getMessage());
                // 如果是明确的管理员登录错误（如密码错误），直接返回错误信息
                if (e.getCode() != null && !e.getCode().equals("用户名或密码错误")) {
                    return AjaxResult.error(e.getMessage());
                }
                // 否则继续尝试普通用户登录
            }
            
            // 2. 如果管理员登录失败，尝试普通用户登录
            if (!rememberMe) {
                try {
                    UserInfo userInfo = loginService.login(loginName, password);
                    System.out.println(userInfo);
                    if (userInfo != null) {
                        System.out.println("用户登录成功：" + userInfo.getLoginName());
                        req.getSession().setAttribute("userInfo", userInfo);
                        req.getSession().setAttribute("userType", "user");
                        req.getSession().setAttribute("loginName", loginName);
                        
                        AjaxResult result = AjaxResult.success("用户登录成功");
                        result.put("userType", "user");
                        result.put("redirectUrl", "/web/index.jsp");
                        return result;
                    }
                } catch (BaseException e) {
                    System.out.println("用户登录失败：" + e.getMessage());
                    return AjaxResult.error(e.getMessage());
                }
            }
        } catch (Exception e) {
            System.out.println("登录过程发生异常：" + e.getMessage());
            e.printStackTrace();
            return AjaxResult.error("登录异常：" + e.getMessage());
        }
        
        return AjaxResult.error("用户不存在或密码错误");
    }
}
