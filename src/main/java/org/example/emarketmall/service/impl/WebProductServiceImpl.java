package org.example.emarketmall.service.impl;

import org.example.emarketmall.common.TableDataInfo;
import org.example.emarketmall.dao.WebProductDao;
import org.example.emarketmall.dao.impl.WebProductDaoImpl;
import org.example.emarketmall.req.ProductQueryReq;
import org.example.emarketmall.resl.ProductDisplayResl;
import org.example.emarketmall.service.WebProductService;
import org.example.emarketmall.utils.PageUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description: Web端商品展示Service实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class WebProductServiceImpl implements WebProductService {
    
    private WebProductDao webProductDao;
    
    public WebProductServiceImpl() {
        this.webProductDao = new WebProductDaoImpl();
    }
    
    @Override
    public TableDataInfo selectProductDisplayList(ProductQueryReq queryReq) throws Exception {
        // 设置默认分页参数
        if (queryReq.getPageNum() == null) {
            queryReq.setPageNum(1);
        }
        if (queryReq.getPageSize() == null) {
            queryReq.setPageSize(10);
        }
        
        // 查询数据列表
        List<ProductDisplayResl> list = webProductDao.selectProductDisplayList(queryReq);
        
        // 查询总数
        int total = webProductDao.selectProductDisplayCount(queryReq);
        
        // 构建分页结果
        TableDataInfo dataTable = new TableDataInfo();
        dataTable.setCode(200);
        dataTable.setMsg("查询成功");
        dataTable.setRows(list);
        dataTable.setTotal(total);
        
        return dataTable;
    }
    
    @Override
    public ProductDisplayResl selectProductDisplayById(Integer productId) throws Exception {
        if (productId == null) {
            throw new IllegalArgumentException("商品ID不能为空");
        }
        
        ProductDisplayResl product = webProductDao.selectProductDisplayById(productId);
        if (product == null) {
            throw new RuntimeException("商品不存在或已下架");
        }
        
        return product;
    }
    
    @Override
    public List<ProductDisplayResl> selectRecommendedProducts(Integer limit) throws Exception {
        if (limit == null || limit <= 0) {
            limit = 10;
        }
        
        return webProductDao.selectRecommendedProducts(limit);
    }
    
    @Override
    public List<ProductDisplayResl> selectHotProducts(Integer limit) throws Exception {
        if (limit == null || limit <= 0) {
            limit = 10;
        }
        
        return webProductDao.selectHotProducts(limit);
    }
    
    @Override
    public List<ProductDisplayResl> selectNewProducts(Integer limit) throws Exception {
        if (limit == null || limit <= 0) {
            limit = 10;
        }
        
        return webProductDao.selectNewProducts(limit);
    }
    
    @Override
    public List<ProductDisplayResl> selectProductsByCategory(Integer categoryId, Integer limit) throws Exception {
        if (categoryId == null) {
            throw new IllegalArgumentException("分类ID不能为空");
        }
        
        if (limit == null || limit <= 0) {
            limit = 10;
        }
        
        return webProductDao.selectProductsByCategory(categoryId, limit);
    }
    
    @Override
    public List<ProductDisplayResl> searchProducts(String keyword, Integer limit) throws Exception {
        if (keyword == null || keyword.trim().isEmpty()) {
            throw new IllegalArgumentException("搜索关键词不能为空");
        }
        
        if (limit == null || limit <= 0) {
            limit = 20;
        }
        
        return webProductDao.searchProducts(keyword.trim(), limit);
    }
    
    @Override
    public Map<String, Object> getHomePageData() throws Exception {
        Map<String, Object> homeData = new HashMap<>();
        
        try {
            // 获取推荐商品（6个）
            List<ProductDisplayResl> recommendedProducts = selectRecommendedProducts(6);
            homeData.put("recommendedProducts", recommendedProducts);
            
            // 获取热销商品（8个）
            List<ProductDisplayResl> hotProducts = selectHotProducts(8);
            homeData.put("hotProducts", hotProducts);
            
            // 获取新品商品（8个）
            List<ProductDisplayResl> newProducts = selectNewProducts(8);
            homeData.put("newProducts", newProducts);
            
            // 获取有机商品（4个）
            ProductQueryReq organicQuery = new ProductQueryReq();
            organicQuery.setIsOrganic(true);
            organicQuery.setPageNum(1);
            organicQuery.setPageSize(4);
            TableDataInfo organicData = selectProductDisplayList(organicQuery);
            homeData.put("organicProducts", organicData.getRows());
            
            // 获取季节性商品（4个）
            ProductQueryReq seasonalQuery = new ProductQueryReq();
            seasonalQuery.setIsSeasonal(true);
            seasonalQuery.setPageNum(1);
            seasonalQuery.setPageSize(4);
            TableDataInfo seasonalData = selectProductDisplayList(seasonalQuery);
            homeData.put("seasonalProducts", seasonalData.getRows());
            
        } catch (Exception e) {
            // 如果获取某个模块数据失败，记录错误但不影响其他模块
            System.err.println("获取首页数据时发生错误: " + e.getMessage());
            e.printStackTrace();
        }
        
        return homeData;
    }
}