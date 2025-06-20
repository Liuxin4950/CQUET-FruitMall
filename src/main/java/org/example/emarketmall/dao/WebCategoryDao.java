package org.example.emarketmall.dao;

import org.example.emarketmall.entity.ProductCategory;

import java.util.List;

/**
 * @Description: Web端商品分类DAO接口
 * @author: system
 * @date: 2024年12月19日
 */
public interface WebCategoryDao {
    
    /**
     * 查询所有一级分类
     * @return 一级分类列表
     * @throws Exception
     */
    List<ProductCategory> selectFirstLevelCategories() throws Exception;
    
    /**
     * 根据父级分类ID查询子分类
     * @param parentId 父级分类ID
     * @return 子分类列表
     * @throws Exception
     */
    List<ProductCategory> selectCategoriesByParentId(Integer parentId) throws Exception;
    
    /**
     * 根据分类ID查询分类信息
     * @param categoryId 分类ID
     * @return 分类信息
     * @throws Exception
     */
    ProductCategory selectCategoryById(Integer categoryId) throws Exception;
    
    /**
     * 查询所有启用状态的分类（树形结构）
     * @return 分类树列表
     * @throws Exception
     */
    List<ProductCategory> selectCategoryTree() throws Exception;
    
    /**
     * 根据分类名称模糊查询分类
     * @param categoryName 分类名称
     * @return 分类列表
     * @throws Exception
     */
    List<ProductCategory> selectCategoriesByName(String categoryName) throws Exception;
    
    /**
     * 查询热门分类（根据商品数量排序）
     * @param limit 限制数量
     * @return 热门分类列表
     * @throws Exception
     */
    List<ProductCategory> selectHotCategories(Integer limit) throws Exception;
}