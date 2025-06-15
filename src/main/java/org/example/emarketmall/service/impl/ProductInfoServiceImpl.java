package org.example.emarketmall.service.impl;

import org.example.emarketmall.dao.ProductInfoDao;
import org.example.emarketmall.dao.impl.ProductInfoDaoImp;
import org.example.emarketmall.entity.ProductInfo;
import org.example.emarketmall.service.ProductInfoService;

import org.example.emarketmall.utils.DateUtils;
import org.example.emarketmall.utils.StringUtils;

import java.util.Date;
import java.util.List;
/*
*
* 替换DateUtils.getTime()
*
* */
public class ProductInfoServiceImpl implements ProductInfoService {

    private ProductInfoDao productInfoDao;

    public ProductInfoServiceImpl() {
        this.productInfoDao = new ProductInfoDaoImp();
    }

    @Override
    public List<ProductInfo> selectProductInfoList(ProductInfo productInfo) throws Exception {
        return productInfoDao.selectProductInfoList(productInfo);
    }

    @Override
    public ProductInfo selectProductInfoById(Integer id) throws Exception {
        return productInfoDao.selectProductInfoById(id);
    }

    @Override
    public int insertProductInfo(ProductInfo productInfo) throws Exception {
        // 设置创建时间和更新时间
        productInfo.setCreatedTime(DateUtils.getTime());
        productInfo.setUpdatedTime(DateUtils.getTime());
        // 生成商品编码
        if (StringUtils.isEmpty(productInfo.getProductCode())) {
            productInfo.setProductCode(generateProductCode());
        }
        if (productInfo.getPublishStatus() == null) {
            productInfo.setPublishStatus(0); // 默认未发布
        }
        
        return productInfoDao.insertProductInfo(productInfo);
    }

    @Override
    public int updateProductInfo(ProductInfo productInfo) throws Exception {
        // 设置更新时间
        productInfo.setUpdatedTime(DateUtils.getTime());
        
        return productInfoDao.updateProductInfo(productInfo);
    }

    @Override
    public int deleteProductInfoById(Integer id) throws Exception {
        return productInfoDao.deleteProductInfoById(id);
    }

    @Override
    public int deleteProductInfoByIds(Integer[] ids) throws Exception {
        return productInfoDao.deleteProductInfoByIds(ids);
    }

    @Override
    public List<ProductInfo> selectProductInfoByName(String productName) throws Exception {
        ProductInfo productInfo = new ProductInfo();
        productInfo.setProductName(productName);
        return productInfoDao.selectProductInfoList(productInfo);
    }

    @Override
    public List<ProductInfo> selectProductInfoByCategoryId(Integer categoryId) throws Exception {
        ProductInfo productInfo = new ProductInfo();
        productInfo.setOneCategoryId(categoryId);
        return productInfoDao.selectProductInfoList(productInfo);
    }

    @Override
    public List<ProductInfo> selectProductInfoByStatus(Integer publishStatus) throws Exception {
        ProductInfo productInfo = new ProductInfo();
        productInfo.setPublishStatus(publishStatus);
        return productInfoDao.selectProductInfoList(productInfo);
    }

    @Override
    public int updateProductStatus(Integer id, Integer publishStatus) throws Exception {
        ProductInfo productInfo = new ProductInfo();
        productInfo.setId(id);
        productInfo.setPublishStatus(publishStatus);
        productInfo.setUpdatedTime(DateUtils.getTime());
        
        return productInfoDao.updateProductStatus(id, publishStatus);
    }

    @Override
    public int updateProductStock(Integer id, Integer stock) throws Exception {
        ProductInfo productInfo = new ProductInfo();
        productInfo.setId(id);
        productInfo.setStock(stock);
        productInfo.setUpdatedTime(DateUtils.getTime());
        
        return productInfoDao.updateProductStock(id, stock);
    }

    /**
     * 生成商品编码
     * @return 商品编码
     */
    private String generateProductCode() {
        // 生成格式：P + 时间戳后8位 + 随机数
        long timestamp = System.currentTimeMillis();
        String timestampStr = String.valueOf(timestamp);
        String suffix = timestampStr.substring(timestampStr.length() - 8);
        int random = (int) (Math.random() * 1000);
        return "P" + suffix + String.format("%03d", random);
    }
}
