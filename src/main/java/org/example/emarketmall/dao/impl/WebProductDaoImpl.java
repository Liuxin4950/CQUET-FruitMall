package org.example.emarketmall.dao.impl;

import cquet.aibd.soft.ObjectUtil;
import org.example.emarketmall.dao.WebProductDao;
import org.example.emarketmall.req.ProductQueryReq;
import org.example.emarketmall.resl.ProductDisplayResl;
import org.example.emarketmall.utils.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * @Description: Web端商品展示DAO实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class WebProductDaoImpl implements WebProductDao {
    
    @Override
    public List<ProductDisplayResl> selectProductDisplayList(ProductQueryReq queryReq) throws Exception {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT p.id, p.product_code as productCode, p.product_name as productName, ");
        sql.append("p.price, p.discount_price as discountPrice, p.description, p.image_url as imageUrl, ");
        sql.append("p.stock, p.publish_status as publishStatus, p.origin_place as originPlace, ");
        sql.append("p.is_organic as isOrganic, p.is_seasonal as isSeasonal, p.weight_unit as weightUnit, ");
        sql.append("p.nutrition_info as nutritionInfo, p.storage_method as storageMethod, ");
        sql.append("p.production_date as productionDate, p.shelf_life as shelfLife, ");
        sql.append("p.one_category_id as oneCategoryId, p.two_category_id as twoCategoryId, ");
        sql.append("c1.category_name as oneCategoryName, c2.category_name as twoCategoryName, ");
        sql.append("0 as salesCount, 5.0 as rating, 0 as isRecommended, 0 as recommendWeight ");
        sql.append("FROM product_info p ");
        sql.append("LEFT JOIN product_category c1 ON p.one_category_id = c1.id AND c1.delFlag = 0 ");
        sql.append("LEFT JOIN product_category c2 ON p.two_category_id = c2.id AND c2.delFlag = 0 ");
        sql.append("WHERE p.delFlag = 0 AND p.publish_status = 1 ");
        
        List<Object> params = new ArrayList<>();
        
        // 添加查询条件
        if (StringUtils.isNotEmpty(queryReq.getProductName())) {
            sql.append("AND p.product_name LIKE ? ");
            params.add("%" + queryReq.getProductName() + "%");
        }
        
        if (StringUtils.isNotEmpty(queryReq.getKeyword())) {
            sql.append("AND (p.product_name LIKE ? OR p.description LIKE ?) ");
            params.add("%" + queryReq.getKeyword() + "%");
            params.add("%" + queryReq.getKeyword() + "%");
        }
        
        if (queryReq.getOneCategoryId() != null) {
            sql.append("AND p.one_category_id = ? ");
            params.add(queryReq.getOneCategoryId());
        }
        
        if (queryReq.getTwoCategoryId() != null) {
            sql.append("AND p.two_category_id = ? ");
            params.add(queryReq.getTwoCategoryId());
        }
        
        if (queryReq.getMinPrice() != null) {
            sql.append("AND p.price >= ? ");
            params.add(queryReq.getMinPrice());
        }
        
        if (queryReq.getMaxPrice() != null) {
            sql.append("AND p.price <= ? ");
            params.add(queryReq.getMaxPrice());
        }
        
        if (queryReq.getIsOrganic() != null) {
            sql.append("AND p.is_organic = ? ");
            params.add(queryReq.getIsOrganic());
        }
        
        if (queryReq.getIsSeasonal() != null) {
            sql.append("AND p.is_seasonal = ? ");
            params.add(queryReq.getIsSeasonal());
        }
        
        if (StringUtils.isNotEmpty(queryReq.getOriginPlace())) {
            sql.append("AND p.origin_place LIKE ? ");
            params.add("%" + queryReq.getOriginPlace() + "%");
        }
        
        // 添加排序
        if (StringUtils.isNotEmpty(queryReq.getSortField())) {
            String sortField = queryReq.getSortField();
            String sortOrder = StringUtils.isNotEmpty(queryReq.getSortOrder()) ? queryReq.getSortOrder() : "asc";
            
            switch (sortField) {
                case "price":
                    sql.append("ORDER BY p.price ").append(sortOrder).append(" ");
                    break;
                case "createTime":
                    sql.append("ORDER BY p.createdTime ").append(sortOrder).append(" ");
                    break;
                case "sales":
                    sql.append("ORDER BY salesCount ").append(sortOrder).append(" ");
                    break;
                case "rating":
                    sql.append("ORDER BY rating ").append(sortOrder).append(" ");
                    break;
                default:
                    sql.append("ORDER BY p.createdTime DESC ");
                    break;
            }
        } else {
            sql.append("ORDER BY p.createdTime DESC ");
        }
        
        // 添加分页
        if (queryReq.getPageNum() != null && queryReq.getPageSize() != null) {
            int offset = (queryReq.getPageNum() - 1) * queryReq.getPageSize();
            sql.append("LIMIT ?, ? ");
            params.add(offset);
            params.add(queryReq.getPageSize());
        }
        
        return new ObjectUtil<ProductDisplayResl>().getList(sql.toString(), ProductDisplayResl.class, params.toArray());
    }
    
    @Override
    public int selectProductDisplayCount(ProductQueryReq queryReq) throws Exception {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM product_info p ");
        sql.append("WHERE p.delFlag = 0 AND p.publish_status = 1 ");
        
        List<Object> params = new ArrayList<>();
        
        // 添加查询条件（与selectProductDisplayList相同的条件）
        if (StringUtils.isNotEmpty(queryReq.getProductName())) {
            sql.append("AND p.product_name LIKE ? ");
            params.add("%" + queryReq.getProductName() + "%");
        }
        
        if (StringUtils.isNotEmpty(queryReq.getKeyword())) {
            sql.append("AND (p.product_name LIKE ? OR p.description LIKE ?) ");
            params.add("%" + queryReq.getKeyword() + "%");
            params.add("%" + queryReq.getKeyword() + "%");
        }
        
        if (queryReq.getOneCategoryId() != null) {
            sql.append("AND p.one_category_id = ? ");
            params.add(queryReq.getOneCategoryId());
        }
        
        if (queryReq.getTwoCategoryId() != null) {
            sql.append("AND p.two_category_id = ? ");
            params.add(queryReq.getTwoCategoryId());
        }
        
        if (queryReq.getMinPrice() != null) {
            sql.append("AND p.price >= ? ");
            params.add(queryReq.getMinPrice());
        }
        
        if (queryReq.getMaxPrice() != null) {
            sql.append("AND p.price <= ? ");
            params.add(queryReq.getMaxPrice());
        }
        
        if (queryReq.getIsOrganic() != null) {
            sql.append("AND p.is_organic = ? ");
            params.add(queryReq.getIsOrganic());
        }
        
        if (queryReq.getIsSeasonal() != null) {
            sql.append("AND p.is_seasonal = ? ");
            params.add(queryReq.getIsSeasonal());
        }
        
        if (StringUtils.isNotEmpty(queryReq.getOriginPlace())) {
            sql.append("AND p.origin_place LIKE ? ");
            params.add("%" + queryReq.getOriginPlace() + "%");
        }
        
        Object result = new ObjectUtil<>().getOne(sql.toString(), Object.class, params.toArray());
        return result != null ? Integer.parseInt(result.toString()) : 0;
    }
    
    @Override
    public ProductDisplayResl selectProductDisplayById(Integer productId) throws Exception {
        String sql = "SELECT p.id, p.product_code as productCode, p.product_name as productName, " +
                     "p.price, p.discount_price as discountPrice, p.description, p.image_url as imageUrl, " +
                     "p.stock, p.publish_status as publishStatus, p.origin_place as originPlace, " +
                     "p.is_organic as isOrganic, p.is_seasonal as isSeasonal, p.weight_unit as weightUnit, " +
                     "p.nutrition_info as nutritionInfo, p.storage_method as storageMethod, " +
                     "p.production_date as productionDate, p.shelf_life as shelfLife, " +
                     "p.one_category_id as oneCategoryId, p.two_category_id as twoCategoryId, " +
                     "c1.category_name as oneCategoryName, c2.category_name as twoCategoryName, " +
                     "0 as salesCount, 5.0 as rating, 0 as isRecommended, 0 as recommendWeight " +
                     "FROM product_info p " +
                     "LEFT JOIN product_category c1 ON p.one_category_id = c1.id AND c1.delFlag = 0 " +
                     "LEFT JOIN product_category c2 ON p.two_category_id = c2.id AND c2.delFlag = 0 " +
                     "WHERE p.id = ? AND p.delFlag = 0 AND p.publish_status = 1";
        
        return new ObjectUtil<ProductDisplayResl>().getOne(sql, ProductDisplayResl.class, productId);
    }
    
    @Override
    public List<ProductDisplayResl> selectRecommendedProducts(Integer limit) throws Exception {
        String sql = "SELECT p.id, p.product_code as productCode, p.product_name as productName, " +
                     "p.price, p.discount_price as discountPrice, p.description, p.image_url as imageUrl, " +
                     "p.stock, p.publish_status as publishStatus, p.origin_place as originPlace, " +
                     "p.is_organic as isOrganic, p.is_seasonal as isSeasonal, p.weight_unit as weightUnit, " +
                     "p.nutrition_info as nutritionInfo, p.storage_method as storageMethod, " +
                     "p.production_date as productionDate, p.shelf_life as shelfLife, " +
                     "p.one_category_id as oneCategoryId, p.two_category_id as twoCategoryId, " +
                     "c1.category_name as oneCategoryName, c2.category_name as twoCategoryName, " +
                     "0 as salesCount, 5.0 as rating, 1 as isRecommended, 100 as recommendWeight " +
                     "FROM product_info p " +
                     "LEFT JOIN product_category c1 ON p.one_category_id = c1.id AND c1.delFlag = 0 " +
                     "LEFT JOIN product_category c2 ON p.two_category_id = c2.id AND c2.delFlag = 0 " +
                     "WHERE p.delFlag = 0 AND p.publish_status = 1 " +
                     "ORDER BY p.createdTime DESC LIMIT ?";
        
        return new ObjectUtil<ProductDisplayResl>().getList(sql, ProductDisplayResl.class, limit != null ? limit : 10);
    }
    
    @Override
    public List<ProductDisplayResl> selectHotProducts(Integer limit) throws Exception {
        String sql = "SELECT p.id, p.product_code as productCode, p.product_name as productName, " +
                     "p.price, p.discount_price as discountPrice, p.description, p.image_url as imageUrl, " +
                     "p.stock, p.publish_status as publishStatus, p.origin_place as originPlace, " +
                     "p.is_organic as isOrganic, p.is_seasonal as isSeasonal, p.weight_unit as weightUnit, " +
                     "p.nutrition_info as nutritionInfo, p.storage_method as storageMethod, " +
                     "p.production_date as productionDate, p.shelf_life as shelfLife, " +
                     "p.one_category_id as oneCategoryId, p.two_category_id as twoCategoryId, " +
                     "c1.category_name as oneCategoryName, c2.category_name as twoCategoryName, " +
                     "RAND() * 100 as salesCount, 4.5 + RAND() * 0.5 as rating, 0 as isRecommended, 0 as recommendWeight " +
                     "FROM product_info p " +
                     "LEFT JOIN product_category c1 ON p.one_category_id = c1.id AND c1.delFlag = 0 " +
                     "LEFT JOIN product_category c2 ON p.two_category_id = c2.id AND c2.delFlag = 0 " +
                     "WHERE p.delFlag = 0 AND p.publish_status = 1 " +
                     "ORDER BY salesCount DESC LIMIT ?";
        
        return new ObjectUtil<ProductDisplayResl>().getList(sql, ProductDisplayResl.class, limit != null ? limit : 10);
    }
    
    @Override
    public List<ProductDisplayResl> selectNewProducts(Integer limit) throws Exception {
        String sql = "SELECT p.id, p.product_code as productCode, p.product_name as productName, " +
                     "p.price, p.discount_price as discountPrice, p.description, p.image_url as imageUrl, " +
                     "p.stock, p.publish_status as publishStatus, p.origin_place as originPlace, " +
                     "p.is_organic as isOrganic, p.is_seasonal as isSeasonal, p.weight_unit as weightUnit, " +
                     "p.nutrition_info as nutritionInfo, p.storage_method as storageMethod, " +
                     "p.production_date as productionDate, p.shelf_life as shelfLife, " +
                     "p.one_category_id as oneCategoryId, p.two_category_id as twoCategoryId, " +
                     "c1.category_name as oneCategoryName, c2.category_name as twoCategoryName, " +
                     "0 as salesCount, 5.0 as rating, 0 as isRecommended, 0 as recommendWeight " +
                     "FROM product_info p " +
                     "LEFT JOIN product_category c1 ON p.one_category_id = c1.id AND c1.delFlag = 0 " +
                     "LEFT JOIN product_category c2 ON p.two_category_id = c2.id AND c2.delFlag = 0 " +
                     "WHERE p.delFlag = 0 AND p.publish_status = 1 " +
                     "ORDER BY p.createdTime DESC LIMIT ?";
        
        return new ObjectUtil<ProductDisplayResl>().getList(sql, ProductDisplayResl.class, limit != null ? limit : 10);
    }
    
    @Override
    public List<ProductDisplayResl> selectProductsByCategory(Integer categoryId, Integer limit) throws Exception {
        String sql = "SELECT p.id, p.product_code as productCode, p.product_name as productName, " +
                     "p.price, p.discount_price as discountPrice, p.description, p.image_url as imageUrl, " +
                     "p.stock, p.publish_status as publishStatus, p.origin_place as originPlace, " +
                     "p.is_organic as isOrganic, p.is_seasonal as isSeasonal, p.weight_unit as weightUnit, " +
                     "p.nutrition_info as nutritionInfo, p.storage_method as storageMethod, " +
                     "p.production_date as productionDate, p.shelf_life as shelfLife, " +
                     "p.one_category_id as oneCategoryId, p.two_category_id as twoCategoryId, " +
                     "c1.category_name as oneCategoryName, c2.category_name as twoCategoryName, " +
                     "0 as salesCount, 5.0 as rating, 0 as isRecommended, 0 as recommendWeight " +
                     "FROM product_info p " +
                     "LEFT JOIN product_category c1 ON p.one_category_id = c1.id AND c1.delFlag = 0 " +
                     "LEFT JOIN product_category c2 ON p.two_category_id = c2.id AND c2.delFlag = 0 " +
                     "WHERE p.delFlag = 0 AND p.publish_status = 1 " +
                     "AND (p.one_category_id = ? OR p.two_category_id = ?) " +
                     "ORDER BY p.createdTime DESC LIMIT ?";
        
        return new ObjectUtil<ProductDisplayResl>().getList(sql, ProductDisplayResl.class, categoryId, categoryId, limit != null ? limit : 10);
    }
    
    @Override
    public List<ProductDisplayResl> searchProducts(String keyword, Integer limit) throws Exception {
        String sql = "SELECT p.id, p.product_code as productCode, p.product_name as productName, " +
                     "p.price, p.discount_price as discountPrice, p.description, p.image_url as imageUrl, " +
                     "p.stock, p.publish_status as publishStatus, p.origin_place as originPlace, " +
                     "p.is_organic as isOrganic, p.is_seasonal as isSeasonal, p.weight_unit as weightUnit, " +
                     "p.nutrition_info as nutritionInfo, p.storage_method as storageMethod, " +
                     "p.production_date as productionDate, p.shelf_life as shelfLife, " +
                     "p.one_category_id as oneCategoryId, p.two_category_id as twoCategoryId, " +
                     "c1.category_name as oneCategoryName, c2.category_name as twoCategoryName, " +
                     "0 as salesCount, 5.0 as rating, 0 as isRecommended, 0 as recommendWeight " +
                     "FROM product_info p " +
                     "LEFT JOIN product_category c1 ON p.one_category_id = c1.id AND c1.delFlag = 0 " +
                     "LEFT JOIN product_category c2 ON p.two_category_id = c2.id AND c2.delFlag = 0 " +
                     "WHERE p.delFlag = 0 AND p.publish_status = 1 " +
                     "AND (p.product_name LIKE ? OR p.description LIKE ?) " +
                     "ORDER BY p.createdTime DESC LIMIT ?";
        
        String searchKeyword = "%" + keyword + "%";
        return new ObjectUtil<ProductDisplayResl>().getList(sql, ProductDisplayResl.class, searchKeyword, searchKeyword, limit != null ? limit : 20);
    }
}