package org.example.emarketmall.controller.admin;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.common.TableDataInfo;
import org.example.emarketmall.entity.Orders;
import org.example.emarketmall.service.OrdersService;
import org.example.emarketmall.service.impl.OrdersServiceImpl;
import org.example.emarketmall.utils.BeanUtils;
import org.example.emarketmall.utils.ServletUtils;
import org.example.emarketmall.utils.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @Description: 订单管理控制器
 * @author: system
 * @date: 2024年12月19日
 */
@WebServlet("/mall/orders")
public class OrdersController extends HttpServlet {
    private OrdersService ordersService = new OrdersServiceImpl();

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
        String referer = req.getHeader("Referer");
        if (referer != null && referer.contains("index")) {
            resp.sendRedirect("/admin/orders/orders.jsp");
            return;
        }
        String opt = ServletUtils.getParamFromPayLoad(req, "opt");
        String id = ServletUtils.getParamFromPayLoad(req, "id");

        if (StringUtils.isEmpty(opt)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("操作选项opt内容异常")));
            return;
        }

        Orders orders = ServletUtils.getObjectFromPayload(req, Orders.class);
        if (BeanUtils.isEmpty(orders)) {
            orders = null;
        }

        switch (opt) {
            case "add":
                if ("GET".equalsIgnoreCase(req.getMethod())) {
                    resp.sendRedirect("/admin/orders/add.jsp");
                    return;
                }
                if ("POST".equalsIgnoreCase(req.getMethod())) {
                    if (orders != null) {
                        ServletUtils.renderString(resp, JSON.toJSONString(addOrders(orders)));
                    } else {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("新增订单信息对象内容异常")));
                    }
                }
                break;
            case "edit":
                if ("GET".equalsIgnoreCase(req.getMethod())) {
                    if (StringUtils.isEmpty(id)) {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("编辑ID内容异常")));
                        return;
                    } else {
                        Orders order = ordersService.selectOrdersById(Integer.parseInt(id));
                        req.setAttribute("order", order);
                        req.getRequestDispatcher("/admin/orders/edit.jsp").forward(req, resp);
                        return;
                    }
                }
                if ("POST".equalsIgnoreCase(req.getMethod())) {
                    if (orders != null) {
                        ServletUtils.renderString(resp, JSON.toJSONString(editOrders(id, orders)));
                    } else {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("编辑订单信息对象内容异常")));
                    }
                }
                break;
            case "remove":
                ServletUtils.renderString(resp, JSON.toJSONString(removeOrders(id)));
                break;
            case "list":
                ServletUtils.renderString(resp, JSON.toJSONString(list(orders) != null ? list(orders) : AjaxResult.error("订单信息查询异常")));
                break;
            case "detail":
                if (StringUtils.isEmpty(id)) {
                    ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("详情ID内容异常")));
                    return;
                } else {
                    Orders order = ordersService.selectOrdersById(Integer.parseInt(id));
                    req.setAttribute("order", order);
                    req.getRequestDispatcher("/admin/orders/detail.jsp").forward(req, resp);
                    return;
                }
            case "updateStatus":
                String orderStatus = ServletUtils.getParamFromPayLoad(req, "orderStatus");
                ServletUtils.renderString(resp, JSON.toJSONString(updateOrderStatus(id, orderStatus)));
                break;
            case "cancel":
                ServletUtils.renderString(resp, JSON.toJSONString(cancelOrder(id)));
                break;
            case "confirm":
                ServletUtils.renderString(resp, JSON.toJSONString(confirmReceive(id)));
                break;
            case "pay":
                String paymentTransactionId = ServletUtils.getParamFromPayLoad(req, "paymentTransactionId");
                ServletUtils.renderString(resp, JSON.toJSONString(payOrder(id, paymentTransactionId)));
                break;
            case "ship":
                ServletUtils.renderString(resp, JSON.toJSONString(shipOrder(id)));
                break;
            default:
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("操作选项opt内容异常")));
        }
    }

    private AjaxResult addOrders(Orders orders) {
        if (orders != null) {
            if (ordersService.createOrder(orders)) {
                return AjaxResult.success("新增订单信息成功");
            }
        }
        return AjaxResult.error("新增订单信息失败");
    }

    private AjaxResult editOrders(String id, Orders orders) {
        if (StringUtils.isNotEmpty(id)) {
            Orders destOrders = ordersService.selectOrdersById(Integer.parseInt(id));
            if (destOrders != null) {
                // 更新订单信息
                destOrders.setShippingUser(orders.getShippingUser());
                destOrders.setAddress(orders.getAddress());
                destOrders.setPaymentMethod(orders.getPaymentMethod());
                destOrders.setOrderMoney(orders.getOrderMoney());
                destOrders.setShippingMoney(orders.getShippingMoney());
                destOrders.setDistrictMoney(orders.getDistrictMoney());
                destOrders.setPaymentMoney(orders.getPaymentMoney());
                destOrders.setOrderStatus(orders.getOrderStatus());
                destOrders.setExpectedDeliveryTime(orders.getExpectedDeliveryTime());
                destOrders.setRemark(orders.getRemark());
                
                if (ordersService.updateOrders(destOrders) > 0) {
                    return AjaxResult.success("修改订单信息成功");
                }
            }
        }
        return AjaxResult.error("修改订单信息失败");
    }

    private AjaxResult removeOrders(String id) {
        if (StringUtils.isNotEmpty(id)) {
            if (ordersService.deleteOrdersById(Integer.parseInt(id)) > 0) {
                return AjaxResult.success("删除订单信息成功");
            }
        }
        return AjaxResult.error("删除订单信息失败");
    }

    private AjaxResult updateOrderStatus(String id, String orderStatus) {
        if (StringUtils.isNotEmpty(id) && StringUtils.isNotEmpty(orderStatus)) {
            try {
                Integer statusCode = Integer.parseInt(orderStatus);
                if (ordersService.updateOrderStatus(Integer.parseInt(id), statusCode) > 0) {
                    return AjaxResult.success("更新订单状态成功");
                }
            } catch (NumberFormatException e) {
                return AjaxResult.error("订单状态格式错误");
            }
        }
        return AjaxResult.error("更新订单状态失败");
    }

    private AjaxResult cancelOrder(String id) {
        if (StringUtils.isNotEmpty(id)) {
            if (ordersService.cancelOrder(Integer.parseInt(id))) {
                return AjaxResult.success("取消订单成功");
            }
        }
        return AjaxResult.error("取消订单失败");
    }

    private AjaxResult confirmReceive(String id) {
        if (StringUtils.isNotEmpty(id)) {
            if (ordersService.confirmReceive(Integer.parseInt(id))) {
                return AjaxResult.success("确认收货成功");
            }
        }
        return AjaxResult.error("确认收货失败");
    }

    private AjaxResult payOrder(String id, String paymentTransactionId) {
        if (StringUtils.isNotEmpty(id) && StringUtils.isNotEmpty(paymentTransactionId)) {
            if (ordersService.payOrder(Integer.parseInt(id), paymentTransactionId)) {
                return AjaxResult.success("支付订单成功");
            }
        }
        return AjaxResult.error("支付订单失败");
    }

    private AjaxResult shipOrder(String id) {
        if (StringUtils.isNotEmpty(id)) {
            Orders orders = ordersService.selectOrdersById(Integer.parseInt(id));
            if (orders != null && orders.getOrderStatus() == 2) { // 只有已支付的订单才能发货
                orders.setOrderStatus(3); // 已发货
                orders.setShipTime(new java.util.Date()); // 设置发货时间
                if (ordersService.updateOrders(orders) > 0) {
                    return AjaxResult.success("发货成功");
                }
            } else {
                return AjaxResult.error("订单状态不正确，无法发货");
            }
        }
        return AjaxResult.error("发货失败");
    }

    private TableDataInfo list(Orders orders) {
        List<Orders> ordersList = ordersService.selectOrdersList(orders);
        if (ordersList != null) {
            return TableDataInfo.getDataTable(ordersList);
        }
        return null;
    }
}