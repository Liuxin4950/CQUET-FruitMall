package org.example.emarketmall.service.impl;

import org.example.emarketmall.dao.WebCategoryDao;
import org.example.emarketmall.dao.impl.WebCategoryDaoImpl;
import org.example.emarketmall.entity.ProductCategory;
import org.example.emarketmall.service.WebCategoryService;

import java.util.*;

/**
 * @Description: Web端商品分类Service实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class WebCategoryServiceImpl implements WebCategoryService {
    
    private WebCategoryDao webCategoryDao;
    
    public WebCategoryServiceImpl() {
        this.webCategoryDao = new WebCategoryDaoImpl();
    }
    
    @Override
    public List<ProductCategory> selectFirstLevelCategories() throws Exception {
        return webCategoryDao.selectFirstLevelCategories();
    }
    
    @Override
    public List<ProductCategory> selectCategoriesByParentId(Integer parentId) throws Exception {
        if (parentId == null) {
            throw new IllegalArgumentException("父级分类ID不能为空");
        }
        
        return webCategoryDao.selectCategoriesByParentId(parentId);
    }
    
    @Override
    public ProductCategory selectCategoryById(Integer categoryId) throws Exception {
        if (categoryId == null) {
            throw new IllegalArgumentException("分类ID不能为空");
        }
        
        ProductCategory category = webCategoryDao.selectCategoryById(categoryId);
        if (category == null) {
            throw new RuntimeException("分类不存在或已禁用");
        }
        
        return category;
    }
    
    @Override
    public Map<ProductCategory, List<ProductCategory>> selectCategoryTree() throws Exception {
        // 获取所有分类
        List<ProductCategory> allCategories = webCategoryDao.selectCategoryTree();
        
        // 构建分类树
        Map<ProductCategory, List<ProductCategory>> categoryTree = new LinkedHashMap<>();
        Map<Integer, ProductCategory> categoryMap = new HashMap<>();
        
        // 先将所有分类放入Map中，便于查找
        for (ProductCategory category : allCategories) {
            categoryMap.put(category.getId(), category);
        }
        
        // 构建树形结构
        for (ProductCategory category : allCategories) {
            if (category.getCategoryLevel() == 1) {
                // 一级分类
                categoryTree.put(category, new ArrayList<>());
            } else if (category.getCategoryLevel() == 2) {
                // 二级分类，找到对应的一级分类
                ProductCategory parentCategory = categoryMap.get(category.getParentId());
                if (parentCategory != null && categoryTree.containsKey(parentCategory)) {
                    categoryTree.get(parentCategory).add(category);
                }
            }
        }
        
        return categoryTree;
    }
    
    @Override
    public List<ProductCategory> selectCategoriesByName(String categoryName) throws Exception {
        if (categoryName == null || categoryName.trim().isEmpty()) {
            throw new IllegalArgumentException("分类名称不能为空");
        }
        
        return webCategoryDao.selectCategoriesByName(categoryName.trim());
    }
    
    @Override
    public List<ProductCategory> selectHotCategories(Integer limit) throws Exception {
        if (limit == null || limit <= 0) {
            limit = 10;
        }
        
        return webCategoryDao.selectHotCategories(limit);
    }
    
    @Override
    public Map<String, Object> getNavigationData() throws Exception {
        Map<String, Object> navigationData = new HashMap<>();
        
        try {
            // 获取分类树
            Map<ProductCategory, List<ProductCategory>> categoryTree = selectCategoryTree();
            navigationData.put("categoryTree", categoryTree);
            
            // 获取一级分类列表（用于简单导航）
            List<ProductCategory> firstLevelCategories = selectFirstLevelCategories();
            navigationData.put("firstLevelCategories", firstLevelCategories);
            
            // 获取热门分类（6个）
            List<ProductCategory> hotCategories = selectHotCategories(6);
            navigationData.put("hotCategories", hotCategories);
            
        } catch (Exception e) {
            System.err.println("获取导航数据时发生错误: " + e.getMessage());
            e.printStackTrace();
            // 返回空数据而不是抛出异常，避免影响页面显示
            navigationData.put("categoryTree", new LinkedHashMap<>());
            navigationData.put("firstLevelCategories", new ArrayList<>());
            navigationData.put("hotCategories", new ArrayList<>());
        }
        
        return navigationData;
    }
    
    @Override
    public List<ProductCategory> getCategoryPath(Integer categoryId) throws Exception {
        if (categoryId == null) {
            throw new IllegalArgumentException("分类ID不能为空");
        }
        
        List<ProductCategory> path = new ArrayList<>();
        ProductCategory currentCategory = selectCategoryById(categoryId);
        
        if (currentCategory == null) {
            return path;
        }
        
        // 添加当前分类
        path.add(0, currentCategory);
        
        // 如果是二级分类，添加其父级分类
        if (currentCategory.getCategoryLevel() == 2 && currentCategory.getParentId() != null) {
            try {
                ProductCategory parentCategory = selectCategoryById(currentCategory.getParentId());
                if (parentCategory != null) {
                    path.add(0, parentCategory);
                }
            } catch (Exception e) {
                // 如果父级分类不存在，忽略错误
                System.err.println("获取父级分类失败: " + e.getMessage());
            }
        }
        
        return path;
    }
}