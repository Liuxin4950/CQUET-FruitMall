package org.example.emarketmall.service;

import org.example.emarketmall.entity.Orders;
import org.example.emarketmall.resl.OrdersResl;

import java.util.List;

/**
 * @Description: 订单服务接口
 * @author: system
 * @date: 2024年12月19日
 */
public interface OrdersService {

    /**
     * 根据条件分页查询订单列表
     *
     * @param orders 订单信息
     * @return 订单信息集合信息
     */
    List<OrdersResl> selectOrdersList(Orders orders);

    /**
     * 通过订单ID查询订单
     *
     * @param orderId 订单ID
     * @return 订单对象信息
     */
    OrdersResl selectOrdersById(Integer orderId);

    /**
     * 通过订单编号查询订单
     *
     * @param orderNum 订单编号
     * @return 订单对象信息
     */
    OrdersResl selectOrdersByOrderNum(String orderNum);

    /**
     * 通过用户ID查询订单列表
     *
     * @param userId 用户ID
     * @return 订单列表
     */
    List<OrdersResl> selectOrdersByUserId(Integer userId);

    /**
     * 通过订单状态查询订单列表
     *
     * @param orderStatus 订单状态
     * @return 订单列表
     */
    List<OrdersResl> selectOrdersByStatus(String orderStatus);

    /**
     * 新增订单
     *
     * @param orders 订单信息
     * @return 结果
     */
    int insertOrders(Orders orders);

    /**
     * 修改订单
     *
     * @param orders 订单信息
     * @return 结果
     */
    int updateOrders(Orders orders);

    /**
     * 批量删除订单
     *
     * @param orderIds 需要删除的订单ID
     * @return 结果
     */
    int deleteOrdersByIds(Integer[] orderIds);

    /**
     * 删除订单信息
     *
     * @param orderId 订单ID
     * @return 结果
     */
    int deleteOrdersById(Integer orderId);

    /**
     * 更新订单状态
     *
     * @param orderId 订单ID
     * @param orderStatus 订单状态
     * @return 结果
     */
    int updateOrderStatus(Integer orderId, Integer orderStatus);

    /**
     * 统计订单数量
     *
     * @param orders 订单查询条件
     * @return 订单数量
     */
    int countOrders(Orders orders);

    /**
     * 创建订单（包含订单详情）
     *
     * @param orders 订单信息（包含订单详情列表）
     * @return 结果
     */
    boolean createOrder(Orders orders);

    /**
     * 从商品列表创建订单
     *
     * @param orders 订单基本信息
     * @param orderItems 订单商品列表
     * @return 结果
     */
    boolean createOrder(Orders orders, List<org.example.emarketmall.req.OrderItemReq> orderItems);

    /**
     * 从购物车创建订单
     *
     * @param orders 订单基本信息
     * @param cartItems 购物车商品列表
     * @return 结果
     */
    boolean createOrderFromCart(Orders orders, List<org.example.emarketmall.entity.OrderCart> cartItems);

    /**
     * 取消订单
     *
     * @param orderId 订单ID
     * @return 结果
     */
    boolean cancelOrder(Integer orderId);

    /**
     * 确认收货
     *
     * @param orderId 订单ID
     * @return 结果
     */
    boolean confirmReceive(Integer orderId);

    /**
     * 支付订单
     *
     * @param orderId 订单ID
     * @param paymentTransactionId 支付交易号
     * @return 结果
     */
    boolean payOrder(Integer orderId, String paymentTransactionId);

    /**
     * 发货订单
     *
     * @param orderId 订单ID
     * @return 结果
     */
    boolean shipOrder(Integer orderId);

    /**
     * 取消订单（包含用户权限验证）
     *
     * @param orderId 订单ID
     * @param userId 用户ID
     * @return 结果
     */
    boolean cancelOrderWithValidation(Integer orderId, Integer userId);

    /**
     * 确认收货（包含用户权限验证）
     *
     * @param orderId 订单ID
     * @param userId 用户ID
     * @return 结果
     */
    boolean confirmReceiveWithValidation(Integer orderId, Integer userId);

    /**
     * 支付订单（包含用户权限验证）
     *
     * @param orderId 订单ID
     * @param userId 用户ID
     * @param paymentTransactionId 支付交易号
     * @return 结果
     */
    boolean payOrderWithValidation(Integer orderId, Integer userId, String paymentTransactionId);

    /**
     * 创建订单（包含库存验证）
     *
     * @param orders 订单基本信息
     * @param orderItems 订单商品列表
     * @param userId 用户ID
     * @return 结果
     */
    boolean createOrderWithValidation(Orders orders, List<org.example.emarketmall.req.OrderItemReq> orderItems, Integer userId);

    /**
     * 从购物车创建订单（包含库存验证）
     *
     * @param orders 订单基本信息
     * @param cartIds 购物车ID列表
     * @param userId 用户ID
     * @return 结果
     */
    boolean createOrderFromCartWithValidation(Orders orders, List<Integer> cartIds, Integer userId);
}