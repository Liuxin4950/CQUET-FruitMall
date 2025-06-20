package org.example.emarketmall.service;

import org.example.emarketmall.entity.ProductCategory;

import java.util.List;
import java.util.Map;

/**
 * @Description: Web端商品分类Service接口
 * @author: system
 * @date: 2024年12月19日
 */
public interface WebCategoryService {
    
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
     * 查询分类树形结构（包含子分类）
     * @return 分类树Map，key为一级分类，value为对应的二级分类列表
     * @throws Exception
     */
    Map<ProductCategory, List<ProductCategory>> selectCategoryTree() throws Exception;
    
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
    
    /**
     * 获取导航菜单数据（一级分类及其子分类）
     * @return 导航菜单数据
     * @throws Exception
     */
    Map<String, Object> getNavigationData() throws Exception;
    
    /**
     * 根据分类ID获取分类路径（面包屑导航）
     * @param categoryId 分类ID
     * @return 分类路径列表，从一级分类到当前分类
     * @throws Exception
     */
    List<ProductCategory> getCategoryPath(Integer categoryId) throws Exception;
}