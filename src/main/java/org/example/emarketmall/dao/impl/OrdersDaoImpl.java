package org.example.emarketmall.dao.impl;

import cquet.aibd.soft.ObjectUtil;
import org.example.emarketmall.dao.OrdersDao;
import org.example.emarketmall.entity.Orders;
import org.example.emarketmall.resl.OrdersResl;

import org.example.emarketmall.utils.StringUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @Description: 订单数据访问实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class OrdersDaoImpl implements OrdersDao {

    public OrdersDaoImpl() {
    }

    @Override
    public List<OrdersResl> selectOrdersList(Orders orders) throws Exception {
        // 如果orders对象不为空，说明有查询条件
        if (orders != null) {
            return selectOrdersByOrderParams(orders);
        }
        // 多表联查SQL，包含用户信息
        String sql = "SELECT o.id, o.order_num as orderNum, o.user_id as userId, o.shipping_user as shippingUser, " +
                "o.address, o.payment_method as paymentMethod, o.order_money as orderMoney, " +
                "o.shipping_money as shippingMoney, o.district_money as districtMoney, " +
                "o.payment_money as paymentMoney, o.pay_time as payTime, o.receive_time as receiveTime, " +
                "o.ship_time as shipTime, o.order_status as orderStatus, o.payment_transaction_id as paymentTransactionId, " +
                "o.expected_delivery_time as expectedDeliveryTime, o.createdBy, o.createdTime, " +
                "o.updatedBy, o.updatedTime, o.delFlag, o.remark, " +
                "u.name as userName, u.loginName as userLoginName, u.avatar as userAvatar, " +
                "u.email as userEmail, u.phone as userPhone " +
                "FROM orders o LEFT JOIN user_info u ON o.user_id = u.id " +
                "WHERE (o.delFlag = 0 OR o.delFlag IS NULL) " +
                "ORDER BY o.createdTime DESC";
        return new ObjectUtil<OrdersResl>().getList(sql, OrdersResl.class);
    }

    /**
     * 通过orders对象中包含的属性查询订单
     *
     * @param orders
     * @return
     */
    private List<OrdersResl> selectOrdersByOrderParams(Orders orders) throws Exception {
        List<OrdersResl> ordersList = new ArrayList<>();
        // 可查询的属性
        List<String> params = Arrays.asList("id", "orderNum", "userId", "orderStatus", "paymentMethod");

        for (String p : params) {
            switch (p) {
                case "id":
                    if (orders.getId() != null) {
                        OrdersResl order = selectOrdersById(orders.getId());
                        if (order != null) {
                            ordersList.add(order);
                        }
                    }
                    break;
                case "orderNum":
                    if (StringUtils.isNotEmpty(orders.getOrderNum())) {
                        OrdersResl order = selectOrdersByOrderNum(orders.getOrderNum());
                        if (order != null) {
                            ordersList.add(order);
                        }
                    }
                    break;
                case "userId":
                    if (orders.getUserId() != null) {
                        List<OrdersResl> userOrders = selectOrdersByUserId(orders.getUserId());
                        if (userOrders != null && !userOrders.isEmpty()) {
                            ordersList.addAll(userOrders);
                        }
                    }
                    break;
                case "orderStatus":
                    if (orders.getOrderStatus() != null) {
                        List<OrdersResl> statusOrders = selectOrdersByStatus(orders.getOrderStatus());
                        if (statusOrders != null && !statusOrders.isEmpty()) {
                            ordersList.addAll(statusOrders);
                        }
                    }
                    break;
                case "paymentMethod":
                    if (orders.getPaymentMethod() != null) {
                        List<OrdersResl> paymentOrders = selectOrdersByPaymentMethod(orders.getPaymentMethod());
                        if (paymentOrders != null && !paymentOrders.isEmpty()) {
                            ordersList.addAll(paymentOrders);
                        }
                    }
                    break;
            }
        }
        return ordersList;
    }

    @Override
    public OrdersResl selectOrdersById(Integer orderId) throws Exception {
        String sql = "SELECT o.id, o.order_num as orderNum, o.user_id as userId, o.shipping_user as shippingUser, " +
                "o.address, o.payment_method as paymentMethod, o.order_money as orderMoney, " +
                "o.shipping_money as shippingMoney, o.district_money as districtMoney, " +
                "o.payment_money as paymentMoney, o.pay_time as payTime, o.receive_time as receiveTime, " +
                "o.ship_time as shipTime, o.order_status as orderStatus, o.payment_transaction_id as paymentTransactionId, " +
                "o.expected_delivery_time as expectedDeliveryTime, o.createdBy, o.createdTime, " +
                "o.updatedBy, o.updatedTime, o.delFlag, o.remark, " +
                "u.name as userName, u.loginName as userLoginName, u.avatar as userAvatar, " +
                "u.email as userEmail, u.phone as userPhone " +
                "FROM orders o LEFT JOIN user_info u ON o.user_id = u.id " +
                "WHERE o.id = ? AND (o.delFlag = 0 OR o.delFlag IS NULL)";
        return new ObjectUtil<OrdersResl>().getOne(sql, OrdersResl.class, orderId);
    }

    @Override
    public OrdersResl selectOrdersByOrderNum(String orderNum) {
        String sql = "SELECT o.id, o.order_num as orderNum, o.user_id as userId, o.shipping_user as shippingUser, " +
                "o.address, o.payment_method as paymentMethod, o.order_money as orderMoney, " +
                "o.shipping_money as shippingMoney, o.district_money as districtMoney, " +
                "o.payment_money as paymentMoney, o.pay_time as payTime, o.receive_time as receiveTime, " +
                "o.ship_time as shipTime, o.order_status as orderStatus, o.payment_transaction_id as paymentTransactionId, " +
                "o.expected_delivery_time as expectedDeliveryTime, o.createdBy, o.createdTime, " +
                "o.updatedBy, o.updatedTime, o.delFlag, o.remark, " +
                "u.name as userName, u.loginName as userLoginName, u.avatar as userAvatar, " +
                "u.email as userEmail, u.phone as userPhone " +
                "FROM orders o LEFT JOIN user_info u ON o.user_id = u.id " +
                "WHERE o.order_num = ? AND o.delFlag = 0";
        return new ObjectUtil<OrdersResl>().getOne(sql, OrdersResl.class, orderNum);
    }

    @Override
    public List<OrdersResl> selectOrdersByUserId(Integer userId) {
        String sql = "SELECT o.id, o.order_num as orderNum, o.user_id as userId, o.shipping_user as shippingUser, " +
                "o.address, o.payment_method as paymentMethod, o.order_money as orderMoney, " +
                "o.shipping_money as shippingMoney, o.district_money as districtMoney, " +
                "o.payment_money as paymentMoney, o.pay_time as payTime, o.receive_time as receiveTime, " +
                "o.ship_time as shipTime, o.order_status as orderStatus, o.payment_transaction_id as paymentTransactionId, " +
                "o.expected_delivery_time as expectedDeliveryTime, o.createdBy, o.createdTime, " +
                "o.updatedBy, o.updatedTime, o.delFlag, o.remark, " +
                "u.name as userName, u.loginName as userLoginName, u.avatar as userAvatar, " +
                "u.email as userEmail, u.phone as userPhone " +
                "FROM orders o LEFT JOIN user_info u ON o.user_id = u.id " +
                "WHERE o.user_id = ? AND o.delFlag = 0 ORDER BY o.createdTime DESC";
        return new ObjectUtil<OrdersResl>().getList(sql, OrdersResl.class, userId);
    }

    @Override
    public List<OrdersResl> selectOrdersByStatus(Integer orderStatus) {
        String sql = "SELECT o.id, o.order_num as orderNum, o.user_id as userId, o.shipping_user as shippingUser, " +
                "o.address, o.payment_method as paymentMethod, o.order_money as orderMoney, " +
                "o.shipping_money as shippingMoney, o.district_money as districtMoney, " +
                "o.payment_money as paymentMoney, o.pay_time as payTime, o.receive_time as receiveTime, " +
                "o.ship_time as shipTime, o.order_status as orderStatus, o.payment_transaction_id as paymentTransactionId, " +
                "o.expected_delivery_time as expectedDeliveryTime, o.createdBy, o.createdTime, " +
                "o.updatedBy, o.updatedTime, o.delFlag, o.remark, " +
                "u.name as userName, u.loginName as userLoginName, u.avatar as userAvatar, " +
                "u.email as userEmail, u.phone as userPhone " +
                "FROM orders o LEFT JOIN user_info u ON o.user_id = u.id " +
                "WHERE o.order_status = ? AND o.delFlag = 0 ORDER BY o.createdTime DESC";
        return new ObjectUtil<OrdersResl>().getList(sql, OrdersResl.class, orderStatus);
    }

    /**
     * 根据支付方式查询订单
     *
     * @param paymentMethod 支付方式
     * @return 订单列表
     */
    private List<OrdersResl> selectOrdersByPaymentMethod(Integer paymentMethod) {
        String sql = "SELECT o.id, o.order_num as orderNum, o.user_id as userId, o.shipping_user as shippingUser, " +
                "o.address, o.payment_method as paymentMethod, o.order_money as orderMoney, " +
                "o.shipping_money as shippingMoney, o.district_money as districtMoney, " +
                "o.payment_money as paymentMoney, o.pay_time as payTime, o.receive_time as receiveTime, " +
                "o.ship_time as shipTime, o.order_status as orderStatus, o.payment_transaction_id as paymentTransactionId, " +
                "o.expected_delivery_time as expectedDeliveryTime, o.createdBy, o.createdTime, " +
                "o.updatedBy, o.updatedTime, o.delFlag, o.remark, " +
                "u.name as userName, u.loginName as userLoginName, u.avatar as userAvatar, " +
                "u.email as userEmail, u.phone as userPhone " +
                "FROM orders o LEFT JOIN user_info u ON o.user_id = u.id " +
                "WHERE o.payment_method = ? AND o.delFlag = 0 ORDER BY o.createdTime DESC";
        return new ObjectUtil<OrdersResl>().getList(sql, OrdersResl.class, paymentMethod);
    }

    @Override
    public int insertOrders(Orders orders) {
        String sql = "insert into orders(order_num, user_id, shipping_user, address, payment_method, " +
                "order_money, shipping_money, district_money, payment_money, pay_time, receive_time, " +
                "ship_time, order_status, payment_transaction_id, expected_delivery_time, createdBy, createdTime, " +
                "updatedBy, updatedTime, delFlag, remark) " +
                "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        if (orders == null) {
            return 0;
        }
        
        return new ObjectUtil<Orders>().add(sql, 
                orders.getOrderNum(), orders.getUserId(), orders.getShippingUser(), orders.getAddress(),
                orders.getPaymentMethod(), orders.getOrderMoney(), orders.getShippingMoney(), 
                orders.getDistrictMoney(), orders.getPaymentMoney(), orders.getPayTime(), 
                orders.getReceiveTime(), orders.getShipTime(), orders.getOrderStatus(), orders.getPaymentTransactionId(),
                orders.getExpectedDeliveryTime(), orders.getCreatedBy(), orders.getCreatedTime(),
                orders.getUpdatedBy(), orders.getUpdatedTime(), orders.getDelFlag(), orders.getRemark());
    }

    @Override
    public int updateOrders(Integer orderId, Orders orders) {
        if (orders == null) {
            return 0;
        }
        
        // 动态构建SQL语句，只更新非null字段
        StringBuilder sql = new StringBuilder("update orders set ");
        List<Object> params = new ArrayList<>();
        
        if (orders.getOrderNum() != null) {
            sql.append("order_num=?, ");
            params.add(orders.getOrderNum());
        }
        if (orders.getUserId() != null) {
            sql.append("user_id=?, ");
            params.add(orders.getUserId());
        }
        if (orders.getShippingUser() != null) {
            sql.append("shipping_user=?, ");
            params.add(orders.getShippingUser());
        }
        if (orders.getAddress() != null) {
            sql.append("address=?, ");
            params.add(orders.getAddress());
        }
        if (orders.getPaymentMethod() != null) {
            sql.append("payment_method=?, ");
            params.add(orders.getPaymentMethod());
        }
        if (orders.getOrderMoney() != null) {
            sql.append("order_money=?, ");
            params.add(orders.getOrderMoney());
        }
        if (orders.getShippingMoney() != null) {
            sql.append("shipping_money=?, ");
            params.add(orders.getShippingMoney());
        }
        if (orders.getDistrictMoney() != null) {
            sql.append("district_money=?, ");
            params.add(orders.getDistrictMoney());
        }
        if (orders.getPaymentMoney() != null) {
            sql.append("payment_money=?, ");
            params.add(orders.getPaymentMoney());
        }
        if (orders.getPayTime() != null) {
            sql.append("pay_time=?, ");
            params.add(orders.getPayTime());
        }
        if (orders.getReceiveTime() != null) {
            sql.append("receive_time=?, ");
            params.add(orders.getReceiveTime());
        }
        if (orders.getShipTime() != null) {
            sql.append("ship_time=?, ");
            params.add(orders.getShipTime());
        }
        if (orders.getOrderStatus() != null) {
            sql.append("order_status=?, ");
            params.add(orders.getOrderStatus());
        }
        if (orders.getPaymentTransactionId() != null) {
            sql.append("payment_transaction_id=?, ");
            params.add(orders.getPaymentTransactionId());
        }
        if (orders.getExpectedDeliveryTime() != null) {
            sql.append("expected_delivery_time=?, ");
            params.add(orders.getExpectedDeliveryTime());
        }
        if (orders.getCreatedBy() != null) {
            sql.append("createdBy=?, ");
            params.add(orders.getCreatedBy());
        }
        if (orders.getCreatedTime() != null) {
            sql.append("createdTime=?, ");
            params.add(orders.getCreatedTime());
        }
        if (orders.getUpdatedBy() != null) {
            sql.append("updatedBy=?, ");
            params.add(orders.getUpdatedBy());
        }
        if (orders.getUpdatedTime() != null) {
            sql.append("updatedTime=?, ");
            params.add(orders.getUpdatedTime());
        }
        if (orders.getDelFlag() != null) {
            sql.append("delFlag=?, ");
            params.add(orders.getDelFlag());
        }
        if (orders.getRemark() != null) {
            sql.append("remark=?, ");
            params.add(orders.getRemark());
        }
        
        // 移除最后的逗号和空格
        if (sql.toString().endsWith(", ")) {
            sql.setLength(sql.length() - 2);
        }
        
        sql.append(" where id=?");
        params.add(orderId);
        
        return new ObjectUtil<Orders>().update(sql.toString(), params.toArray());
    }

    @Override
    public int deleteOrdersById(Integer orderId) {
        String sql = "update orders set delFlag = 1 where id = ?";
        return new ObjectUtil<Orders>().update(sql, orderId);
    }

    @Override
    public int deleteOrdersByIds(Integer[] orderIds) {
        if (orderIds == null || orderIds.length == 0) {
            return 0;
        }
        
        StringBuilder sql = new StringBuilder("update orders set delFlag = 1 where id in (");
        for (int i = 0; i < orderIds.length; i++) {
            if (i > 0) {
                sql.append(",");
            }
            sql.append("?");
        }
        sql.append(")");
        
        return new ObjectUtil<Orders>().update(sql.toString(), (Object[]) orderIds);
    }

    @Override
    public int updateOrderStatus(Integer orderId, Integer orderStatus) {
        String sql = "update orders set order_status = ?, updatedTime = now() where id = ?";
        return new ObjectUtil<Orders>().update(sql, orderStatus, orderId);
    }

    @Override
    public List<OrdersResl> selectOrdersByUserIdAndStatus(Integer userId, Integer orderStatus) {
        String sql = "SELECT o.id, o.order_num as orderNum, o.user_id as userId, o.shipping_user as shippingUser, " +
                "o.address, o.payment_method as paymentMethod, o.order_money as orderMoney, " +
                "o.shipping_money as shippingMoney, o.district_money as districtMoney, " +
                "o.payment_money as paymentMoney, o.pay_time as payTime, o.receive_time as receiveTime, " +
                "o.ship_time as shipTime, o.order_status as orderStatus, o.payment_transaction_id as paymentTransactionId, " +
                "o.expected_delivery_time as expectedDeliveryTime, o.createdBy, o.createdTime, " +
                "o.updatedBy, o.updatedTime, o.delFlag, o.remark, " +
                "u.name as userName, u.loginName as userLoginName, u.avatar as userAvatar, " +
                "u.email as userEmail, u.phone as userPhone " +
                "FROM orders o LEFT JOIN user_info u ON o.user_id = u.id " +
                "WHERE o.user_id = ? AND o.order_status = ? AND o.delFlag = 0 ORDER BY o.createdTime DESC";
        return new ObjectUtil<OrdersResl>().getList(sql, OrdersResl.class, userId, orderStatus);
    }

    @Override
    public int countOrders(Orders orders) {
        String sql = "select count(*) from orders where delFlag = 0";
        List<String> conditions = new ArrayList<>();
        List<Object> params = new ArrayList<>();
        
        if (orders != null) {
            if (orders.getUserId() != null) {
                conditions.add("user_id = ?");
                params.add(orders.getUserId());
            }
            if (orders.getOrderStatus() != null) {
                conditions.add("order_status = ?");
                params.add(orders.getOrderStatus());
            }
            if (StringUtils.isNotEmpty(orders.getOrderNum())) {
                conditions.add("order_num like ?");
                params.add("%" + orders.getOrderNum() + "%");
            }
        }
        
        if (!conditions.isEmpty()) {
            sql += " and " + String.join(" and ", conditions);
        }
        
        List<Integer> result = new ObjectUtil<Integer>().getList(sql, Integer.class, params.toArray());
        return result.isEmpty() ? 0 : result.get(0);
    }
}