package org.example.emarketmall.service;

import org.example.emarketmall.entity.OrderDetail;

import java.util.List;

/**
 * @Description: 订单详情服务接口
 * @author: system
 * @date: 2024年12月19日
 */
public interface OrderDetailService {

    /**
     * 根据条件查询订单详情列表
     *
     * @param orderDetail 订单详情信息
     * @return 订单详情集合信息
     */
    List<OrderDetail> selectOrderDetailList(OrderDetail orderDetail);

    /**
     * 通过订单详情ID查询订单详情
     *
     * @param orderDetailId 订单详情ID
     * @return 订单详情对象信息
     */
    OrderDetail selectOrderDetailById(Integer orderDetailId);

    /**
     * 通过订单ID查询订单详情列表
     *
     * @param orderId 订单ID
     * @return 订单详情列表
     */
    List<OrderDetail> selectOrderDetailByOrderId(Integer orderId);

    /**
     * 通过商品ID查询订单详情列表
     *
     * @param productId 商品ID
     * @return 订单详情列表
     */
    List<OrderDetail> selectOrderDetailByProductId(Integer productId);

    /**
     * 新增订单详情
     *
     * @param orderDetail 订单详情信息
     * @return 结果
     */
    int insertOrderDetail(OrderDetail orderDetail);

    /**
     * 批量新增订单详情
     *
     * @param orderDetailList 订单详情列表
     * @return 结果
     */
    int insertOrderDetailBatch(List<OrderDetail> orderDetailList);

    /**
     * 修改订单详情
     *
     * @param orderDetail 订单详情信息
     * @return 结果
     */
    int updateOrderDetail(OrderDetail orderDetail);

    /**
     * 批量删除订单详情
     *
     * @param orderDetailIds 需要删除的订单详情ID
     * @return 结果
     */
    int deleteOrderDetailByIds(Integer[] orderDetailIds);

    /**
     * 删除订单详情信息
     *
     * @param orderDetailId 订单详情ID
     * @return 结果
     */
    int deleteOrderDetailById(Integer orderDetailId);

    /**
     * 根据订单ID删除订单详情
     *
     * @param orderId 订单ID
     * @return 结果
     */
    int deleteOrderDetailByOrderId(Integer orderId);
}