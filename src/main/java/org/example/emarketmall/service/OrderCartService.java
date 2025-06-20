package org.example.emarketmall.service;

import org.example.emarketmall.entity.OrderCart;

import java.util.List;

/**
 * @Description: 购物车服务接口
 * @author: system
 * @date: 2024年12月19日
 */
public interface OrderCartService {

    /**
     * 根据条件查询购物车列表
     *
     * @param orderCart 购物车信息
     * @return 购物车集合信息
     */
    List<OrderCart> selectOrderCartList(OrderCart orderCart);

    /**
     * 通过购物车ID查询购物车
     *
     * @param cartId 购物车ID
     * @return 购物车对象信息
     */
    OrderCart selectOrderCartById(Integer cartId);

    /**
     * 通过用户ID查询购物车列表
     *
     * @param userId 用户ID
     * @return 购物车列表
     */
    List<OrderCart> selectOrderCartByUserId(Integer userId);

    /**
     * 通过用户ID和商品ID查询购物车
     *
     * @param userId 用户ID
     * @param productId 商品ID
     * @return 购物车对象信息
     */
    OrderCart selectOrderCartByUserIdAndProductId(Integer userId, String productId);

    /**
     * 通过用户ID查询选中的购物车商品
     *
     * @param userId 用户ID
     * @return 购物车列表
     */
    List<OrderCart> selectSelectedOrderCartByUserId(Integer userId);

    /**
     * 新增购物车
     *
     * @param orderCart 购物车信息
     * @return 结果
     */
    int insertOrderCart(OrderCart orderCart);

    /**
     * 修改购物车
     *
     * @param orderCart 购物车信息
     * @return 结果
     */
    int updateOrderCart(OrderCart orderCart);

    /**
     * 更新购物车商品数量
     *
     * @param cartId 购物车ID
     * @param amount 商品数量
     * @return 结果
     */
    int updateOrderCartAmount(Integer cartId, Integer amount);

    /**
     * 更新购物车选中状态
     *
     * @param cartId 购物车ID
     * @param isSelected 是否选中
     * @return 结果
     */
    int updateOrderCartSelected(Integer cartId, Boolean isSelected);

    /**
     * 批量更新购物车选中状态
     *
     * @param userId 用户ID
     * @param isSelected 是否选中
     * @return 结果
     */
    int updateOrderCartSelectedBatch(Integer userId, Boolean isSelected);

    /**
     * 删除购物车信息
     *
     * @param cartId 购物车ID
     * @return 结果
     */
    int deleteOrderCartById(Integer cartId);

    /**
     * 根据用户ID删除购物车
     *
     * @param userId 用户ID
     * @return 结果
     */
    int deleteOrderCartByUserId(Integer userId);

    /**
     * 删除用户选中的购物车商品
     *
     * @param userId 用户ID
     * @return 结果
     */
    int deleteSelectedOrderCartByUserId(Integer userId);

    /**
     * 批量删除购物车
     *
     * @param cartIds 需要删除的购物车ID
     * @return 结果
     */
    int deleteOrderCartByIds(Integer[] cartIds);

    /**
     * 统计用户购物车商品数量
     *
     * @param userId 用户ID
     * @return 商品数量
     */
    int countOrderCartByUserId(Integer userId);

    /**
     * 添加商品到购物车
     *
     * @param userId 用户ID
     * @param productId 商品ID
     * @param amount 商品数量
     * @param price 商品价格
     * @param productName 商品名称
     * @param productPic 商品图片
     * @return 结果
     */
    boolean addToCart(Integer userId, String productId, Integer amount, java.math.BigDecimal price, String productName, String productPic);

    /**
     * 添加商品到购物车（简化版本，自动获取商品信息）
     *
     * @param userId 用户ID
     * @param productId 商品ID
     * @param amount 商品数量
     * @return 结果
     */
    boolean addToCart(Integer userId, String productId, Integer amount);

    /**
     * 从购物车移除商品
     *
     * @param userId 用户ID
     * @param productId 商品ID
     * @return 结果
     */
    boolean removeFromCart(Integer userId, String productId);

    /**
     * 清空用户购物车
     *
     * @param userId 用户ID
     * @return 结果
     */
    boolean clearCart(Integer userId);
}