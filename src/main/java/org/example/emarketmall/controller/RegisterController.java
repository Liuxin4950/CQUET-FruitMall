package org.example.emarketmall.controller;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.entity.UserInfo;
import org.example.emarketmall.service.user.login.RegisterService;
import org.example.emarketmall.utils.ServletUtils;
import org.example.emarketmall.utils.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

/**
 * @Description: TODO
 * @author: april
 * @date: 2022年06月08日 23:17
 */

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private RegisterService registerService = new RegisterService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doProcessRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doProcessRequest(req, resp);
    }

    private void doProcessRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置请求和响应编码
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        System.out.println("进入注册流程---------------------------------");
        
        // 直接从请求参数获取数据
        String loginName = req.getParameter("loginName");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        
        if (StringUtils.isNotEmpty(loginName) && StringUtils.isNotEmpty(password) && StringUtils.isNotEmpty(phone)) {
            UserInfo userInfo = new UserInfo();
            userInfo.setLoginName(loginName);
            userInfo.setPassword(password);
            userInfo.setPhone(phone);
            userInfo.setDelFlag(0);
            
            System.out.println("注册用户信息: " + JSON.toJSONString(userInfo));
            
            String msg = registerService.register(userInfo);
            System.out.println("注册结果: " + msg);
            if (StringUtils.isEmpty(msg)) {
                msg = "注册服务异常";
            }
            if ("注册成功".equalsIgnoreCase(msg)) {
                // 注册成功，返回JSON响应给前端
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(msg)));
                System.out.println("注册成功！跳转");
            } else {
                // 注册失败，返回错误信息
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error(msg)));
                System.out.println("注册失败：" + msg);
            }

        } else {
            System.out.println("参数不完整，重定向到注册页面");
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("参数不完整")));
        }
        
        System.out.println("关闭注册流程---------------------------------");
    }

    private void logHeaderValue(HttpServletResponse resp){
        Collection<String> headerNames = resp.getHeaderNames();
        headerNames.forEach(name -> {
            System.out.println(name + ": " + resp.getHeader(name));
        });
    }
}
