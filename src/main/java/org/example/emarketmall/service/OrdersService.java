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
}