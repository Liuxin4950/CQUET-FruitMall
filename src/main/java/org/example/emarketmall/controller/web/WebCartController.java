package org.example.emarketmall.controller.web;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.entity.OrderCart;
import org.example.emarketmall.entity.UserInfo;
import org.example.emarketmall.req.CartReq;
import org.example.emarketmall.resl.CartResl;
import org.example.emarketmall.service.OrderCartService;
import org.example.emarketmall.service.impl.OrderCartServiceImpl;
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
 * @Description: Web端购物车控制器
 * @author: system
 * @date: 2024年12月19日
 */
@WebServlet("/web/cart/*")
public class WebCartController extends HttpServlet {
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
            case "/add":
                addToCart(req, resp, userInfo.getId());
                break;
            case "/list":
                getCartList(req, resp, userInfo.getId());
                break;
            case "/update":
                updateCart(req, resp, userInfo.getId());
                break;
            case "/delete":
                deleteFromCart(req, resp, userInfo.getId());
                break;
            case "/clear":
                clearCart(req, resp, userInfo.getId());
                break;
            case "/select":
                updateCartSelected(req, resp, userInfo.getId());
                break;
            case "/selectAll":
                selectAllCart(req, resp, userInfo.getId());
                break;
            case "/count":
                getCartCount(req, resp, userInfo.getId());
                break;
            default:
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("不支持的操作")));
                break;
        }
    }

    /**
     * 添加商品到购物车
     */
    private void addToCart(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            CartReq cartReq = ServletUtils.getObjectFromPayload(req, CartReq.class);
            if (cartReq == null || StringUtils.isEmpty(cartReq.getProductId()) || cartReq.getAmount() == null) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("参数异常")));
                return;
            }

            boolean result = orderCartService.addToCart(userId, cartReq.getProductId(), cartReq.getAmount(), 
                    cartReq.getPrice(), cartReq.getProductName(), cartReq.getProductPic());
            
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("添加成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("添加失败")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常")));
        }
    }

    /**
     * 获取购物车列表
     */
    private void getCartList(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            List<OrderCart> cartList = orderCartService.selectOrderCartByUserId(userId);
            List<CartResl> cartReslList = new ArrayList<>();
            
            for (OrderCart cart : cartList) {
                CartResl cartResl = new CartResl();
                cartResl.setId(cart.getId());
                cartResl.setProductId(cart.getProductId());
                cartResl.setProductName(cart.getProductName());
                cartResl.setAmount(cart.getAmount());
                cartResl.setPrice(cart.getPrice());
                cartResl.setSubtotal(cart.getPrice().multiply(new BigDecimal(cart.getAmount())));
                cartResl.setUserId(cart.getUserId());
                cartResl.setIsSelected(cart.getIsSelected());
                cartResl.setProductPic(cart.getProductPic());
                
                // 如果有关联的商品信息，可以设置更多字段
                if (cart.getProductInfo() != null) {
                    cartResl.setProductCode(cart.getProductInfo().getProductCode());
                    cartResl.setDescription(cart.getProductInfo().getDescription());
                    cartResl.setStock(cart.getProductInfo().getStock());
                    cartResl.setHasStock(cart.getProductInfo().getStock() >= cart.getAmount());
                }
                
                cartReslList.add(cartResl);
            }
            
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(cartReslList)));
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("获取购物车列表失败")));
        }
    }

    /**
     * 更新购物车商品数量
     */
    private void updateCart(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String cartIdStr = ServletUtils.getParamFromPayLoad(req, "cartId");
            String amountStr = ServletUtils.getParamFromPayLoad(req, "amount");
            
            if (StringUtils.isEmpty(cartIdStr) || StringUtils.isEmpty(amountStr)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("参数异常")));
                return;
            }
            
            Integer cartId = Integer.parseInt(cartIdStr);
            Integer amount = Integer.parseInt(amountStr);
            
            if (amount <= 0) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("商品数量必须大于0")));
                return;
            }
            
            // 验证购物车是否属于当前用户
            OrderCart cart = orderCartService.selectOrderCartById(cartId);
            if (cart == null || !cart.getUserId().equals(userId)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("购物车信息不存在")));
                return;
            }
            
            int result = orderCartService.updateOrderCartAmount(cartId, amount);
            if (result > 0) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("更新成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("更新失败")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常")));
        }
    }

    /**
     * 从购物车删除商品
     */
    private void deleteFromCart(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String cartIdStr = ServletUtils.getParamFromPayLoad(req, "cartId");
            
            if (StringUtils.isEmpty(cartIdStr)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("参数异常")));
                return;
            }
            
            Integer cartId = Integer.parseInt(cartIdStr);
            
            // 验证购物车是否属于当前用户
            OrderCart cart = orderCartService.selectOrderCartById(cartId);
            if (cart == null || !cart.getUserId().equals(userId)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("购物车信息不存在")));
                return;
            }
            
            int result = orderCartService.deleteOrderCartById(cartId);
            if (result > 0) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("删除成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("删除失败")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常")));
        }
    }

    /**
     * 清空购物车
     */
    private void clearCart(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            int result = orderCartService.deleteOrderCartByUserId(userId);
            if (result > 0) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("清空成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("清空失败")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常")));
        }
    }

    /**
     * 更新购物车选中状态
     */
    private void updateCartSelected(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String cartIdStr = ServletUtils.getParamFromPayLoad(req, "cartId");
            String selectedStr = ServletUtils.getParamFromPayLoad(req, "selected");
            
            if (StringUtils.isEmpty(cartIdStr) || StringUtils.isEmpty(selectedStr)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("参数异常")));
                return;
            }
            
            Integer cartId = Integer.parseInt(cartIdStr);
            Boolean selected = Boolean.parseBoolean(selectedStr);
            
            // 验证购物车是否属于当前用户
            OrderCart cart = orderCartService.selectOrderCartById(cartId);
            if (cart == null || !cart.getUserId().equals(userId)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("购物车信息不存在")));
                return;
            }
            
            int result = orderCartService.updateOrderCartSelected(cartId, selected);
            if (result > 0) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("更新成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("更新失败")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常")));
        }
    }

    /**
     * 全选/取消全选购物车
     */
    private void selectAllCart(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String selectedStr = ServletUtils.getParamFromPayLoad(req, "selected");
            
            if (StringUtils.isEmpty(selectedStr)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("参数异常")));
                return;
            }
            
            Boolean selected = Boolean.parseBoolean(selectedStr);
            
            int result = orderCartService.updateOrderCartSelectedBatch(userId, selected);
            if (result > 0) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("更新成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("更新失败")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常")));
        }
    }

    /**
     * 获取购物车商品数量
     */
    private void getCartCount(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            int count = orderCartService.countOrderCartByUserId(userId);
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(count)));
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("获取购物车数量失败")));
        }
    }
}