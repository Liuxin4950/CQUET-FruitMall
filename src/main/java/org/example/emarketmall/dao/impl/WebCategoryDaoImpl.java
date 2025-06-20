package org.example.emarketmall.dao.impl;

import org.example.emarketmall.dao.WebCategoryDao;
import org.example.emarketmall.entity.ProductCategory;
import cquet.aibd.soft.ObjectUtil;
import org.example.emarketmall.utils.StringUtils;

import java.util.List;

/**
 * @Description: Web端商品分类DAO实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class WebCategoryDaoImpl implements WebCategoryDao {
    
    @Override
    public List<ProductCategory> selectFirstLevelCategories() throws Exception {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, category_name, category_code, parent_id, category_level, ");
        sql.append("category_status, category_icon, display_order, remark, ");
        sql.append("delFlag, createdBy, createdTime, updatedBy, updatedTime ");
        sql.append("FROM product_category ");
        sql.append("WHERE delFlag = 0 AND category_status = 1 AND category_level = 1 ");
        sql.append("ORDER BY display_order ASC, id ASC");
        
        return new ObjectUtil<ProductCategory>().getList(sql.toString(), ProductCategory.class);
    }
    
    @Override
    public List<ProductCategory> selectCategoriesByParentId(Integer parentId) throws Exception {
        if (parentId == null) {
            throw new IllegalArgumentException("父级分类ID不能为空");
        }
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, category_name, category_code, parent_id, category_level, ");
        sql.append("category_status, category_icon, display_order, remark, ");
        sql.append("delFlag, createdBy, createdTime, updatedBy, updatedTime ");
        sql.append("FROM product_category ");
        sql.append("WHERE delFlag = 0 AND category_status = 1 AND parent_id = ? ");
        sql.append("ORDER BY display_order ASC, id ASC");
        
        return new ObjectUtil<ProductCategory>().getList(sql.toString(), ProductCategory.class, parentId);
    }
    
    @Override
    public ProductCategory selectCategoryById(Integer categoryId) throws Exception {
        if (categoryId == null) {
            throw new IllegalArgumentException("分类ID不能为空");
        }
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, category_name, category_code, parent_id, category_level, ");
        sql.append("category_status, category_icon, display_order, remark, ");
        sql.append("delFlag, createdBy, createdTime, updatedBy, updatedTime ");
        sql.append("FROM product_category ");
        sql.append("WHERE delFlag = 0 AND id = ?");
        
        List<ProductCategory> list = new ObjectUtil<ProductCategory>().getList(sql.toString(), ProductCategory.class, categoryId);
        return list.isEmpty() ? null : list.get(0);
    }
    
    @Override
    public List<ProductCategory> selectCategoryTree() throws Exception {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, category_name, category_code, parent_id, category_level, ");
        sql.append("category_status, category_icon, display_order, remark, ");
        sql.append("delFlag, createdBy, createdTime, updatedBy, updatedTime ");
        sql.append("FROM product_category ");
        sql.append("WHERE delFlag = 0 AND category_status = 1 ");
        sql.append("ORDER BY category_level ASC, display_order ASC, id ASC");
        
        return new ObjectUtil<ProductCategory>().getList(sql.toString(), ProductCategory.class);
    }
    
    @Override
    public List<ProductCategory> selectCategoriesByName(String categoryName) throws Exception {
        if (StringUtils.isEmpty(categoryName)) {
            throw new IllegalArgumentException("分类名称不能为空");
        }
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, category_name, category_code, parent_id, category_level, ");
        sql.append("category_status, category_icon, display_order, remark, ");
        sql.append("delFlag, createdBy, createdTime, updatedBy, updatedTime ");
        sql.append("FROM product_category ");
        sql.append("WHERE delFlag = 0 AND category_status = 1 ");
        sql.append("AND category_name LIKE ? ");
        sql.append("ORDER BY display_order ASC, id ASC");
        
        String searchName = "%" + categoryName + "%";
        return new ObjectUtil<ProductCategory>().getList(sql.toString(), ProductCategory.class, searchName);
    }
    
    @Override
    public List<ProductCategory> selectHotCategories(Integer limit) throws Exception {
        if (limit == null || limit <= 0) {
            limit = 10;
        }
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT pc.id, pc.category_name, pc.category_code, pc.parent_id, ");
        sql.append("pc.category_level, pc.category_status, pc.category_icon, ");
        sql.append("pc.display_order, pc.remark, pc.delFlag, pc.createdBy, ");
        sql.append("pc.createdTime, pc.updatedBy, pc.updatedTime, ");
        sql.append("COUNT(pi.id) as product_count ");
        sql.append("FROM product_category pc ");
        sql.append("LEFT JOIN product_info pi ON (pc.id = pi.oneCategoryId OR pc.id = pi.twoCategoryId) ");
        sql.append("AND pi.delFlag = 0 AND pi.publishStatus = 1 ");
        sql.append("WHERE pc.delFlag = 0 AND pc.category_status = 1 ");
        sql.append("GROUP BY pc.id, pc.category_name, pc.category_code, pc.parent_id, ");
        sql.append("pc.category_level, pc.category_status, pc.category_icon, ");
        sql.append("pc.display_order, pc.remark, pc.delFlag, pc.createdBy, ");
        sql.append("pc.createdTime, pc.updatedBy, pc.updatedTime ");
        sql.append("ORDER BY product_count DESC, pc.display_order ASC ");
        sql.append("LIMIT ?");
        
        return new ObjectUtil<ProductCategory>().getList(sql.toString(), ProductCategory.class, limit);
    }
}