package org.example.emarketmall.controller.admin;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.common.TableDataInfo;
import org.example.emarketmall.entity.OrderDetail;
import org.example.emarketmall.service.OrderDetailService;
import org.example.emarketmall.service.impl.OrderDetailServiceImpl;
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
 * @Description: 订单详情管理控制器
 * @author: system
 * @date: 2024年12月19日
 */
@WebServlet("/mall/orderDetail")
public class OrderDetailController extends HttpServlet {
    private OrderDetailService orderDetailService = new OrderDetailServiceImpl();

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
            resp.sendRedirect("/admin/orderDetail/orderDetail.jsp");
            return;
        }
        String opt = ServletUtils.getParamFromPayLoad(req, "opt");
        String id = ServletUtils.getParamFromPayLoad(req, "id");

        if (StringUtils.isEmpty(opt)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("操作选项opt内容异常")));
            return;
        }

        OrderDetail orderDetail = ServletUtils.getObjectFromPayload(req, OrderDetail.class);
        if (BeanUtils.isEmpty(orderDetail)) {
            orderDetail = null;
        }

        switch (opt) {
            case "add":
                if ("GET".equalsIgnoreCase(req.getMethod())) {
                    resp.sendRedirect("/admin/orderDetail/add.jsp");
                    return;
                }
                if ("POST".equalsIgnoreCase(req.getMethod())) {
                    if (orderDetail != null) {
                        ServletUtils.renderString(resp, JSON.toJSONString(addOrderDetail(orderDetail)));
                    } else {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("新增订单详情对象内容异常")));
                    }
                }
                break;
            case "edit":
                if ("GET".equalsIgnoreCase(req.getMethod())) {
                    if (StringUtils.isEmpty(id)) {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("编辑ID内容异常")));
                        return;
                    } else {
                        OrderDetail detail = orderDetailService.selectOrderDetailById(Integer.parseInt(id));
                        req.setAttribute("orderDetail", detail);
                        req.getRequestDispatcher("/admin/orderDetail/edit.jsp").forward(req, resp);
                        return;
                    }
                }
                if ("POST".equalsIgnoreCase(req.getMethod())) {
                    if (orderDetail != null) {
                        ServletUtils.renderString(resp, JSON.toJSONString(editOrderDetail(id, orderDetail)));
                    } else {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("编辑订单详情对象内容异常")));
                    }
                }
                break;
            case "remove":
                ServletUtils.renderString(resp, JSON.toJSONString(removeOrderDetail(id)));
                break;
            case "list":
                ServletUtils.renderString(resp, JSON.toJSONString(list(orderDetail) != null ? list(orderDetail) : AjaxResult.error("订单详情查询异常")));
                break;
            case "detail":
                if (StringUtils.isEmpty(id)) {
                    ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("详情ID内容异常")));
                    return;
                } else {
                    OrderDetail detail = orderDetailService.selectOrderDetailById(Integer.parseInt(id));
                    req.setAttribute("orderDetail", detail);
                    req.getRequestDispatcher("/admin/orderDetail/detail.jsp").forward(req, resp);
                    return;
                }
            case "getByOrderId":
                String orderId = ServletUtils.getParamFromPayLoad(req, "orderId");
                ServletUtils.renderString(resp, JSON.toJSONString(getByOrderId(orderId)));
                break;
            case "getByProductId":
                String productId = ServletUtils.getParamFromPayLoad(req, "productId");
                ServletUtils.renderString(resp, JSON.toJSONString(getByProductId(productId)));
                break;
            case "removeByOrderId":
                String orderIdRemove = ServletUtils.getParamFromPayLoad(req, "orderId");
                ServletUtils.renderString(resp, JSON.toJSONString(removeByOrderId(orderIdRemove)));
                break;
            case "batchAdd":
                String orderDetailListJson = ServletUtils.getParamFromPayLoad(req, "orderDetailList");
                ServletUtils.renderString(resp, JSON.toJSONString(batchAdd(orderDetailListJson)));
                break;
            case "batchRemove":
                String ids = ServletUtils.getParamFromPayLoad(req, "ids");
                ServletUtils.renderString(resp, JSON.toJSONString(batchRemove(ids)));
                break;
            default:
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("操作选项opt内容异常")));
        }
    }

    private AjaxResult addOrderDetail(OrderDetail orderDetail) {
        if (orderDetail != null) {
            if (orderDetailService.insertOrderDetail(orderDetail) > 0) {
                return AjaxResult.success("新增订单详情成功");
            }
        }
        return AjaxResult.error("新增订单详情失败");
    }

    private AjaxResult editOrderDetail(String id, OrderDetail orderDetail) {
        if (StringUtils.isNotEmpty(id)) {
            OrderDetail destOrderDetail = orderDetailService.selectOrderDetailById(Integer.parseInt(id));
            if (destOrderDetail != null) {
                destOrderDetail.setOrderId(orderDetail.getOrderId());
                destOrderDetail.setProductId(orderDetail.getProductId());
                destOrderDetail.setProductName(orderDetail.getProductName());
                destOrderDetail.setProductPrice(orderDetail.getProductPrice());
                destOrderDetail.setAmount(orderDetail.getAmount());
                destOrderDetail.setRemark(orderDetail.getRemark());
                
                if (orderDetailService.updateOrderDetail(destOrderDetail) > 0) {
                    return AjaxResult.success("修改订单详情成功");
                }
            }
        }
        return AjaxResult.error("修改订单详情失败");
    }

    private AjaxResult removeOrderDetail(String id) {
        if (StringUtils.isNotEmpty(id)) {
            if (orderDetailService.deleteOrderDetailById(Integer.parseInt(id)) > 0) {
                return AjaxResult.success("删除订单详情成功");
            }
        }
        return AjaxResult.error("删除订单详情失败");
    }

    private TableDataInfo getByOrderId(String orderId) {
        if (StringUtils.isNotEmpty(orderId)) {
            List<OrderDetail> detailList = orderDetailService.selectOrderDetailByOrderId(Integer.parseInt(orderId));
            if (detailList != null) {
                return TableDataInfo.getDataTable(detailList);
            }
        }
        return null;
    }

    private TableDataInfo getByProductId(String productId) {
        if (StringUtils.isNotEmpty(productId)) {
            List<OrderDetail> detailList = orderDetailService.selectOrderDetailByProductId(Integer.parseInt(productId));
            if (detailList != null) {
                return TableDataInfo.getDataTable(detailList);
            }
        }
        return null;
    }

    private AjaxResult removeByOrderId(String orderId) {
        if (StringUtils.isNotEmpty(orderId)) {
            if (orderDetailService.deleteOrderDetailByOrderId(Integer.parseInt(orderId)) > 0) {
                return AjaxResult.success("删除订单详情成功");
            }
        }
        return AjaxResult.error("删除订单详情失败");
    }

    private AjaxResult batchAdd(String orderDetailListJson) {
        if (StringUtils.isNotEmpty(orderDetailListJson)) {
            try {
                List<OrderDetail> orderDetailList = JSON.parseArray(orderDetailListJson, OrderDetail.class);
                if (orderDetailList != null && !orderDetailList.isEmpty()) {
                    if (orderDetailService.insertOrderDetailBatch(orderDetailList) > 0) {
                        return AjaxResult.success("批量新增订单详情成功");
                    }
                }
            } catch (Exception e) {
                return AjaxResult.error("批量新增订单详情失败：数据格式错误");
            }
        }
        return AjaxResult.error("批量新增订单详情失败");
    }

    private AjaxResult batchRemove(String ids) {
        if (StringUtils.isNotEmpty(ids)) {
            try {
                String[] idArray = ids.split(",");
                Integer[] idIntArray = new Integer[idArray.length];
                for (int i = 0; i < idArray.length; i++) {
                    idIntArray[i] = Integer.parseInt(idArray[i].trim());
                }
                if (orderDetailService.deleteOrderDetailByIds(idIntArray) > 0) {
                    return AjaxResult.success("批量删除订单详情成功");
                }
            } catch (Exception e) {
                return AjaxResult.error("批量删除订单详情失败：ID格式错误");
            }
        }
        return AjaxResult.error("批量删除订单详情失败");
    }

    private TableDataInfo list(OrderDetail orderDetail) {
        List<OrderDetail> detailList = orderDetailService.selectOrderDetailList(orderDetail);
        if (detailList != null) {
            return TableDataInfo.getDataTable(detailList);
        }
        return null;
    }
}