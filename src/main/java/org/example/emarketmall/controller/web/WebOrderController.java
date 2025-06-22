package org.example.emarketmall.controller.web;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.entity.*;
import org.example.emarketmall.resl.OrdersResl;
import org.example.emarketmall.service.OrdersService;
import org.example.emarketmall.service.ProductInfoService;
import org.example.emarketmall.service.impl.OrdersServiceImpl;
import org.example.emarketmall.service.impl.ProductInfoServiceImpl;
import org.example.emarketmall.utils.ServletUtils;
import org.example.emarketmall.utils.StringUtils;
import org.example.emarketmall.utils.DateUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @Description: Web端用户订单控制器（用户专用简化版）
 * @author: 若若
 * @date: 2024年12月19日
 */
@WebServlet("/web/order/*")
public class WebOrderController extends HttpServlet {
    private OrdersService ordersService = new OrdersServiceImpl();
    private ProductInfoService productInfoService = new ProductInfoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doProcessRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doProcessRequest(req, resp);
    }

    private void doProcessRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String pathInfo = req.getPathInfo();
        if (StringUtils.isEmpty(pathInfo)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("请求路径异常")));
            return;
        }

        // 检查用户登录状态
        HttpSession session = req.getSession();
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        if (userInfo == null) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户未登录")));
            return;
        }

        switch (pathInfo) {
            case "/myOrders":
                getUserOrders(req, resp, userInfo.getId());
                break;
            case "/orderDetail":
                getUserOrderDetail(req, resp, userInfo.getId());
                break;
            case "/createOrder":
                createUserOrder(req, resp, userInfo.getId());
                break;
            case "/cancelOrder":
                cancelUserOrder(req, resp, userInfo.getId());
                break;
            case "/payOrder":
                payUserOrder(req, resp, userInfo.getId());
                break;
            case "/confirmReceive":
                confirmUserReceive(req, resp, userInfo.getId());
                break;
            default:
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("不支持的操作")));
                break;
        }
    }

    /**
     * 获取用户订单列表（简化版）
     */
    private void getUserOrders(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String statusStr = ServletUtils.getParamFromPayLoad(req, "status");
            System.out.println("获取用户订单列表，状态：" + statusStr);
            List<OrdersResl> orderList;
            
            if (!StringUtils.isEmpty(statusStr)) {
                System.out.println("按状态查询订单，状态：" + statusStr);
                // 按状态查询
                List<OrdersResl> allOrdersByStatus = ordersService.selectOrdersByStatus(statusStr);
                System.out.println("查询到订单数量：" + allOrdersByStatus.size());
                // 过滤出当前用户的订单
                orderList = new ArrayList<>();
                for (OrdersResl order : allOrdersByStatus) {
                    System.out.println("订单ID：" + order.getId() + ", 用户ID：" + order.getUserId());
                    if (order.getUserId().equals(userId)) {

                        orderList.add(order);
                    }
                }
            } else {
                // 查询用户所有订单
                orderList = ordersService.selectOrdersByUserId(userId);
            }
            
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(orderList)));
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("获取订单列表失败：" + e.getMessage())));
        }
    }

    /**
     * 获取用户订单详情（简化版）
     */
    private void getUserOrderDetail(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String orderIdStr = ServletUtils.getParamFromPayLoad(req, "orderId");
            String orderNum = ServletUtils.getParamFromPayLoad(req, "orderNum");
            System.out.println("获取订单详情，订单ID：" + orderIdStr + ", 订单号：" + orderNum);
            
            if (StringUtils.isEmpty(orderIdStr) && StringUtils.isEmpty(orderNum)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单ID或订单号不能为空")));
                return;
            }

            Integer orderId = Integer.parseInt(orderIdStr);
            OrdersResl order = ordersService.selectOrdersById(orderId);


            if (order == null || !order.getUserId().equals(userId)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单不存在或无权限访问")));
                return;
            }

            System.out.println("查询到订单：" + order.getOrderNum() + ", 用户ID：" + order.getUserId());
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(order)));

        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("获取订单详情失败：" + e.getMessage())));
        }
    }

    /**
     * 创建用户订单（简化版）
     */
    private void createUserOrder(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            HttpSession session = req.getSession();
            UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
            if (userInfo == null) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户未登录")));
                return;
            }
            System.out.println("当前用户ID：" + userInfo.getLoginName());
            String productIdStr = ServletUtils.getParamFromPayLoad(req, "productId");
            String amountStr = "1";
            String address = "默认地址";
            String shippingUser = userInfo.getLoginName();
            System.out.println("购买的商品id："+productIdStr);
            if (StringUtils.isEmpty(productIdStr) || StringUtils.isEmpty(amountStr)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("商品ID和数量不能为空")));
                return;
            }
            
            if (StringUtils.isEmpty(address) || StringUtils.isEmpty(shippingUser)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("收货地址和收货人不能为空")));
                return;
            }
            
            Integer productId = Integer.parseInt(productIdStr);
            Integer amount = Integer.parseInt(amountStr);
            
            if (amount <= 0) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("商品数量必须大于0")));
                return;
            }
            
            // 查询商品信息
            ProductInfo product = productInfoService.selectProductInfoById(productId);
            if (product == null) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("商品不存在")));
                return;
            }
            
            // 检查库存
            if (product.getStock() < amount) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("商品库存不足，当前库存：" + product.getStock())));
                return;
            }
            
            // 创建订单
            Orders order = buildUserOrder(userId, product, amount, address, shippingUser);
            
            // 保存订单
            boolean result = ordersService.createOrder(order);
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("订单创建成功", order.getOrderNum())));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单创建失败")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常：" + e.getMessage())));
        }
    }

    /**
     * 取消用户订单（简化版）
     */
    private void cancelUserOrder(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String orderIdStr = ServletUtils.getParamFromPayLoad(req, "orderId");
            
            if (StringUtils.isEmpty(orderIdStr)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单ID不能为空")));
                return;
            }
            
            Integer orderId = Integer.parseInt(orderIdStr);
            
            // 验证订单权限
            if (!validateUserOrderPermission(orderId, userId)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单不存在或无权限操作")));
                return;
            }
            
            // 验证订单状态
            OrdersResl order = ordersService.selectOrdersById(orderId);
            if (order.getOrderStatus() != 1) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("只有待支付状态的订单才能取消")));
                return;
            }
            
            boolean result = ordersService.cancelOrder(orderId);
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("订单取消成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单取消失败")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常：" + e.getMessage())));
        }
    }

    /**
     * 支付用户订单（简化版）
     */
    private void payUserOrder(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String orderIdStr = ServletUtils.getParamFromPayLoad(req, "orderId");
//            String paymentMethod = ServletUtils.getParamFromPayLoad(req, "paymentMethod");
            String paymentMethod = "1"; // 默认支付宝支付
            System.out.println("支付订单，订单ID：" + orderIdStr + ", 支付方式：" + paymentMethod);
            
            if (StringUtils.isEmpty(orderIdStr)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单ID不能为空")));
                return;
            }
            
            Integer orderId = Integer.parseInt(orderIdStr);
            
            // 验证订单权限
            if (!validateUserOrderPermission(orderId, userId)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单不存在或无权限操作")));
                return;
            }
            
            // 验证订单状态
            OrdersResl order = ordersService.selectOrdersById(orderId);
            if (order.getOrderStatus() != 1) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("只有待支付状态的订单才能支付")));
                return;
            }
            
            // 生成支付交易号
            String paymentTransactionId = UUID.randomUUID().toString();
            
            boolean result = ordersService.payOrder(orderId, paymentTransactionId, paymentMethod != null ? Integer.parseInt(paymentMethod) : 1);
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("支付成功", paymentTransactionId)));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("支付失败")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常：" + e.getMessage())));
        }
    }

    /**
     * 确认收货（简化版）
     */
    private void confirmUserReceive(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String orderIdStr = ServletUtils.getParamFromPayLoad(req, "orderId");
            System.out.println("确认收货，订单ID：" + orderIdStr);
            
            if (StringUtils.isEmpty(orderIdStr)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单ID不能为空")));
                return;
            }
            
            Integer orderId = Integer.parseInt(orderIdStr);
            
            // 验证订单权限
            if (!validateUserOrderPermission(orderId, userId)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单不存在或无权限操作")));
                return;
            }
            
            // 验证订单状态
            OrdersResl order = ordersService.selectOrdersById(orderId);
            if (order.getOrderStatus() != 3) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("只有已发货状态的订单才能确认收货")));
                return;
            }
            
            boolean result = ordersService.confirmReceive(orderId);
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("确认收货成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("确认收货失败")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常：" + e.getMessage())));
        }
    }


    // ========== 私有辅助方法 ==========

    /**
     * 构建用户订单对象
     */
    private Orders buildUserOrder(Integer userId, ProductInfo product, Integer amount, 
                                 String address, String shippingUser) {
        Orders order = new Orders();
        order.setOrderNum(generateOrderNum());
        order.setUserId(userId);
        order.setShippingUser(shippingUser);
        order.setAddress(address);
        order.setPaymentMethod(1); // default alipay
        order.setOrderStatus(1); // pending payment
        order.setCreatedBy("user");
        order.setCreatedTime(DateUtils.getTime());
        order.setUpdatedTime(DateUtils.getTime());
        order.setRemark("用户下单");
        
        // 计算订单金额
        BigDecimal totalAmount = product.getPrice().multiply(new BigDecimal(amount));
        BigDecimal shippingMoney = calculateShippingFee(totalAmount); // 计算运费
        BigDecimal districtMoney = BigDecimal.ZERO; // 暂无优惠
        
        order.setOrderMoney(totalAmount);
        order.setPaymentMoney(totalAmount.add(shippingMoney).subtract(districtMoney));
        order.setShippingMoney(shippingMoney);
        order.setDistrictMoney(districtMoney);
        
        // 创建订单详情
        List<OrderDetail> orderDetails = new ArrayList<>();
        OrderDetail detail = new OrderDetail();
        detail.setProductId(product.getId());
        detail.setProductName(product.getProductName());
        detail.setAmount(amount);
        detail.setProductPrice(product.getPrice());
        detail.setCreatedBy("user");
        detail.setCreatedTime(DateUtils.getTime());
        detail.setUpdatedTime(DateUtils.getTime());
        orderDetails.add(detail);
        
        order.setOrderDetails(orderDetails);
        
        return order;
    }

    /**
     * 验证用户订单权限
     */
    private boolean validateUserOrderPermission(Integer orderId, Integer userId) {
        try {
            OrdersResl order = ordersService.selectOrdersById(orderId);
            return order != null && order.getUserId().equals(userId);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 生成订单编号
     */
    private String generateOrderNum() {
        return "USR" + System.currentTimeMillis() + UUID.randomUUID().toString().substring(0, 6).toUpperCase();
    }

    /**
     * Generate payment transaction ID
     */

    /**
     * Calculate shipping fee (simplified)
     */
    private BigDecimal calculateShippingFee(BigDecimal orderAmount) {
        // Free shipping for orders over 99, otherwise 10 yuan shipping fee
        if (orderAmount.compareTo(new BigDecimal("99")) >= 0) {
            return BigDecimal.ZERO;
        }
        return new BigDecimal("10");
    }
}