package org.example.emarketmall.dao;

import org.example.emarketmall.entity.ProductPic;

import java.util.List;

public interface ProductPicDao {
    
    /**
     * 根据条件查询商品图片列表
     *
     * @param productPic 商品图片信息
     * @return 商品图片集合信息
     */
    List<ProductPic> selectProductPicList(ProductPic productPic) throws Exception;

    /**
     * 通过图片ID查询商品图片
     *
     * @param id 图片ID
     * @return 商品图片对象信息
     */
    ProductPic selectProductPicById(Integer id) throws Exception;

    /**
     * 根据商品ID查询商品图片列表
     *
     * @param productId 商品ID
     * @return 商品图片列表
     */
    List<ProductPic> selectProductPicByProductId(Integer productId) throws Exception;

    /**
     * 新增商品图片
     *
     * @param productPic 商品图片信息
     * @return 结果
     */
    int insertProductPic(ProductPic productPic) throws Exception;

    /**
     * 修改商品图片
     *
     * @param productPic 商品图片信息
     * @return 结果
     */
    int updateProductPic(ProductPic productPic) throws Exception;

    /**
     * 删除商品图片
     *
     * @param id 图片ID
     * @return 结果
     */
    int deleteProductPicById(Integer id) throws Exception;

    /**
     * 批量删除商品图片
     *
     * @param ids 需要删除的图片ID
     * @return 结果
     */
    int deleteProductPicByIds(Integer[] ids) throws Exception;

    /**
     * 根据商品ID删除商品图片
     *
     * @param productId 商品ID
     * @return 结果
     */
    int deleteProductPicByProductId(Integer productId) throws Exception;
}