package org.example.emarketmall.service.impl;

import org.example.emarketmall.dao.OrderCartDao;
import org.example.emarketmall.dao.impl.OrderCartDaoImpl;
import org.example.emarketmall.entity.OrderCart;
import org.example.emarketmall.entity.ProductInfo;
import org.example.emarketmall.service.OrderCartService;
import org.example.emarketmall.service.ProductInfoService;
import org.example.emarketmall.service.impl.ProductInfoServiceImpl;
import org.example.emarketmall.utils.DateUtils;
import org.example.emarketmall.utils.StringUtils;

import java.util.List;

/**
 * @Description: 购物车服务实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class OrderCartServiceImpl implements OrderCartService {
    private OrderCartDao orderCartDao;
    private ProductInfoService productInfoService;

    public OrderCartServiceImpl() {
        orderCartDao = new OrderCartDaoImpl();
        productInfoService = new ProductInfoServiceImpl();
    }

    @Override
    public List<OrderCart> selectOrderCartList(OrderCart orderCart) {
        try {
            return orderCartDao.selectOrderCartList(orderCart);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public OrderCart selectOrderCartById(Integer cartId) {
        try {
            return orderCartDao.selectOrderCartById(cartId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<OrderCart> selectOrderCartByUserId(Integer userId) {
        try {
            List<OrderCart> cartList = orderCartDao.selectOrderCartByUserId(userId);
//            System.out.println("查询到的购物车列表: " + cartList);
            // 为每个购物车项关联商品详细信息
            if (cartList != null && !cartList.isEmpty()) {
                for (OrderCart cart : cartList) {
                    try {
                        ProductInfo productInfo = productInfoService.selectProductInfoById(Integer.parseInt(cart.getProductId()));
                        cart.setProductInfo(productInfo);
                    } catch (Exception e) {
                        System.err.println("关联商品信息失败，商品ID: " + cart.getProductId() + ", 错误: " + e.getMessage());
                        // 即使关联失败，也不影响其他数据的返回
                    }
                }
            }
            return cartList;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public OrderCart selectOrderCartByUserIdAndProductId(Integer userId, String productId) {
        try {
            return orderCartDao.selectOrderCartByUserIdAndProductId(userId, productId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<OrderCart> selectSelectedOrderCartByUserId(Integer userId) {
        try {
            return orderCartDao.selectSelectedOrderCartByUserId(userId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int insertOrderCart(OrderCart orderCart) {
        if (StringUtils.isEmpty(orderCart.getCreatedBy())) {
            orderCart.setCreatedBy("admin");
        }
        if (orderCart.getCreatedTime() == null) {
            orderCart.setCreatedTime(DateUtils.getTime());
        }
        if (orderCart.getUpdatedTime() == null) {
            orderCart.setUpdatedTime(DateUtils.getTime());
        }
        return orderCartDao.insertOrderCart(orderCart);
    }

    @Override
    public int updateOrderCart(OrderCart orderCart) {
        Integer id = orderCart.getId();
        orderCart.setUpdatedTime(DateUtils.getTime());
        return orderCartDao.updateOrderCart(id, orderCart);
    }

    @Override
    public int updateOrderCartAmount(Integer cartId, Integer amount) {
        return orderCartDao.updateOrderCartAmount(cartId, amount);
    }

    @Override
    public int updateOrderCartSelected(Integer cartId, Boolean isSelected) {
        return orderCartDao.updateOrderCartSelected(cartId, isSelected);
    }

    @Override
    public int updateOrderCartSelectedBatch(Integer userId, Boolean isSelected) {
        return orderCartDao.updateOrderCartSelectedByUserId(userId, isSelected);
    }

    @Override
    public int deleteOrderCartById(Integer cartId) {
        return orderCartDao.deleteOrderCartById(cartId);
    }

    @Override
    public int deleteOrderCartByUserId(Integer userId) {
        return orderCartDao.deleteOrderCartByUserId(userId);
    }

    @Override
    public int deleteSelectedOrderCartByUserId(Integer userId) {
        return orderCartDao.deleteSelectedOrderCartByUserId(userId);
    }

    @Override
    public int deleteOrderCartByIds(Integer[] cartIds) {
        return orderCartDao.deleteOrderCartByIds(cartIds);
    }

    @Override
    public int countOrderCartByUserId(Integer userId) {
        return orderCartDao.countOrderCartByUserId(userId);
    }

    @Override
    public boolean addToCart(Integer userId, String productId, Integer amount, java.math.BigDecimal price, String productName, String productPic) {
        try {
            // 检查购物车中是否已存在该商品
            OrderCart existingCart = orderCartDao.selectOrderCartByUserIdAndProductId(userId, productId);
            
            if (existingCart != null) {
                // 如果已存在，更新数量
                int newAmount = existingCart.getAmount() + amount;
                int result = orderCartDao.updateOrderCartAmount(existingCart.getId(), newAmount);
                return result > 0;
            } else {
                // 如果不存在，新增购物车记录
                OrderCart orderCart = new OrderCart();
                orderCart.setUserId(userId);
                orderCart.setProductId(productId);
                orderCart.setAmount(amount);
                orderCart.setPrice(price);
                orderCart.setProductName(productName);
                orderCart.setProductPic(productPic);
                orderCart.setIsSelected(true); // 默认选中
                orderCart.setCreatedBy("system");
                orderCart.setCreatedTime(DateUtils.getTime());
                orderCart.setUpdatedTime(DateUtils.getTime());
                
                int result = orderCartDao.insertOrderCart(orderCart);
                return result > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean removeFromCart(Integer userId, String productId) {
        try {
            OrderCart existingCart = orderCartDao.selectOrderCartByUserIdAndProductId(userId, productId);
            if (existingCart != null) {
                int result = orderCartDao.deleteOrderCartById(existingCart.getId());
                return result > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean clearCart(Integer userId) {
        try {
            int result = orderCartDao.deleteOrderCartByUserId(userId);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean addToCart(Integer userId, String productId, Integer amount) {
        try {
            // 通过商品ID查询商品信息
            ProductInfo productInfo = productInfoService.selectProductInfoById(Integer.parseInt(productId));
            if (productInfo == null) {
                System.err.println("商品不存在: " + productId);
                return false;
            }
            
            // 调用完整版本的addToCart方法
            return addToCart(userId, productId, amount, productInfo.getPrice(), productInfo.getProductName(), productInfo.getImageUrl());
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}