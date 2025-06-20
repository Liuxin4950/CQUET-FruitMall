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
            return ordersDao.selectOrdersByUserId(userId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<OrdersResl> selectOrdersByStatus(String orderStatus) {
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
    public boolean createOrder(Orders orders, List<org.example.emarketmall.req.OrderItemReq> orderItems) {
        try {
            // 设置订单基本信息
            orders.setOrderNum(generateOrderNum());
            orders.setOrderStatus(1); // 待支付
            orders.setCreatedTime(DateUtils.getTime());
            orders.setUpdatedTime(DateUtils.getTime());
            orders.setCreatedBy("system");
            
            // 计算商品总金额
            java.math.BigDecimal totalAmount = java.math.BigDecimal.ZERO;
            for (org.example.emarketmall.req.OrderItemReq item : orderItems) {
                java.math.BigDecimal itemTotal = item.getProductPrice().multiply(new java.math.BigDecimal(item.getAmount()));
                totalAmount = totalAmount.add(itemTotal);
            }
            
            // 计算订单最终金额（商品总额 + 运费 - 优惠金额）
            java.math.BigDecimal shippingMoney = orders.getShippingMoney() != null ? orders.getShippingMoney() : java.math.BigDecimal.ZERO;
            java.math.BigDecimal districtMoney = orders.getDistrictMoney() != null ? orders.getDistrictMoney() : java.math.BigDecimal.ZERO;
            java.math.BigDecimal orderMoney = totalAmount.add(shippingMoney).subtract(districtMoney);
            
            orders.setOrderMoney(orderMoney);
            orders.setPaymentMoney(orderMoney);
            
            // 创建订单详情列表
            java.util.List<OrderDetail> orderDetails = new java.util.ArrayList<>();
            for (org.example.emarketmall.req.OrderItemReq item : orderItems) {
                OrderDetail detail = new OrderDetail();
                detail.setProductId(item.getProductId());
                detail.setProductName(item.getProductName());
                detail.setAmount(item.getAmount());
                detail.setProductPrice(item.getProductPrice());
                detail.setCreatedTime(DateUtils.getTime());
                detail.setUpdatedTime(DateUtils.getTime());
                detail.setCreatedBy("system");
                orderDetails.add(detail);
            }
            orders.setOrderDetails(orderDetails);
            
            // 调用原有的创建订单方法
            return createOrder(orders);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean createOrderFromCart(Orders orders, List<org.example.emarketmall.entity.OrderCart> cartItems) {
        try {
            // 设置订单基本信息
            orders.setOrderNum(generateOrderNum());
            orders.setOrderStatus(1); // 待支付
            orders.setCreatedTime(DateUtils.getTime());
            orders.setUpdatedTime(DateUtils.getTime());
            orders.setCreatedBy("system");
            
            // 计算商品总金额
            java.math.BigDecimal totalAmount = java.math.BigDecimal.ZERO;
            for (org.example.emarketmall.entity.OrderCart cart : cartItems) {
                java.math.BigDecimal itemTotal = cart.getPrice().multiply(new java.math.BigDecimal(cart.getAmount()));
                totalAmount = totalAmount.add(itemTotal);
            }
            
            // 计算订单最终金额（商品总额 + 运费 - 优惠金额）
            java.math.BigDecimal shippingMoney = orders.getShippingMoney() != null ? orders.getShippingMoney() : java.math.BigDecimal.ZERO;
            java.math.BigDecimal districtMoney = orders.getDistrictMoney() != null ? orders.getDistrictMoney() : java.math.BigDecimal.ZERO;
            java.math.BigDecimal orderMoney = totalAmount.add(shippingMoney).subtract(districtMoney);
            
            orders.setOrderMoney(orderMoney);
            orders.setPaymentMoney(orderMoney);
            
            // 创建订单详情列表
            java.util.List<OrderDetail> orderDetails = new java.util.ArrayList<>();
            for (org.example.emarketmall.entity.OrderCart cart : cartItems) {
                OrderDetail detail = new OrderDetail();
                detail.setProductId(Integer.parseInt(cart.getProductId()));
                detail.setProductName(cart.getProductName());
                detail.setAmount(cart.getAmount());
                detail.setProductPrice(cart.getPrice());
                detail.setCreatedTime(DateUtils.getTime());
                detail.setUpdatedTime(DateUtils.getTime());
                detail.setCreatedBy("system");
                orderDetails.add(detail);
            }
            orders.setOrderDetails(orderDetails);
            
            // 调用原有的创建订单方法
            return createOrder(orders);
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
            
            return ordersDao.updateOrders(orderId, orders) > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean shipOrder(Integer orderId) {
        try {
            // 先查询订单状态
            OrdersResl existingOrder = ordersDao.selectOrdersById(orderId);
            if (existingOrder == null) {
                return false;
            }
            
            // 只有已支付的订单才能发货
            if (existingOrder.getOrderStatus() != 2) {
                return false;
            }
            
            Orders orders = new Orders();
            orders.setId(orderId);
            orders.setOrderStatus(3); // 已发货
            orders.setShipTime(new Date());
            
            return ordersDao.updateOrders(orderId, orders) > 0;
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

    @Override
    public boolean cancelOrderWithValidation(Integer orderId, Integer userId) {
        try {
            // 验证订单是否属于当前用户
            OrdersResl order = selectOrdersById(orderId);
            if (order == null || !order.getUserId().equals(userId)) {
                throw new RuntimeException("订单不存在");
            }
            
            // 只有待支付状态的订单才能取消
            if (!Integer.valueOf(1).equals(order.getOrderStatus())) { // 1表示待支付
                throw new RuntimeException("订单状态不允许取消");
            }
            
            return cancelOrder(orderId);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }
    }

    @Override
    public boolean confirmReceiveWithValidation(Integer orderId, Integer userId) {
        try {
            // 验证订单是否属于当前用户
            OrdersResl order = selectOrdersById(orderId);
            if (order == null || !order.getUserId().equals(userId)) {
                throw new RuntimeException("订单不存在");
            }
            
            // 只有已发货状态的订单才能确认收货
            if (!Integer.valueOf(3).equals(order.getOrderStatus())) { // 3表示已发货
                throw new RuntimeException("订单状态不允许确认收货");
            }
            
            return confirmReceive(orderId);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }
    }

    @Override
    public boolean payOrderWithValidation(Integer orderId, Integer userId, String paymentTransactionId) {
        try {
            // 验证订单是否属于当前用户
            OrdersResl order = selectOrdersById(orderId);
            if (order == null || !order.getUserId().equals(userId)) {
                throw new RuntimeException("订单不存在");
            }
            
            // 只有待支付状态的订单才能支付
            if (!Integer.valueOf(1).equals(order.getOrderStatus())) { // 1表示待支付
                throw new RuntimeException("订单状态不允许支付");
            }
            
            // 生成支付交易号（如果没有提供）
            if (StringUtils.isEmpty(paymentTransactionId)) {
                paymentTransactionId = "PAY" + System.currentTimeMillis();
            }
            
            return payOrder(orderId, paymentTransactionId);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }
    }

    @Override
    public boolean createOrderWithValidation(Orders orders, List<org.example.emarketmall.req.OrderItemReq> orderItems, Integer userId) {
        try {
            // 验证商品库存
            org.example.emarketmall.service.ProductInfoService productInfoService = new org.example.emarketmall.service.impl.ProductInfoServiceImpl();
            for (org.example.emarketmall.req.OrderItemReq item : orderItems) {
                org.example.emarketmall.entity.ProductInfo product = productInfoService.selectProductInfoById(item.getProductId());
                if (product == null) {
                    throw new RuntimeException("商品不存在：" + item.getProductName());
                }
                if (product.getStock() < item.getAmount()) {
                    throw new RuntimeException("商品库存不足：" + item.getProductName());
                }
            }
            
            // 设置用户ID
            orders.setUserId(userId);
            
            return createOrder(orders, orderItems);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }
    }

    @Override
    public boolean createOrderFromCartWithValidation(Orders orders, List<Integer> cartIds, Integer userId) {
        try {
            // 获取购物车商品
            org.example.emarketmall.service.OrderCartService orderCartService = new org.example.emarketmall.service.impl.OrderCartServiceImpl();
            org.example.emarketmall.service.ProductInfoService productInfoService = new org.example.emarketmall.service.impl.ProductInfoServiceImpl();
            
            List<org.example.emarketmall.entity.OrderCart> cartItems = new java.util.ArrayList<>();
            for (Integer cartId : cartIds) {
                org.example.emarketmall.entity.OrderCart cart = orderCartService.selectOrderCartById(cartId);
                if (cart == null || !cart.getUserId().equals(userId)) {
                    throw new RuntimeException("购物车信息不存在");
                }
                cartItems.add(cart);
            }
            
            // 验证商品库存
            for (org.example.emarketmall.entity.OrderCart cart : cartItems) {
                org.example.emarketmall.entity.ProductInfo product = productInfoService.selectProductInfoById(Integer.parseInt(cart.getProductId()));
                if (product == null) {
                    throw new RuntimeException("商品不存在：" + cart.getProductName());
                }
                if (product.getStock() < cart.getAmount()) {
                    throw new RuntimeException("商品库存不足：" + cart.getProductName());
                }
            }
            
            // 设置用户ID
            orders.setUserId(userId);
            
            // 创建订单
            boolean result = createOrderFromCart(orders, cartItems);
            if (result) {
                // 删除购物车中的商品
                Integer[] cartIdArray = cartIds.toArray(new Integer[0]);
                orderCartService.deleteOrderCartByIds(cartIdArray);
            }
            
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }
    }
}