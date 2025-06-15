package org.example.emarketmall.service.impl;

import org.example.emarketmall.dao.OrderDetailDao;
import org.example.emarketmall.dao.OrdersDao;
import org.example.emarketmall.dao.impl.OrderDetailDaoImpl;
import org.example.emarketmall.dao.impl.OrdersDaoImpl;
import org.example.emarketmall.entity.OrderDetail;
import org.example.emarketmall.entity.Orders;
import org.example.emarketmall.service.OrdersService;
import org.example.emarketmall.utils.DateUtils;
import org.example.emarketmall.utils.StringUtils;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @Description: 订单服务实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class OrdersServiceImpl implements OrdersService {
    private OrdersDao ordersDao;
    private OrderDetailDao orderDetailDao;

    public OrdersServiceImpl() {
        ordersDao = new OrdersDaoImpl();
        orderDetailDao = new OrderDetailDaoImpl();
    }

    @Override
    public List<Orders> selectOrdersList(Orders orders) {
        try {
            return ordersDao.selectOrdersList(orders);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Orders selectOrdersById(Integer orderId) {
        try {
            Orders orders = ordersDao.selectOrdersById(orderId);
            if (orders != null) {
                // 查询订单详情
                List<OrderDetail> orderDetails = orderDetailDao.selectOrderDetailByOrderId(orderId);
                orders.setOrderDetails(orderDetails);
            }
            return orders;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Orders selectOrdersByOrderNum(String orderNum) {
        try {
            Orders orders = ordersDao.selectOrdersByOrderNum(orderNum);
            if (orders != null) {
                // 查询订单详情
                List<OrderDetail> orderDetails = orderDetailDao.selectOrderDetailByOrderId(orders.getId());
                orders.setOrderDetails(orderDetails);
            }
            return orders;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Orders> selectOrdersByUserId(Integer userId) {
        try {
            return ordersDao.selectOrdersByUserId(userId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Orders> selectOrdersByStatus(String orderStatus) {
        try {
            // 将String类型的orderStatus转换为Integer类型
            Integer statusCode = convertOrderStatusToCode(orderStatus);
            return ordersDao.selectOrdersByStatus(statusCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int insertOrders(Orders orders) {
        if (StringUtils.isEmpty(orders.getCreatedBy())) {
            orders.setCreatedBy("admin");
        }
        if (orders.getCreatedTime() == null) {
            orders.setCreatedTime(DateUtils.getTime());
        }
        if (orders.getUpdatedTime() == null) {
            orders.setUpdatedTime(DateUtils.getTime());
        }
        return ordersDao.insertOrders(orders);
    }

    @Override
    public int updateOrders(Orders orders) {
        Integer id = orders.getId();
        orders.setUpdatedTime(DateUtils.getTime());
        return ordersDao.updateOrders(id, orders);
    }

    @Override
    public int deleteOrdersByIds(Integer[] orderIds) {
        return ordersDao.deleteOrdersByIds(orderIds);
    }

    @Override
    public int deleteOrdersById(Integer orderId) {
        return ordersDao.deleteOrdersById(orderId);
    }

    @Override
    public int updateOrderStatus(Integer orderId, Integer orderStatus) {
        return ordersDao.updateOrderStatus(orderId, orderStatus);
    }

    @Override
    public int countOrders(Orders orders) {
        return ordersDao.countOrders(orders);
    }

    @Override
    public boolean createOrder(Orders orders) {
        try {
            // 设置订单基本信息
            if (StringUtils.isEmpty(orders.getOrderNum())) {
                orders.setOrderNum(generateOrderNum());
            }
            if (orders.getOrderStatus() == null) {
                orders.setOrderStatus(1); // 待支付
            }
            if (StringUtils.isEmpty(orders.getCreatedBy())) {
                orders.setCreatedBy("system");
            }
            orders.setCreatedTime(DateUtils.getTime());
            orders.setUpdatedTime(DateUtils.getTime());
            
            // 插入订单
            int result = ordersDao.insertOrders(orders);
            if (result > 0 && orders.getOrderDetails() != null && !orders.getOrderDetails().isEmpty()) {
                // 插入订单详情
                for (OrderDetail orderDetail : orders.getOrderDetails()) {
                    orderDetail.setOrderId(orders.getId());
                    orderDetail.setCreatedBy(orders.getCreatedBy());
                    orderDetail.setCreatedTime(DateUtils.getTime());
                    orderDetail.setUpdatedTime(DateUtils.getTime());
                    orderDetailDao.insertOrderDetail(orderDetail);
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean cancelOrder(Integer orderId) {
        try {
            Orders orders = new Orders();
            orders.setId(orderId);
            orders.setOrderStatus(5); // 已取消
            orders.setUpdatedTime(DateUtils.getTime());
            
            int result = ordersDao.updateOrders(orderId, orders);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean confirmReceive(Integer orderId) {
        try {
            Orders orders = new Orders();
            orders.setId(orderId);
            orders.setOrderStatus(4); // 已完成
            orders.setReceiveTime(new Date());
            orders.setUpdatedTime(DateUtils.getTime());
            
            int result = ordersDao.updateOrders(orderId, orders);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean payOrder(Integer orderId, String paymentTransactionId) {
        try {
            Orders orders = new Orders();
            orders.setId(orderId);
            orders.setOrderStatus(2); // 已支付
            orders.setPaymentTransactionId(paymentTransactionId);
            orders.setPayTime(new Date());
            orders.setUpdatedTime(DateUtils.getTime());
            
            int result = ordersDao.updateOrders(orderId, orders);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 生成订单编号
     * @return 订单编号
     */
    private String generateOrderNum() {
        // 使用UUID生成唯一订单号
        String uuid = UUID.randomUUID().toString().replace("-", "");
        // 截取前16位作为订单号
        return uuid.substring(0, 16).toUpperCase();
    }

    /**
     * 将订单状态字符串转换为状态码
     * @param orderStatus 订单状态字符串
     * @return 状态码
     */
    private Integer convertOrderStatusToCode(String orderStatus) {
        if (StringUtils.isEmpty(orderStatus)) {
            return 0; // 默认状态
        }
        switch (orderStatus) {
            case "待支付":
                return 1;
            case "已支付":
                return 2;
            case "已发货":
                return 3;
            case "已完成":
                return 4;
            case "已取消":
                return 5;
            default:
                return 0;
        }
    }
}