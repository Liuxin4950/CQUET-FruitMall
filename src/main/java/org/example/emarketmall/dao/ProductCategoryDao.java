package org.example.emarketmall.dao;

import org.example.emarketmall.entity.ProductCategory;

import java.util.List;

public interface ProductCategoryDao {
    
    /**
     * 根据条件查询商品分类列表
     *
     * @param productCategory 商品分类信息
     * @return 商品分类集合信息
     */
    List<ProductCategory> selectProductCategoryList(ProductCategory productCategory) throws Exception;

    /**
     * 通过分类ID查询商品分类
     *
     * @param id 分类ID
     * @return 商品分类对象信息
     */
    ProductCategory selectProductCategoryById(Integer id) throws Exception;

    /**
     * 根据父级分类ID查询子分类列表
     *
     * @param parentId 父级分类ID
     * @return 子分类列表
     */
    List<ProductCategory> selectProductCategoryByParentId(Integer parentId) throws Exception;

    /**
     * 根据分类级别查询分类列表
     *
     * @param categoryLevel 分类级别
     * @return 分类列表
     */
    List<ProductCategory> selectProductCategoryByLevel(Integer categoryLevel) throws Exception;

    /**
     * 新增商品分类
     *
     * @param productCategory 商品分类信息
     * @return 结果
     */
    int insertProductCategory(ProductCategory productCategory) throws Exception;

    /**
     * 修改商品分类
     *
     * @param productCategory 商品分类信息
     * @return 结果
     */
    int updateProductCategory(ProductCategory productCategory) throws Exception;

    /**
     * 删除商品分类
     *
     * @param id 分类ID
     * @return 结果
     */
    int deleteProductCategoryById(Integer id) throws Exception;

    /**
     * 批量删除商品分类
     *
     * @param ids 需要删除的分类ID
     * @return 结果
     */
    int deleteProductCategoryByIds(Integer[] ids) throws Exception;
}