package org.example.emarketmall.controller.web;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.entity.*;
import org.example.emarketmall.enums.OrderStatus;
import org.example.emarketmall.req.OrderCreateReq;
 import org.example.emarketmall.req.OrderItemReq;
import org.example.emarketmall.resl.OrdersResl;
import org.example.emarketmall.service.OrderCartService;
import org.example.emarketmall.service.OrderDetailService;
import org.example.emarketmall.service.OrdersService;
import org.example.emarketmall.service.ProductInfoService;
import org.example.emarketmall.service.impl.OrderCartServiceImpl;
import org.example.emarketmall.service.impl.OrderDetailServiceImpl;
import org.example.emarketmall.service.impl.OrdersServiceImpl;
import org.example.emarketmall.service.impl.ProductInfoServiceImpl;
import org.example.emarketmall.utils.ServletUtils;
import org.example.emarketmall.utils.StringUtils;

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

/**
 * @Description: Web端订单控制器
 * @author: system
 * @date: 2024年12月19日
 */
@WebServlet("/web/order/*")
public class WebOrderController extends HttpServlet {
    private OrdersService ordersService = new OrdersServiceImpl();
    private OrderDetailService orderDetailService = new OrderDetailServiceImpl();
    private OrderCartService orderCartService = new OrderCartServiceImpl();
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
            case "/create":
                createOrder(req, resp, userInfo.getId());
                break;
            case "/createFromCart":
                createOrderFromCart(req, resp, userInfo.getId());
                break;
            case "/list":
                getOrderList(req, resp, userInfo.getId());
                break;
            case "/detail":
                getOrderDetail(req, resp, userInfo.getId());
                break;
            case "/cancel":
                cancelOrder(req, resp, userInfo.getId());
                break;
            case "/confirm":
                confirmReceive(req, resp, userInfo.getId());
                break;
            case "/pay":
                payOrder(req, resp, userInfo.getId());
                break;
            default:
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("不支持的操作")));
                break;
        }
    }

    /**
     * 立即下单（直接购买）
     */
    private void createOrder(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            OrderCreateReq orderCreateReq = ServletUtils.getObjectFromPayload(req, OrderCreateReq.class);
            if (orderCreateReq == null || orderCreateReq.getOrderItems() == null || orderCreateReq.getOrderItems().isEmpty()) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单信息异常")));
                return;
            }

            // 创建订单
            Orders order = new Orders();
            // 设置订单基本信息
            order.setShippingUser(orderCreateReq.getShippingUser());
            order.setAddress(orderCreateReq.getAddress());
            order.setPaymentMethod(orderCreateReq.getPaymentMethod());
            order.setShippingMoney(orderCreateReq.getShippingMoney() != null ? orderCreateReq.getShippingMoney() : BigDecimal.ZERO);
            order.setDistrictMoney(orderCreateReq.getDistrictMoney() != null ? orderCreateReq.getDistrictMoney() : BigDecimal.ZERO);
            order.setRemark(orderCreateReq.getRemark());

            // 调用Service层创建订单（包含库存验证）
            boolean result = ordersService.createOrderWithValidation(order, orderCreateReq.getOrderItems(), userId);
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("订单创建成功", order.getOrderNum())));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单创建失败")));
            }
        } catch (RuntimeException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error(e.getMessage())));
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常")));
        }
    }

    /**
     * 从购物车创建订单
     */
    private void createOrderFromCart(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            OrderCreateReq orderCreateReq = ServletUtils.getObjectFromPayload(req, OrderCreateReq.class);
            if (orderCreateReq == null || orderCreateReq.getCartIds() == null || orderCreateReq.getCartIds().isEmpty()) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("购物车信息异常")));
                return;
            }

            // 创建订单
            Orders order = new Orders();
            order.setShippingUser(orderCreateReq.getShippingUser());
            order.setAddress(orderCreateReq.getAddress());
            order.setPaymentMethod(orderCreateReq.getPaymentMethod());
            order.setShippingMoney(orderCreateReq.getShippingMoney() != null ? orderCreateReq.getShippingMoney() : BigDecimal.ZERO);
            order.setDistrictMoney(orderCreateReq.getDistrictMoney() != null ? orderCreateReq.getDistrictMoney() : BigDecimal.ZERO);
            order.setRemark(orderCreateReq.getRemark());

            // 调用Service层从购物车创建订单（包含库存验证）
            boolean result = ordersService.createOrderFromCartWithValidation(order, orderCreateReq.getCartIds(), userId);
            if (result) {
                
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("订单创建成功", order.getOrderNum())));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单创建失败")));
            }
        } catch (RuntimeException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error(e.getMessage())));
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常")));
        }
    }

    /**
     * 获取订单列表
     */
    private void getOrderList(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String statusStr = ServletUtils.getParamFromPayLoad(req, "status");
            String pageNumStr = ServletUtils.getParamFromPayLoad(req, "pageNum");
            String pageSizeStr = ServletUtils.getParamFromPayLoad(req, "pageSize");
            
            Orders queryOrder = new Orders();
            queryOrder.setUserId(userId);
            
            if (!StringUtils.isEmpty(statusStr)) {
                queryOrder.setOrderStatus(Integer.parseInt(statusStr));
            }
            
            List<OrdersResl> orderList = ordersService.selectOrdersList(queryOrder);
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(orderList)));
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("获取订单列表失败")));
        }
    }

    /**
     * 获取订单详情
     */
    private void getOrderDetail(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String orderIdStr = ServletUtils.getParamFromPayLoad(req, "orderId");
            String orderNum = ServletUtils.getParamFromPayLoad(req, "orderNum");
            
            OrdersResl order = null;
            
            if (!StringUtils.isEmpty(orderIdStr)) {
                Integer orderId = Integer.parseInt(orderIdStr);
                order = ordersService.selectOrdersById(orderId);
            } else if (!StringUtils.isEmpty(orderNum)) {
                order = ordersService.selectOrdersByOrderNum(orderNum);
            }
            
            if (order == null || !order.getUserId().equals(userId)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单不存在")));
                return;
            }
            
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(order)));
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("获取订单详情失败")));
        }
    }

    /**
     * 取消订单
     */
    private void cancelOrder(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String orderIdStr = ServletUtils.getParamFromPayLoad(req, "orderId");
            
            if (StringUtils.isEmpty(orderIdStr)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("参数异常")));
                return;
            }
            
            Integer orderId = Integer.parseInt(orderIdStr);
            
            // 调用Service层取消订单（包含用户权限验证）
            boolean result = ordersService.cancelOrderWithValidation(orderId, userId);
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("订单取消成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("订单取消失败")));
            }
        } catch (RuntimeException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error(e.getMessage())));
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常")));
        }
    }

    /**
     * 确认收货
     */
    private void confirmReceive(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String orderIdStr = ServletUtils.getParamFromPayLoad(req, "orderId");
            
            if (StringUtils.isEmpty(orderIdStr)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("参数异常")));
                return;
            }
            
            Integer orderId = Integer.parseInt(orderIdStr);
            
            // 调用Service层确认收货（包含用户权限验证）
            boolean result = ordersService.confirmReceiveWithValidation(orderId, userId);
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("确认收货成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("确认收货失败")));
            }
        } catch (RuntimeException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error(e.getMessage())));
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常")));
        }
    }

    /**
     * 支付订单
     */
    private void payOrder(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String orderIdStr = ServletUtils.getParamFromPayLoad(req, "orderId");
            String paymentTransactionId = ServletUtils.getParamFromPayLoad(req, "paymentTransactionId");
            
            if (StringUtils.isEmpty(orderIdStr)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("参数异常")));
                return;
            }
            
            Integer orderId = Integer.parseInt(orderIdStr);
            
            // 调用Service层支付订单（包含用户权限验证）
            boolean result = ordersService.payOrderWithValidation(orderId, userId, paymentTransactionId);
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("支付成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("支付失败")));
            }
        } catch (RuntimeException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error(e.getMessage())));
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常")));
        }
    }


}