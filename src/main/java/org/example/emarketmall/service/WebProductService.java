package org.example.emarketmall.service;

import org.example.emarketmall.common.TableDataInfo;
import org.example.emarketmall.req.ProductQueryReq;
import org.example.emarketmall.resl.ProductDisplayResl;

import java.util.List;

/**
 * @Description: Web端商品展示Service接口
 * @author: system
 * @date: 2024年12月19日
 */
public interface WebProductService {
    
    /**
     * 分页查询商品展示列表
     * @param queryReq 查询参数
     * @return 分页结果
     * @throws Exception
     */
    TableDataInfo selectProductDisplayList(ProductQueryReq queryReq) throws Exception;
    
    /**
     * 根据ID查询商品详情
     * @param productId 商品ID
     * @return 商品详情
     * @throws Exception
     */
    ProductDisplayResl selectProductDisplayById(Integer productId) throws Exception;
    
    /**
     * 查询推荐商品列表
     * @param limit 限制数量
     * @return 推荐商品列表
     * @throws Exception
     */
    List<ProductDisplayResl> selectRecommendedProducts(Integer limit) throws Exception;
    
    /**
     * 查询热销商品列表
     * @param limit 限制数量
     * @return 热销商品列表
     * @throws Exception
     */
    List<ProductDisplayResl> selectHotProducts(Integer limit) throws Exception;
    
    /**
     * 查询新品商品列表
     * @param limit 限制数量
     * @return 新品商品列表
     * @throws Exception
     */
    List<ProductDisplayResl> selectNewProducts(Integer limit) throws Exception;
    
    /**
     * 根据分类查询商品列表
     * @param categoryId 分类ID
     * @param limit 限制数量
     * @return 商品列表
     * @throws Exception
     */
    List<ProductDisplayResl> selectProductsByCategory(Integer categoryId, Integer limit) throws Exception;
    
    /**
     * 搜索商品（根据关键词）
     * @param keyword 关键词
     * @param limit 限制数量
     * @return 商品列表
     * @throws Exception
     */
    List<ProductDisplayResl> searchProducts(String keyword, Integer limit) throws Exception;
    
    /**
     * 获取首页推荐数据
     * @return 首页推荐数据
     * @throws Exception
     */
    java.util.Map<String, Object> getHomePageData() throws Exception;
}