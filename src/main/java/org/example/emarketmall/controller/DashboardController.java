package org.example.emarketmall.controller;

import com.google.gson.Gson;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.service.DashboardService;
import org.example.emarketmall.service.impl.DashboardServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

/**
 * @Description: 数据统计Controller
 * @author: system
 * @date: 2024年12月19日
 */
@WebServlet("/dashboard/*")
public class DashboardController extends HttpServlet {

    private DashboardService dashboardService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dashboardService = new DashboardServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doProcessRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doProcessRequest(request, response);
    }

    private void doProcessRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String pathInfo = request.getPathInfo();
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        
        try {
            if ("/data".equals(pathInfo)) {
                // 获取仪表盘数据
                Map<String, Object> dashboardData = dashboardService.getDashboardData();
                AjaxResult result = AjaxResult.success("获取数据成功", dashboardData);
                out.print(gson.toJson(result));
            } else {
                AjaxResult result = AjaxResult.error("请求路径不存在");
                out.print(gson.toJson(result));
            }
        } catch (Exception e) {
            e.printStackTrace();
            AjaxResult result = AjaxResult.error("服务器内部错误: " + e.getMessage());
            out.print(gson.toJson(result));
        } finally {
            out.flush();
            out.close();
        }
    }
}