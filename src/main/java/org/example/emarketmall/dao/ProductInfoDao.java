package org.example.emarketmall.dao;

import org.example.emarketmall.entity.ProductInfo;

import java.util.List;

public interface ProductInfoDao {
    List<ProductInfo> selectProductInfoList(ProductInfo productInfo) throws Exception;

    ProductInfo selectProductInfoById(Integer id) throws Exception;

    /**
     * 根据商品发布状态查询商品列表
     * @param publishStatus 发布状态
     * @return 商品列表
     * @throws Exception
     */
    List<ProductInfo> selectProductInfoByStatus(Integer publishStatus) throws Exception;

    /**
     * 插入商品信息
     * @param productInfo 商品信息
     * @return 影响行数
     * @throws Exception
     */
    int insertProductInfo(ProductInfo productInfo) throws Exception;

    /**
     * 更新商品信息
     * @param productInfo 商品信息
     * @return 影响行数
     * @throws Exception
     */
    int updateProductInfo(ProductInfo productInfo) throws Exception;

    /**
     * 逻辑删除商品信息
     * @param id 商品ID
     * @return 影响行数
     * @throws Exception
     */
    int deleteProductInfoById(Integer id) throws Exception;

    /**
     * 批量逻辑删除商品信息
     * @param ids 商品ID数组
     * @return 影响行数
     * @throws Exception
     */
    int deleteProductInfoByIds(Integer[] ids) throws Exception;

    /**
     * 更新商品发布状态
     * @param id 商品ID
     * @param publishStatus 发布状态
     * @return 影响行数
     * @throws Exception
     */
    int updateProductStatus(Integer id, Integer publishStatus) throws Exception;

    /**
     * 更新商品库存
     * @param id 商品ID
     * @param stock 库存数量
     * @return 影响行数
     * @throws Exception
     */
    int updateProductStock(Integer id, Integer stock) throws Exception;

}
