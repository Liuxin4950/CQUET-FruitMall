package org.example.emarketmall.controller.web;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.entity.ProductCategory;
import org.example.emarketmall.service.WebCategoryService;
import org.example.emarketmall.service.impl.WebCategoryServiceImpl;
import org.example.emarketmall.utils.ServletUtils;
import org.example.emarketmall.utils.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * @Description: Web端商品分类控制器
 * @author: system
 * @date: 2024年12月19日
 */
@WebServlet("/web/category")
public class WebCategoryController extends HttpServlet {
    
    private WebCategoryService webCategoryService = new WebCategoryServiceImpl();
    
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
        String parentId = req.getParameter("parentId");
        String categoryName = req.getParameter("categoryName");
        String limit = req.getParameter("limit");
        
        System.out.println("WebCategoryController - opt: " + opt + ", id: " + id + ", parentId: " + parentId + ", categoryName: " + categoryName);
        
        if (StringUtils.isEmpty(opt)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("操作选项opt内容异常")));
            return;
        }
        
        try {
            switch (opt) {
                case "firstLevel":
                    // 查询一级分类
                    handleFirstLevelCategories(req, resp);
                    break;
                case "children":
                    // 根据父级ID查询子分类
                    handleCategoriesByParentId(req, resp, parentId);
                    break;
                case "detail":
                    // 查询分类详情
                    handleCategoryDetail(req, resp, id);
                    break;
                case "tree":
                    // 查询分类树
                    handleCategoryTree(req, resp);
                    break;
                case "search":
                    // 根据名称搜索分类
                    handleSearchCategories(req, resp, categoryName);
                    break;
                case "hot":
                    // 查询热门分类
                    handleHotCategories(req, resp, limit);
                    break;
                case "navigation":
                    // 获取导航数据
                    handleNavigationData(req, resp);
                    break;
                case "path":
                    // 获取分类路径（面包屑导航）
                    handleCategoryPath(req, resp, id);
                    break;
                default:
                    ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("不支持的操作类型: " + opt)));
                    break;
            }
        } catch (Exception e) {
            System.err.println("WebCategoryController处理请求时发生错误: " + e.getMessage());
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("服务器内部错误: " + e.getMessage())));
        }
    }
    
    /**
     * 处理一级分类查询
     */
    private void handleFirstLevelCategories(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<ProductCategory> categories = webCategoryService.selectFirstLevelCategories();
        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(categories)));
    }
    
    /**
     * 处理根据父级ID查询子分类
     */
    private void handleCategoriesByParentId(HttpServletRequest req, HttpServletResponse resp, String parentId) throws Exception {
        if (StringUtils.isEmpty(parentId)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("父级分类ID不能为空")));
            return;
        }
        
        try {
            Integer parentCategoryId = Integer.parseInt(parentId);
            List<ProductCategory> categories = webCategoryService.selectCategoriesByParentId(parentCategoryId);
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(categories)));
        } catch (NumberFormatException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("父级分类ID格式不正确")));
        }
    }
    
    /**
     * 处理分类详情查询
     */
    private void handleCategoryDetail(HttpServletRequest req, HttpServletResponse resp, String id) throws Exception {
        if (StringUtils.isEmpty(id)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("分类ID不能为空")));
            return;
        }
        
        try {
            Integer categoryId = Integer.parseInt(id);
            ProductCategory category = webCategoryService.selectCategoryById(categoryId);
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(category)));
        } catch (NumberFormatException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("分类ID格式不正确")));
        }
    }
    
    /**
     * 处理分类树查询
     */
    private void handleCategoryTree(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Map<ProductCategory, List<ProductCategory>> categoryTree = webCategoryService.selectCategoryTree();
        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(categoryTree)));
    }
    
    /**
     * 处理分类搜索
     */
    private void handleSearchCategories(HttpServletRequest req, HttpServletResponse resp, String categoryName) throws Exception {
        if (StringUtils.isEmpty(categoryName)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("分类名称不能为空")));
            return;
        }
        
        List<ProductCategory> categories = webCategoryService.selectCategoriesByName(categoryName);
        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(categories)));
    }
    
    /**
     * 处理热门分类查询
     */
    private void handleHotCategories(HttpServletRequest req, HttpServletResponse resp, String limit) throws Exception {
        Integer limitNum = StringUtils.isEmpty(limit) ? 10 : Integer.parseInt(limit);
        List<ProductCategory> categories = webCategoryService.selectHotCategories(limitNum);
        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(categories)));
    }
    
    /**
     * 处理导航数据获取
     */
    private void handleNavigationData(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Map<String, Object> navigationData = webCategoryService.getNavigationData();
        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(navigationData)));
    }
    
    /**
     * 处理分类路径获取（面包屑导航）
     */
    private void handleCategoryPath(HttpServletRequest req, HttpServletResponse resp, String id) throws Exception {
        if (StringUtils.isEmpty(id)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("分类ID不能为空")));
            return;
        }
        
        try {
            Integer categoryId = Integer.parseInt(id);
            List<ProductCategory> path = webCategoryService.getCategoryPath(categoryId);
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(path)));
        } catch (NumberFormatException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("分类ID格式不正确")));
        }
    }
}