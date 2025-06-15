package org.example.emarketmall.dao;

import org.example.emarketmall.entity.Orders;

import java.util.List;

/**
 * @Description: 订单数据访问接口
 * @author: system
 * @date: 2024年12月19日
 */
public interface OrdersDao {

    /**
     * 根据条件分页查询订单列表
     *
     * @param orders 订单信息
     * @return 订单信息集合信息
     */
    List<Orders> selectOrdersList(Orders orders) throws Exception;

    /**
     * 通过订单ID查询订单
     *
     * @param orderId 订单ID
     * @return 订单对象信息
     */
    Orders selectOrdersById(Integer orderId) throws Exception;

    /**
     * 通过订单编号查询订单
     *
     * @param orderNum 订单编号
     * @return 订单对象信息
     */
    Orders selectOrdersByOrderNum(String orderNum);

    /**
     * 通过用户ID查询订单列表
     *
     * @param userId 用户ID
     * @return 订单列表
     */
    List<Orders> selectOrdersByUserId(Integer userId);

    /**
     * 通过订单状态查询订单列表
     *
     * @param orderStatus 订单状态
     * @return 订单列表
     */
    List<Orders> selectOrdersByStatus(Integer orderStatus);

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
     * @param orderId 订单ID
     * @param orders 订单信息
     * @return 结果
     */
    int updateOrders(Integer orderId, Orders orders);

    /**
     * 删除订单
     *
     * @param orderId 订单ID
     * @return 结果
     */
    int deleteOrdersById(Integer orderId);

    /**
     * 批量删除订单
     *
     * @param orderIds 需要删除的订单ID
     * @return 结果
     */
    int deleteOrdersByIds(Integer[] orderIds);

    /**
     * 更新订单状态
     *
     * @param orderId 订单ID
     * @param orderStatus 订单状态
     * @return 结果
     */
    int updateOrderStatus(Integer orderId, Integer orderStatus);

    /**
     * 根据用户ID和订单状态查询订单
     *
     * @param userId 用户ID
     * @param orderStatus 订单状态
     * @return 订单列表
     */
    List<Orders> selectOrdersByUserIdAndStatus(Integer userId, Integer orderStatus);

    /**
     * 统计订单数量
     *
     * @param orders 查询条件
     * @return 订单数量
     */
    int countOrders(Orders orders);
}