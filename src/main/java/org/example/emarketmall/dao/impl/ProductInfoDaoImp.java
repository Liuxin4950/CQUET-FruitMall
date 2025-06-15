package org.example.emarketmall.dao.impl;

import cqcet.aibd.soft.ObjectUtil;
import org.example.emarketmall.dao.IDataAccess;
import org.example.emarketmall.dao.ProductInfoDao;
import org.example.emarketmall.entity.ProductInfo;
import org.example.emarketmall.utils.StringUtils;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @Description: TODO
 * @author: april
 * @date: 2022年06月11日 22:03
 */
public class ProductInfoDaoImp implements ProductInfoDao {


    @Override
    public List<ProductInfo> selectProductInfoList(ProductInfo productInfo) throws Exception {
        if(productInfo!=null){
            return selectProductInfoByProductParams(productInfo);
        }
        // 直接在这里实现带字段映射的查询，不再依赖DataAccessImpl
        String sql = "SELECT id, product_code as productCode, product_name as productName, " +
                     "one_category_id as oneCategoryId, two_category_id as twoCategoryId, " +
                     "price, publish_status as publishStatus, production_date as productionDate, " +
                     "shelf_life as shelfLife, description, origin_place as originPlace, " +
                     "storage_method as storageMethod, nutrition_info as nutritionInfo, " +
                     "weight_unit as weightUnit, is_organic as isOrganic, is_seasonal as isSeasonal, " +
                     "discount_price as discountPrice, stock, image_url as imageUrl, createdBy, createdTime, " +
                     "updatedBy, updatedTime, remark, delFlag " +
                     "FROM product_info WHERE delFlag = 0";
        return new ObjectUtil<ProductInfo>().getList(sql, ProductInfo.class);
    }

    private List<ProductInfo> selectProductInfoByProductParams(ProductInfo param) throws Exception {
        List<ProductInfo> list = new ArrayList<>();
        //是否输入了多个查询条件
        List<String> params = Arrays.asList("id", "productName", "publishStatus");

        for (String p : params) {
            switch (p) {
                case "id":
                    if (param.getId() != null) {
                        list.add(selectProductInfoById(param.getId()));
                    }
                    break;
                case "productName":
                    if (param.getProductName() != null) {
                        List<ProductInfo> nameResults = selectProductInfoByName(param.getProductName());
                        if (nameResults != null) {
                            list.addAll(nameResults);
                        }
                    }
                    break;
                case "publishStatus":
                    if (param.getPublishStatus() != null) {
                        List<ProductInfo> statusResults = selectProductInfoByStatus(param.getPublishStatus());
                        if (statusResults != null) {
                            list.addAll(statusResults);
                        }
                    }

                default:
                    break;
            }
        }
        return list;
    }

    @Override
    public ProductInfo selectProductInfoById(Integer id) throws Exception {
        // 直接在这里实现带字段映射的查询，不再依赖DataAccessImpl
        String sql = "SELECT id, product_code as productCode, product_name as productName, " +
                     "one_category_id as oneCategoryId, two_category_id as twoCategoryId, " +
                     "price, publish_status as publishStatus, production_date as productionDate, " +
                     "shelf_life as shelfLife, description, origin_place as originPlace, " +
                     "storage_method as storageMethod, nutrition_info as nutritionInfo, " +
                     "weight_unit as weightUnit, is_organic as isOrganic, is_seasonal as isSeasonal, " +
                     "discount_price as discountPrice, stock, image_url as imageUrl, createdBy, createdTime, " +
                     "updatedBy, updatedTime, remark, delFlag " +
                     "FROM product_info WHERE id = ? AND delFlag = 0";
        return new ObjectUtil<ProductInfo>().getOne(sql, ProductInfo.class, id);
    }

    /**
     * 根据商品名称查询商品列表
     */
    private List<ProductInfo> selectProductInfoByName(String productName) throws Exception {
        String sql = "SELECT id, product_code as productCode, product_name as productName, " +
                     "one_category_id as oneCategoryId, two_category_id as twoCategoryId, " +
                     "price, publish_status as publishStatus, production_date as productionDate, " +
                     "shelf_life as shelfLife, description, origin_place as originPlace, " +
                     "storage_method as storageMethod, nutrition_info as nutritionInfo, " +
                     "weight_unit as weightUnit, is_organic as isOrganic, is_seasonal as isSeasonal, " +
                     "discount_price as discountPrice, stock, image_url as imageUrl, createdBy, createdTime, " +
                     "updatedBy, updatedTime, remark, delFlag " +
                     "FROM product_info WHERE product_name LIKE ? AND delFlag = 0";
        return new ObjectUtil<ProductInfo>().getList(sql, ProductInfo.class, "%" + productName + "%");
    }

    /**
     * 根据发布状态查询商品列表
     */
    public List<ProductInfo> selectProductInfoByStatus(Integer publishStatus) throws Exception {
        String sql = "SELECT id, product_code as productCode, product_name as productName, " +
                     "one_category_id as oneCategoryId, two_category_id as twoCategoryId, " +
                     "price, publish_status as publishStatus, production_date as productionDate, " +
                     "shelf_life as shelfLife, description, origin_place as originPlace, " +
                     "storage_method as storageMethod, nutrition_info as nutritionInfo, " +
                     "weight_unit as weightUnit, is_organic as isOrganic, is_seasonal as isSeasonal, " +
                     "discount_price as discountPrice, stock, image_url as imageUrl, createdBy, createdTime, " +
                     "updatedBy, updatedTime, remark, delFlag " +
                     "FROM product_info WHERE publish_status = ? AND delFlag = 0";
        return new ObjectUtil<ProductInfo>().getList(sql, ProductInfo.class, publishStatus);
    }

