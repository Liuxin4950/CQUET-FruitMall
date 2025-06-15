package org.example.emarketmall.controller.admin;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.common.TableDataInfo;
import org.example.emarketmall.entity.OrderCart;
import org.example.emarketmall.service.OrderCartService;
import org.example.emarketmall.service.impl.OrderCartServiceImpl;
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
 * @Description: 购物车管理控制器
 * @author: system
 * @date: 2024年12月19日
 */
@WebServlet("/mall/cart")
public class OrderCartController extends HttpServlet {
    private OrderCartService orderCartService = new OrderCartServiceImpl();

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
            resp.sendRedirect("/admin/cart/cart.jsp");
            return;
        }
        String opt = ServletUtils.getParamFromPayLoad(req, "opt");
        String id = ServletUtils.getParamFromPayLoad(req, "id");

        if (StringUtils.isEmpty(opt)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("操作选项opt内容异常")));
            return;
        }

        OrderCart orderCart = ServletUtils.getObjectFromPayload(req, OrderCart.class);
        if (BeanUtils.isEmpty(orderCart)) {
            orderCart = null;
        }

        switch (opt) {
            case "add":
                if ("GET".equalsIgnoreCase(req.getMethod())) {
                    resp.sendRedirect("/admin/cart/add.jsp");
                    return;
                }
                if ("POST".equalsIgnoreCase(req.getMethod())) {
                    if (orderCart != null) {
                        ServletUtils.renderString(resp, JSON.toJSONString(addOrderCart(orderCart)));
                    } else {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("新增购物车信息对象内容异常")));
                    }
                }
                break;
            case "edit":
                if ("GET".equalsIgnoreCase(req.getMethod())) {
                    if (StringUtils.isEmpty(id)) {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("编辑ID内容异常")));
                        return;
                    } else {
                        OrderCart cart = orderCartService.selectOrderCartById(Integer.parseInt(id));
                        req.setAttribute("cart", cart);
                        req.getRequestDispatcher("/admin/cart/edit.jsp").forward(req, resp);
                        return;
                    }
                }
                if ("POST".equalsIgnoreCase(req.getMethod())) {
                    if (orderCart != null) {
                        ServletUtils.renderString(resp, JSON.toJSONString(editOrderCart(id, orderCart)));
                    } else {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("编辑购物车信息对象内容异常")));
                    }
                }
                break;
            case "remove":
                ServletUtils.renderString(resp, JSON.toJSONString(removeOrderCart(id)));
                break;
            case "list":
                ServletUtils.renderString(resp, JSON.toJSONString(list(orderCart) != null ? list(orderCart) : AjaxResult.error("购物车信息查询异常")));
                break;
            case "detail":
                if (StringUtils.isEmpty(id)) {
                    ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("详情ID内容异常")));
                    return;
                } else {
                    OrderCart cart = orderCartService.selectOrderCartById(Integer.parseInt(id));
                    req.setAttribute("cart", cart);
                    req.getRequestDispatcher("/admin/cart/detail.jsp").forward(req, resp);
                    return;
                }
            case "addToCart":
                String userId = ServletUtils.getParamFromPayLoad(req, "userId");
                String productId = ServletUtils.getParamFromPayLoad(req, "productId");
                String amount = ServletUtils.getParamFromPayLoad(req, "amount");
                ServletUtils.renderString(resp, JSON.toJSONString(addToCart(userId, productId, amount)));
                break;
            case "removeFromCart":
                String userIdRemove = ServletUtils.getParamFromPayLoad(req, "userId");
                String productIdRemove = ServletUtils.getParamFromPayLoad(req, "productId");
                ServletUtils.renderString(resp, JSON.toJSONString(removeFromCart(userIdRemove, productIdRemove)));
                break;
            case "updateAmount":
                String amountNew = ServletUtils.getParamFromPayLoad(req, "amount");
                ServletUtils.renderString(resp, JSON.toJSONString(updateAmount(id, amountNew)));
                break;
            case "updateSelected":
                String isSelected = ServletUtils.getParamFromPayLoad(req, "isSelected");
                ServletUtils.renderString(resp, JSON.toJSONString(updateSelected(id, isSelected)));
                break;
            case "selectAll":
                String userIdSelectAll = ServletUtils.getParamFromPayLoad(req, "userId");
                String isSelectedAll = ServletUtils.getParamFromPayLoad(req, "isSelected");
                ServletUtils.renderString(resp, JSON.toJSONString(selectAll(userIdSelectAll, isSelectedAll)));
                break;
            case "clearCart":
                String userIdClear = ServletUtils.getParamFromPayLoad(req, "userId");
                ServletUtils.renderString(resp, JSON.toJSONString(clearCart(userIdClear)));
                break;
            case "getCartByUserId":
                String userIdGet = ServletUtils.getParamFromPayLoad(req, "userId");
                ServletUtils.renderString(resp, JSON.toJSONString(getCartByUserId(userIdGet)));
                break;
            case "getSelectedCart":
                String userIdSelected = ServletUtils.getParamFromPayLoad(req, "userId");
                ServletUtils.renderString(resp, JSON.toJSONString(getSelectedCart(userIdSelected)));
                break;
            case "getCartCount":
                String userIdCount = ServletUtils.getParamFromPayLoad(req, "userId");
                ServletUtils.renderString(resp, JSON.toJSONString(getCartCount(userIdCount)));
                break;
            default:
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("操作选项opt内容异常")));
        }
    }

    private AjaxResult addOrderCart(OrderCart orderCart) {
        if (orderCart != null) {
            if (orderCartService.insertOrderCart(orderCart) > 0) {
                return AjaxResult.success("新增购物车信息成功");
            }
        }
        return AjaxResult.error("新增购物车信息失败");
    }

    private AjaxResult editOrderCart(String id, OrderCart orderCart) {
        if (StringUtils.isNotEmpty(id)) {
            OrderCart destOrderCart = orderCartService.selectOrderCartById(Integer.parseInt(id));
            if (destOrderCart != null) {
                destOrderCart.setProductId(orderCart.getProductId());
                destOrderCart.setAmount(orderCart.getAmount());
                destOrderCart.setPrice(orderCart.getPrice());
                destOrderCart.setUserId(orderCart.getUserId());
                destOrderCart.setIsSelected(orderCart.getIsSelected());
                destOrderCart.setProductName(orderCart.getProductName());
                destOrderCart.setProductPic(orderCart.getProductPic());
                destOrderCart.setRemark(orderCart.getRemark());
                
                if (orderCartService.updateOrderCart(destOrderCart) > 0) {
                    return AjaxResult.success("修改购物车信息成功");
                }
            }
        }
        return AjaxResult.error("修改购物车信息失败");
    }

    private AjaxResult removeOrderCart(String id) {
        if (StringUtils.isNotEmpty(id)) {
            if (orderCartService.deleteOrderCartById(Integer.parseInt(id)) > 0) {
                return AjaxResult.success("删除购物车信息成功");
            }
        }
        return AjaxResult.error("删除购物车信息失败");
    }

    private AjaxResult addToCart(String userId, String productId, String amount) {
        if (StringUtils.isNotEmpty(userId) && StringUtils.isNotEmpty(productId) && StringUtils.isNotEmpty(amount)) {
            if (orderCartService.addToCart(Integer.parseInt(userId), productId, Integer.parseInt(amount))) {
                return AjaxResult.success("添加到购物车成功");
            }
        }
        return AjaxResult.error("添加到购物车失败");
    }

    private AjaxResult removeFromCart(String userId, String productId) {
        if (StringUtils.isNotEmpty(userId) && StringUtils.isNotEmpty(productId)) {
            if (orderCartService.removeFromCart(Integer.parseInt(userId), productId)) {
                return AjaxResult.success("从购物车移除成功");
            }
        }
        return AjaxResult.error("从购物车移除失败");
    }

    private AjaxResult updateAmount(String id, String amount) {
        if (StringUtils.isNotEmpty(id) && StringUtils.isNotEmpty(amount)) {
            if (orderCartService.updateOrderCartAmount(Integer.parseInt(id), Integer.parseInt(amount)) > 0) {
                return AjaxResult.success("更新商品数量成功");
            }
        }
        return AjaxResult.error("更新商品数量失败");
    }

    private AjaxResult updateSelected(String id, String isSelected) {
        if (StringUtils.isNotEmpty(id) && StringUtils.isNotEmpty(isSelected)) {
            Boolean selected = "1".equals(isSelected) || "true".equalsIgnoreCase(isSelected);
            if (orderCartService.updateOrderCartSelected(Integer.parseInt(id), selected) > 0) {
                return AjaxResult.success("更新选中状态成功");
            }
        }
        return AjaxResult.error("更新选中状态失败");
    }

    private AjaxResult selectAll(String userId, String isSelected) {
        if (StringUtils.isNotEmpty(userId) && StringUtils.isNotEmpty(isSelected)) {
            Boolean selected = "1".equals(isSelected) || "true".equalsIgnoreCase(isSelected);
            if (orderCartService.updateOrderCartSelectedBatch(Integer.parseInt(userId), selected) > 0) {
                return AjaxResult.success("批量更新选中状态成功");
            }
        }
        return AjaxResult.error("批量更新选中状态失败");
    }

    private AjaxResult clearCart(String userId) {
        if (StringUtils.isNotEmpty(userId)) {
            if (orderCartService.clearCart(Integer.parseInt(userId))) {
                return AjaxResult.success("清空购物车成功");
            }
        }
        return AjaxResult.error("清空购物车失败");
    }

    private TableDataInfo getCartByUserId(String userId) {
        if (StringUtils.isNotEmpty(userId)) {
            List<OrderCart> cartList = orderCartService.selectOrderCartByUserId(Integer.parseInt(userId));
            if (cartList != null) {
                return TableDataInfo.getDataTable(cartList);
            }
        }
        return null;
    }

    private TableDataInfo getSelectedCart(String userId) {
        if (StringUtils.isNotEmpty(userId)) {
            List<OrderCart> cartList = orderCartService.selectSelectedOrderCartByUserId(Integer.parseInt(userId));
            if (cartList != null) {
                return TableDataInfo.getDataTable(cartList);
            }
        }
        return null;
    }

    private AjaxResult getCartCount(String userId) {
        if (StringUtils.isNotEmpty(userId)) {
            int count = orderCartService.countOrderCartByUserId(Integer.parseInt(userId));
            return AjaxResult.success("获取购物车数量成功", count);
        }
        return AjaxResult.error("获取购物车数量失败");
    }

    private TableDataInfo list(OrderCart orderCart) {
        List<OrderCart> cartList = orderCartService.selectOrderCartList(orderCart);
        if (cartList != null) {
            return TableDataInfo.getDataTable(cartList);
        }
        return null;
    }
}