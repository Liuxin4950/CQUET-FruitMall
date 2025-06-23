package org.example.emarketmall.controller.web;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.entity.OrderCart;
import org.example.emarketmall.entity.ProductInfo;
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
     * 支持两种方式：
     * 1. 完整参数：productId, amount, price, productName, productPic
     * 2. 简化参数：只需要productId和amount，其他信息自动从商品表获取
     */
    private void addToCart(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            // 尝试获取完整的CartReq对象
            CartReq cartReq = ServletUtils.getObjectFromPayload(req, CartReq.class);
            
            // 如果没有完整对象，尝试获取简化参数
            if (cartReq == null) {
                String productId = ServletUtils.getParamFromPayLoad(req, "productId");
                String amountStr = ServletUtils.getParamFromPayLoad(req, "amount");
                
                if (StringUtils.isEmpty(productId) || StringUtils.isEmpty(amountStr)) {
                    ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("参数异常：需要productId和amount")));
                    return;
                }
                
                try {
                    Integer amount = Integer.parseInt(amountStr);
                    if (amount <= 0) {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("商品数量必须大于0")));
                        return;
                    }
                    
                    // 使用简化版本的addToCart方法
                    boolean result = orderCartService.addToCart(userId, productId, amount);
                    
                    if (result) {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("添加成功")));
                    } else {
                        ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("添加失败，请检查商品是否存在")));
                    }
                } catch (NumberFormatException e) {
                    ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("数量格式错误")));
                }
                return;
            }
            
            // 验证完整参数
            if (StringUtils.isEmpty(cartReq.getProductId()) || cartReq.getAmount() == null) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("参数异常：productId和amount不能为空")));
                return;
            }
            
            if (cartReq.getAmount() <= 0) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("商品数量必须大于0")));
                return;
            }
            
            boolean result;
            // 如果有完整的商品信息，使用完整版本的addToCart
            if (cartReq.getPrice() != null && !StringUtils.isEmpty(cartReq.getProductName())) {
                result = orderCartService.addToCart(userId, cartReq.getProductId(), cartReq.getAmount(), 
                        cartReq.getPrice(), cartReq.getProductName(), cartReq.getProductPic());
            } else {
                // 否则使用简化版本，自动获取商品信息
                result = orderCartService.addToCart(userId, cartReq.getProductId(), cartReq.getAmount());
            }
            
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("添加成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("添加失败，请检查商品是否存在")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("系统异常")));
        }
    }

    /**
     * 获取购物车列表
     * 返回用户的购物车商品列表，包含商品详细信息、库存状态、价格统计等
     */
    public void getCartList(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            List<OrderCart> cartList = orderCartService.selectOrderCartByUserId(userId);
            List<CartResl> cartReslList = new ArrayList<>();
            
            // 统计信息
            BigDecimal totalAmount = BigDecimal.ZERO;  // 总金额
            BigDecimal selectedAmount = BigDecimal.ZERO;  // 选中商品总金额
            int totalCount = 0;  // 总商品数量
            int selectedCount = 0;  // 选中商品数量
            boolean allSelected = true;  // 是否全选
            
            if (cartList != null && !cartList.isEmpty()) {
                for (OrderCart cart : cartList) {
                    CartResl cartResl = new CartResl();
                    cartResl.setId(cart.getId());
                    cartResl.setProductId(cart.getProductId());
                    cartResl.setProductName(cart.getProductName());
                    cartResl.setAmount(cart.getAmount());
                    cartResl.setPrice(cart.getPrice());
                    
                    // 计算小计
                    BigDecimal subtotal = cart.getPrice().multiply(new BigDecimal(cart.getAmount()));
                    cartResl.setSubtotal(subtotal);
                    
                    cartResl.setUserId(cart.getUserId());
                    cartResl.setIsSelected(cart.getIsSelected() != null ? cart.getIsSelected() : false);
                    cartResl.setProductPic(cart.getProductPic());
                    
                    // 如果有关联的商品信息，设置更多字段
                    if (cart.getProductInfo() != null) {
                        ProductInfo productInfo = cart.getProductInfo();
                        cartResl.setProductCode(productInfo.getProductCode());
                        cartResl.setDescription(productInfo.getDescription());
                        cartResl.setStock(productInfo.getStock());
                        cartResl.setHasStock(productInfo.getStock() != null && productInfo.getStock() >= cart.getAmount());
                        cartResl.setWeightUnit(productInfo.getWeightUnit());
                        cartResl.setOriginPlace(productInfo.getOriginPlace());
                        
                        // 如果购物车中的商品信息不完整，使用商品表中的信息补充
                        if (StringUtils.isEmpty(cart.getProductName()) && !StringUtils.isEmpty(productInfo.getProductName())) {
                            cartResl.setProductName(productInfo.getProductName());
                        }
                        if (StringUtils.isEmpty(cart.getProductPic()) && !StringUtils.isEmpty(productInfo.getImageUrl())) {
                            cartResl.setProductPic(productInfo.getImageUrl());
                        }
                    } else {
                        // 如果没有关联商品信息，设置默认值
                        cartResl.setHasStock(true);  // 默认有库存
                    }
                    
                    // 统计计算
                    totalAmount = totalAmount.add(subtotal);
                    totalCount += cart.getAmount();
                    
                    if (cartResl.getIsSelected()) {
                        selectedAmount = selectedAmount.add(subtotal);
                        selectedCount += cart.getAmount();
                    } else {
                        allSelected = false;
                    }
                    
                    cartReslList.add(cartResl);
                }
            } else {
                allSelected = false;  // 空购物车不算全选
            }
            
            // 构建返回结果，包含列表和统计信息
            java.util.Map<String, Object> result = new java.util.HashMap<>();
            result.put("cartList", cartReslList);
            
            // 构建统计信息
            java.util.Map<String, Object> summary = new java.util.HashMap<>();
            summary.put("totalAmount", totalAmount);  // 总金额
            summary.put("selectedAmount", selectedAmount);  // 选中商品总金额
            summary.put("totalCount", totalCount);  // 总商品数量
            summary.put("selectedCount", selectedCount);  // 选中商品数量
            summary.put("cartSize", cartList != null ? cartList.size() : 0);  // 购物车商品种类数
            summary.put("allSelected", allSelected);  // 是否全选
            summary.put("isEmpty", cartList == null || cartList.isEmpty());  // 是否为空
            
            result.put("summary", summary);
            
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success(result)));
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("获取购物车列表失败: " + e.getMessage())));
        }
    }

    /**
     * 更新购物车商品数量
     */
    private void updateCart(HttpServletRequest req, HttpServletResponse resp, Integer userId) throws IOException {
        try {
            String cartIdStr = ServletUtils.getParamFromPayLoad(req, "cartId");
            String amountStr = ServletUtils.getParamFromPayLoad(req, "amount");
            System.out.println("更新购物车商品，cartId: " + cartIdStr + ", amount: " + amountStr);
            
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
            System.out.println("查询到的购物车信息: " + cart);
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
            System.out.println("删除购物车商品，cartId: " + cartIdStr);
            if (StringUtils.isEmpty(cartIdStr)) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("参数异常")));
                return;
            }
            
            Integer cartId = Integer.parseInt(cartIdStr);
            
            // 验证购物车是否属于当前用户
            OrderCart cart = orderCartService.selectOrderCartById(cartId);
            System.out.println("查询到的购物车信息: " + cart);
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