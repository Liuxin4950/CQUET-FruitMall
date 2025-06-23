package org.example.emarketmall.service.impl;

import org.example.emarketmall.dao.OrderDetailDao;
import org.example.emarketmall.dao.OrdersDao;
import org.example.emarketmall.dao.impl.OrderDetailDaoImpl;
import org.example.emarketmall.dao.impl.OrdersDaoImpl;
import org.example.emarketmall.entity.OrderDetail;
import org.example.emarketmall.entity.Orders;
import org.example.emarketmall.resl.OrdersResl;
import org.example.emarketmall.service.OrdersService;
import org.example.emarketmall.utils.DateUtils;
import org.example.emarketmall.utils.StringUtils;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.text.SimpleDateFormat;

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
    //以下是管理员的方法
    @Override
    public List<OrdersResl> selectOrdersList(Orders orders) {
        try {
            return ordersDao.selectOrdersList(orders);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public OrdersResl selectOrdersById(Integer orderId) {
        try {
            OrdersResl orders = ordersDao.selectOrdersById(orderId);
            System.out.println("查询订单结果: " + orders);
            if (orders != null) {
                // 查询订单详情
                List<OrderDetail> orderDetails = orderDetailDao.selectOrderDetailByOrderId(orderId);
                System.out.println("查询订单详情结果: " + orderDetails);
                orders.setOrderDetails(orderDetails);
            }
            return orders;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public OrdersResl selectOrdersByOrderNum(String orderNum) {
        try {
            OrdersResl orders = ordersDao.selectOrdersByOrderNum(orderNum);
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
    public List<OrdersResl> selectOrdersByUserId(Integer userId) {
        try {
            List<OrdersResl> ordersResls = ordersDao.selectOrdersByUserId(userId);
            System.out.println("查询用户订单结果: " + ordersResls);
            return ordersResls;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    @Override
    public List<OrdersResl> selectOrdersByStatus(String orderStatus) {
        try {
            // 将String类型的orderStatus转换为Integer类型
            Integer statusCode = Integer.parseInt(orderStatus);
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
        return (int) ordersDao.countOrders(orders);
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
            System.out.println("取消订单结果: " + result);
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
    public boolean payOrder(Integer orderId, String paymentTransactionId,Integer paymentMethod) {
        try {
            Orders orders = new Orders();
            orders.setId(orderId);
            orders.setOrderStatus(2); // 已支付
            orders.setPaymentTransactionId(paymentTransactionId);
            orders.setPayTime(new Date());
            orders.setUpdatedTime(DateUtils.getTime());
            orders.setPaymentMethod(paymentMethod);
            // 如果有支付金额，可以设置
            int result = ordersDao.updateOrders(orderId, orders);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //以上是管理员界面所使用的方法不要动他们

    
    @Override
    public boolean shipOrder(Integer orderId) {
        return updateOrderStatus(orderId, 3) > 0; // 3表示已发货
    }

//    @Override
//    public boolean createOrder(Orders orders) {
//        try {
//            // 生成订单编号
//            orders.setOrderNum(generateOrderNum());
//            orders.setOrderStatus(1); // 待支付
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            String currentTime = sdf.format(new Date());
//            orders.setCreatedTime(currentTime);
//            orders.setUpdatedTime(currentTime);
//            orders.setCreatedBy("system");
//
//            // 插入订单主表
//            int result = ordersDao.insertOrders(orders);
//            if (result > 0 && orders.getOrderDetails() != null && !orders.getOrderDetails().isEmpty()) {
//                // 通过订单编号查询刚插入的订单获取ID
//                OrdersResl insertedOrder = ordersDao.selectOrdersByOrderNum(orders.getOrderNum());
//                if (insertedOrder != null) {
//                    orders.setId(insertedOrder.getId());
//                }
//
//                // 设置订单详情的订单ID
//                for (OrderDetail detail : orders.getOrderDetails()) {
//                    detail.setOrderId(orders.getId());
//                    detail.setCreatedTime(currentTime);
//                    detail.setUpdatedTime(currentTime);
//                    detail.setCreatedBy("system");
//                }
//
//                // 批量插入订单详情
//                int detailResult = orderDetailDao.insertOrderDetailBatch(orders.getOrderDetails());
//                if (detailResult <= 0) {
//                    throw new RuntimeException("订单详情插入失败");
//                }
//            }
//
//            return result > 0;
//        } catch (Exception e) {
//            e.printStackTrace();
//            throw new RuntimeException(e.getMessage());
//        }
//    }



    /**
     * 生成订单编号
     */
    private String generateOrderNum() {
        return "ORD" + System.currentTimeMillis() + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
    /**
     * 将订单状态字符串转换为状态码
     * @param orderStatus 订单状态字符串
     * @return 状态码
     */
}