    /**
     * 插入商品信息
     * @param productInfo 商品信息
     * @return 影响行数
     * @throws Exception
     */
    @Override
    public int insertProductInfo(ProductInfo productInfo) throws Exception {
        String sql = "INSERT INTO product_info (product_code, product_name, one_category_id, two_category_id, " +
                "price, publish_status, production_date, shelf_life, description, origin_place, " +
                "storage_method, nutrition_info, weight_unit, is_organic, is_seasonal, " +
                "discount_price, stock, image_url, createdBy, createdTime, updatedBy, updatedTime, delFlag) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; 
        
        if (productInfo == null) {
            return 0;
        }
        
        return new ObjectUtil<ProductInfo>().add(sql, 
            productInfo.getProductCode(),
            productInfo.getProductName(),
            productInfo.getOneCategoryId(),
            productInfo.getTwoCategoryId(),
            productInfo.getPrice(),
            productInfo.getPublishStatus(),
            productInfo.getProductionDate(),
            productInfo.getShelfLife(),
            productInfo.getDescription(),
            productInfo.getOriginPlace(),
            productInfo.getStorageMethod(),
            productInfo.getNutritionInfo(),
            productInfo.getWeightUnit(),
            productInfo.getIsOrganic(),
            productInfo.getIsSeasonal(),
            productInfo.getDiscountPrice(),
            productInfo.getStock(),
            productInfo.getImageUrl(),
            productInfo.getCreatedBy(),
            productInfo.getCreatedTime(),
            productInfo.getUpdatedBy(),
            productInfo.getUpdatedTime(),
            productInfo.getDelFlag());
    }

    /**
     * 更新商品信息
     * @param productInfo 商品信息
     * @return 影响行数
     * @throws Exception
     */
    @Override
    public int updateProductInfo(ProductInfo productInfo) throws Exception {
        if (productInfo == null || productInfo.getId() == null) {
            return 0;
        }
        
        String sql = "UPDATE product_info SET product_name=?, one_category_id=?, two_category_id=?, " +
                "price=?, publish_status=?, production_date=?, shelf_life=?, description=?, " +
                "origin_place=?, storage_method=?, nutrition_info=?, weight_unit=?, " +
                "is_organic=?, is_seasonal=?, discount_price=?, stock=?, image_url=?, " +
                "updatedBy=?, updatedTime=? WHERE id=? AND delFlag=0";
        
        return new ObjectUtil<ProductInfo>().update(sql,
            productInfo.getProductName(),
            productInfo.getOneCategoryId(),
            productInfo.getTwoCategoryId(),
            productInfo.getPrice(),
            productInfo.getPublishStatus(),
            productInfo.getProductionDate(),
            productInfo.getShelfLife(),
            productInfo.getDescription(),
            productInfo.getOriginPlace(),
            productInfo.getStorageMethod(),
            productInfo.getNutritionInfo(),
            productInfo.getWeightUnit(),
            productInfo.getIsOrganic(),
            productInfo.getIsSeasonal(),
            productInfo.getDiscountPrice(),
            productInfo.getStock(),
            productInfo.getImageUrl(),
            productInfo.getUpdatedBy(),
            productInfo.getUpdatedTime(),
            productInfo.getId());
    }

    /**
     * 逻辑删除商品信息
     * @param id 商品ID
     * @return 影响行数
     * @throws Exception
     */
    @Override
    public int deleteProductInfoById(Integer id) throws Exception {
        if (id == null) {
            return 0;
        }
        
        String sql = "UPDATE product_info SET delFlag=1, updatedTime=? WHERE id=? AND delFlag=0";
        return new ObjectUtil<ProductInfo>().update(sql, new java.util.Date(), id);
    }

    /**
     * 批量逻辑删除商品信息
     * @param ids 商品ID数组
     * @return 影响行数
     * @throws Exception
     */
    @Override
    public int deleteProductInfoByIds(Integer[] ids) throws Exception {
        if (ids == null || ids.length == 0) {
            return 0;
        }
        
        int totalUpdated = 0;
        // 逐个删除，使用ObjectUtil的update方法
        for (Integer id : ids) {
            if (id != null) {
                String sql = "UPDATE product_info SET delFlag=1, updatedTime=? WHERE id=? AND delFlag=0";
                totalUpdated += new ObjectUtil<ProductInfo>().update(sql, new java.util.Date(), id);
            }
        }
        
        return totalUpdated;
    }

    /**
     * 更新商品发布状态
     * @param id 商品ID
     * @param publishStatus 发布状态
     * @return 影响行数
     * @throws Exception
     */
    @Override
    public int updateProductStatus(Integer id, Integer publishStatus) throws Exception {
        if (id == null || publishStatus == null) {
            return 0;
        }
        
        String sql = "UPDATE product_info SET publish_status=?, updatedTime=? WHERE id=? AND delFlag=0";
        return new ObjectUtil<ProductInfo>().update(sql, publishStatus, new java.util.Date(), id);
    }

    /**
     * 更新商品库存
     * @param id 商品ID
     * @param stock 库存数量
     * @return 影响行数
     * @throws Exception
     */
    @Override
    public int updateProductStock(Integer id, Integer stock) throws Exception {
        if (id == null || stock == null) {
            return 0;
        }
        
        String sql = "UPDATE product_info SET stock=?, updatedTime=? WHERE id=? AND delFlag=0";
        return new ObjectUtil<ProductInfo>().update(sql, stock, new java.util.Date(), id);
    }
}
