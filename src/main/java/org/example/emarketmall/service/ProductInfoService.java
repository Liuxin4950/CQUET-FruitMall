package org.example.emarketmall.service;

import org.example.emarketmall.entity.ProductInfo;

import java.util.List;

public interface ProductInfoService {
    
    /**
     * 根据条件查询商品列表
     *
     * @param productInfo 商品信息
     * @return 商品列表
     */
    List<ProductInfo> selectProductInfoList(ProductInfo productInfo) throws Exception;

    /**
     * 通过商品ID查询商品详细信息
     *
     * @param id 商品ID
     * @return 商品信息
     */
    ProductInfo selectProductInfoById(Integer id) throws Exception;

    /**
     * 新增商品信息
     *
     * @param productInfo 商品信息
     * @return 结果
     */
    int insertProductInfo(ProductInfo productInfo) throws Exception;

    /**
     * 修改商品信息
     *
     * @param productInfo 商品信息
     * @return 结果
     */
    int updateProductInfo(ProductInfo productInfo) throws Exception;

    /**
     * 修改商品信息（带更新人信息）
     *
     * @param productInfo 商品信息
     * @param updatedBy 更新人
     * @return 结果
     */
    int updateProductInfo(ProductInfo productInfo, String updatedBy) throws Exception;

    /**
     * 删除商品信息
     *
     * @param id 商品ID
     * @return 结果
     */
    int deleteProductInfoById(Integer id) throws Exception;

    /**
     * 批量删除商品信息
     *
     * @param ids 需要删除的商品ID
     * @return 结果
     */
    int deleteProductInfoByIds(Integer[] ids) throws Exception;

    /**
     * 根据商品名称查询商品列表
     *
     * @param productName 商品名称
     * @return 商品列表
     */
    List<ProductInfo> selectProductInfoByName(String productName) throws Exception;

    /**
     * 根据分类查询商品列表
     *
     * @param categoryId 分类ID
     * @return 商品列表
     */
    List<ProductInfo> selectProductInfoByCategoryId(Integer categoryId) throws Exception;

    /**
     * 根据发布状态查询商品列表
     *
     * @param publishStatus 发布状态
     * @return 商品列表
     */
    List<ProductInfo> selectProductInfoByStatus(Integer publishStatus) throws Exception;

    /**
     * 更新商品发布状态
     *
     * @param id 商品ID
     * @param publishStatus 发布状态
     * @return 结果
     */
    int updateProductStatus(Integer id, Integer publishStatus) throws Exception;

    /**
     * 更新商品库存
     *
     * @param id 商品ID
     * @param stock 库存数量
     * @return 结果
     */
    int updateProductStock(Integer id, Integer stock) throws Exception;
}
