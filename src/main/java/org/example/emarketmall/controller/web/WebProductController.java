package org.example.emarketmall.controller.web;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.common.TableDataInfo;
import org.example.emarketmall.req.ProductQueryReq;
import org.example.emarketmall.resl.ProductDisplayResl;
import org.example.emarketmall.service.WebProductService;
import org.example.emarketmall.service.impl.WebProductServiceImpl;
import org.example.emarketmall.utils.ServletUtils;
import org.example.emarketmall.utils.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * @Description: Web端商品展示控制器
 * @author: system
 * @date: 2024年12月19日
 */
@WebServlet("/web/product")
public class WebProductController extends HttpServlet {
    
    private WebProductService webProductService = new WebProductServiceImpl();
    
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
        String keyword = req.getParameter("keyword");
        String categoryId = req.getParameter("categoryId");
        String limit = req.getParameter("limit");
        
        System.out.println("WebProductController - opt: " + opt + ", id: " + id + ", keyword: " + keyword + ", categoryId: " + categoryId);
        
        if (StringUtils.isEmpty(opt)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("操作选项opt内容异常")));
            return;
        }
        
        try {
            switch (opt) {
                case "list":
                    // 分页查询商品列表
                    handleProductList(req, resp);
                    break;
                case "detail":
                    // 查询商品详情
                    handleProductDetail(req, resp, id);
                    break;
                case "recommended":
                    // 查询推荐商品
                    handleRecommendedProducts(req, resp, limit);
                    break;
                case "hot":
                    // 查询热销商品
                    handleHotProducts(req, resp, limit);
                    break;
                case "new":
                    // 查询新品商品
                    handleNewProducts(req, resp, limit);
                    break;
                case "category":
                    // 根据分类查询商品
                    handleProductsByCategory(req, resp, categoryId, limit);
                    break;
                case "search":
                    // 搜索商品
                    handleSearchProducts(req, resp, keyword, limit);
                    break;
                case "home":
                    // 获取首页数据
                    handleHomePageData(req, resp);
                    break;
                default:
                    ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("不支持的操作类型: " + opt)));
                    break;
            }
        } catch (Exception e) {
            System.err.println("WebProductController处理请求时发生错误: " + e.getMessage());
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("服务器内部错误: " + e.getMessage())));
        }
    }
    
    /**
     * 处理商品列表查询
     */
    private void handleProductList(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ProductQueryReq queryReq = ServletUtils.getObjectFromPayload(req, ProductQueryReq.class);
        if (queryReq == null) {
            queryReq = new ProductQueryReq();
            // 从URL参数获取查询条件
            String pageNum = req.getParameter("pageNum");
            String pageSize = req.getParameter("pageSize");
            String productName = req.getParameter("productName");
            String oneCategoryId = req.getParameter("oneCategoryId");
            String twoCategoryId = req.getParameter("twoCategoryId");
            String minPrice = req.getParameter("minPrice");
            String maxPrice = req.getParameter("maxPrice");
            String isOrganic = req.getParameter("isOrganic");
            String isSeasonal = req.getParameter("isSeasonal");
            String originPlace = req.getParameter("originPlace");
            String sortField = req.getParameter("sortField");
            String sortOrder = req.getParameter("sortOrder");
            String onlyRecommended = req.getParameter("onlyRecommended");
            
            if (!StringUtils.isEmpty(pageNum)) {
                queryReq.setPageNum(Integer.parseInt(pageNum));
            }
            if (!StringUtils.isEmpty(pageSize)) {
                queryReq.setPageSize(Integer.parseInt(pageSize));
            }
            if (!StringUtils.isEmpty(productName)) {
                queryReq.setProductName(productName);
            }
            if (!StringUtils.isEmpty(oneCategoryId)) {
                queryReq.setOneCategoryId(Integer.parseInt(oneCategoryId));
            }
            if (!StringUtils.isEmpty(twoCategoryId)) {
                queryReq.setTwoCategoryId(Integer.parseInt(twoCategoryId));
            }
            if (!StringUtils.isEmpty(minPrice)) {
                queryReq.setMinPrice(BigDecimal.valueOf(Double.parseDouble(minPrice)));
            }
            if (!StringUtils.isEmpty(maxPrice)) {
                queryReq.setMaxPrice(BigDecimal.valueOf(Double.parseDouble(maxPrice)));
            }
            if (!StringUtils.isEmpty(isOrganic)) {
                queryReq.setIsOrganic(Boolean.parseBoolean(isOrganic));
            }
            if (!StringUtils.isEmpty(isSeasonal)) {
                queryReq.setIsSeasonal(Boolean.parseBoolean(isSeasonal));
            }
            if (!StringUtils.isEmpty(originPlace)) {
                queryReq.setOriginPlace(originPlace);
            }
            if (!StringUtils.isEmpty(sortField)) {
                queryReq.setSortField(sortField);
            }
            if (!StringUtils.isEmpty(sortOrder)) {
                queryReq.setSortOrder(sortOrder);
            }
            if (!StringUtils.isEmpty(onlyRecommended)) {
                queryReq.setOnlyRecommended(Boolean.parseBoolean(onlyRecommended));
            }
        }
        
        TableDataInfo dataTable = webProductService.selectProductDisplayList(queryReq);
        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(dataTable)));
    }
    
    /**
     * 处理商品详情查询
     */
    private void handleProductDetail(HttpServletRequest req, HttpServletResponse resp, String id) throws Exception {
        if (StringUtils.isEmpty(id)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("商品ID不能为空")));
            return;
        }
        
        try {
            Integer productId = Integer.parseInt(id);
            ProductDisplayResl product = webProductService.selectProductDisplayById(productId);
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(product)));
        } catch (NumberFormatException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("商品ID格式不正确")));
        }
    }
    
    /**
     * 处理推荐商品查询
     */
    private void handleRecommendedProducts(HttpServletRequest req, HttpServletResponse resp, String limit) throws Exception {
        Integer limitNum = StringUtils.isEmpty(limit) ? 10 : Integer.parseInt(limit);
        List<ProductDisplayResl> products = webProductService.selectRecommendedProducts(limitNum);
        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(products)));
    }
    
    /**
     * 处理热销商品查询
     */
    private void handleHotProducts(HttpServletRequest req, HttpServletResponse resp, String limit) throws Exception {
        Integer limitNum = StringUtils.isEmpty(limit) ? 10 : Integer.parseInt(limit);
        List<ProductDisplayResl> products = webProductService.selectHotProducts(limitNum);
        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(products)));
    }
    
    /**
     * 处理新品商品查询
     */
    private void handleNewProducts(HttpServletRequest req, HttpServletResponse resp, String limit) throws Exception {
        Integer limitNum = StringUtils.isEmpty(limit) ? 10 : Integer.parseInt(limit);
        List<ProductDisplayResl> products = webProductService.selectNewProducts(limitNum);
        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(products)));
    }
    
    /**
     * 处理根据分类查询商品
     */
    private void handleProductsByCategory(HttpServletRequest req, HttpServletResponse resp, String categoryId, String limit) throws Exception {
        if (StringUtils.isEmpty(categoryId)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("分类ID不能为空")));
            return;
        }
        
        try {
            Integer catId = Integer.parseInt(categoryId);
            Integer limitNum = StringUtils.isEmpty(limit) ? 10 : Integer.parseInt(limit);
            List<ProductDisplayResl> products = webProductService.selectProductsByCategory(catId, limitNum);
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(products)));
        } catch (NumberFormatException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("分类ID格式不正确")));
        }
    }
    
    /**
     * 处理商品搜索
     */
    private void handleSearchProducts(HttpServletRequest req, HttpServletResponse resp, String keyword, String limit) throws Exception {
        if (StringUtils.isEmpty(keyword)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("搜索关键词不能为空")));
            return;
        }
        
        Integer limitNum = StringUtils.isEmpty(limit) ? 20 : Integer.parseInt(limit);
        List<ProductDisplayResl> products = webProductService.searchProducts(keyword, limitNum);
        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(products)));
    }
    
    /**
     * 处理首页数据获取
     */
    private void handleHomePageData(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Map<String, Object> homeData = webProductService.getHomePageData();
        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(homeData)));
    }
}