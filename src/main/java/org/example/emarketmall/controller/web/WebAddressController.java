package org.example.emarketmall.controller.web;

import com.alibaba.fastjson.JSON;
import org.example.emarketmall.common.AjaxResult;
import org.example.emarketmall.entity.DeliveryAddress;
import org.example.emarketmall.entity.UserInfo;
import org.example.emarketmall.service.DeliveryAddressService;
import org.example.emarketmall.service.impl.DeliveryAddressServiceImpl;
import org.example.emarketmall.utils.ServletUtils;
import org.example.emarketmall.utils.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * @Description: Web端收货地址控制器
 * @author: 若若
 * @date: 2024年12月19日
 */
@WebServlet("/web/address")
public class WebAddressController extends HttpServlet {
    
    private DeliveryAddressService deliveryAddressService = new DeliveryAddressServiceImpl();
    
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
        
        String opt = req.getParameter("opt");
        
        System.out.println("WebAddressController - opt: " + opt);
        
        if (StringUtils.isEmpty(opt)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("操作选项opt内容异常")));
            return;
        }
        
        try {
            switch (opt) {
                case "list":
                    // 查询用户收货地址列表
                    handleAddressList(req, resp);
                    break;
                case "detail":
                    // 查询地址详情
                    handleAddressDetail(req, resp);
                    break;
                case "add":
                    // 新增收货地址
                    handleAddAddress(req, resp);
                    break;
                case "update":
                    // 更新收货地址
                    handleUpdateAddress(req, resp);
                    break;
                case "delete":
                    // 删除收货地址
                    handleDeleteAddress(req, resp);
                    break;
                case "setDefault":
                    // 设置默认地址
                    handleSetDefaultAddress(req, resp);
                    break;
                case "getDefault":
                    // 获取默认地址
                    handleGetDefaultAddress(req, resp);
                    break;
                default:
                    ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("不支持的操作类型: " + opt)));
                    break;
            }
        } catch (Exception e) {
            System.err.println("WebAddressController处理请求时发生错误: " + e.getMessage());
            e.printStackTrace();
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("服务器内部错误: " + e.getMessage())));
        }
    }
    
    /**
     * 处理查询用户收货地址列表
     */
    private void handleAddressList(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // 检查用户是否登录
        HttpSession session = req.getSession();
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        
        if (userInfo == null) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户未登录")));
            return;
        }
        
        try {
            Integer Id = Integer.parseInt(userInfo.getId().toString());
            List<DeliveryAddress> addressList = deliveryAddressService.selectAddressByUserId(Id);
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("查询成功", addressList)));
        } catch (NumberFormatException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户ID格式不正确")));
        }
    }
    
    /**
     * 处理查询地址详情
     */
    private void handleAddressDetail(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String idStr = req.getParameter("id");
        
        if (StringUtils.isEmpty(idStr)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("地址ID不能为空")));
            return;
        }
        
        try {
            Integer id = Integer.parseInt(idStr);
            DeliveryAddress address = deliveryAddressService.selectAddressById(id);
            
            if (address == null) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("地址不存在")));
                return;
            }
            
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("查询成功", address)));
        } catch (NumberFormatException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("地址ID格式不正确")));
        }
    }
    
    /**
     * 处理新增收货地址
     */
    private void handleAddAddress(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // 检查用户是否登录
        HttpSession session = req.getSession();
        Object userIdObj = session.getAttribute("userId");
        
        if (userIdObj == null) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户未登录")));
            return;
        }
        
        try {
            Integer userId = Integer.parseInt(userIdObj.toString());
            
            // 从请求中获取地址信息
            String receiverName = req.getParameter("receiverName");
            String phone = req.getParameter("phone");
            String province = req.getParameter("province");
            String city = req.getParameter("city");
            String district = req.getParameter("district");
            String detailAddress = req.getParameter("detailAddress");
            String isDefaultStr = req.getParameter("isDefault");
            
            DeliveryAddress address = new DeliveryAddress();
            address.setUserId(userId);
            address.setReceiverName(receiverName);
            address.setPhone(phone);
            address.setProvince(province);
            address.setCity(city);
            address.setDistrict(district);
            address.setDetailAddress(detailAddress);
            address.setIsDefault("1".equals(isDefaultStr) || "true".equals(isDefaultStr));
            
            boolean result = deliveryAddressService.insertAddress(address);
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("新增地址成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("新增地址失败")));
            }
        } catch (NumberFormatException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户ID格式不正确")));
        }
    }
    
    /**
     * 处理更新收货地址
     */
    private void handleUpdateAddress(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // 检查用户是否登录
        HttpSession session = req.getSession();
        Object userIdObj = session.getAttribute("userId");
        
        if (userIdObj == null) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户未登录")));
            return;
        }
        
        String idStr = req.getParameter("id");
        if (StringUtils.isEmpty(idStr)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("地址ID不能为空")));
            return;
        }
        
        try {
            Integer userId = Integer.parseInt(userIdObj.toString());
            Integer id = Integer.parseInt(idStr);
            
            // 从请求中获取地址信息
            String receiverName = req.getParameter("receiverName");
            String phone = req.getParameter("phone");
            String province = req.getParameter("province");
            String city = req.getParameter("city");
            String district = req.getParameter("district");
            String detailAddress = req.getParameter("detailAddress");
            String isDefaultStr = req.getParameter("isDefault");
            
            DeliveryAddress address = new DeliveryAddress();
            address.setId(id);
            address.setUserId(userId);
            address.setReceiverName(receiverName);
            address.setPhone(phone);
            address.setProvince(province);
            address.setCity(city);
            address.setDistrict(district);
            address.setDetailAddress(detailAddress);
            address.setIsDefault("1".equals(isDefaultStr) || "true".equals(isDefaultStr));
            
            boolean result = deliveryAddressService.updateAddress(address);
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("更新地址成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("更新地址失败")));
            }
        } catch (NumberFormatException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("ID格式不正确")));
        }
    }
    
    /**
     * 处理删除收货地址
     */
    private void handleDeleteAddress(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // 检查用户是否登录
        HttpSession session = req.getSession();
        Object userIdObj = session.getAttribute("userId");
        
        if (userIdObj == null) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户未登录")));
            return;
        }
        
        String idStr = req.getParameter("id");
        if (StringUtils.isEmpty(idStr)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("地址ID不能为空")));
            return;
        }
        
        try {
            Integer userId = Integer.parseInt(userIdObj.toString());
            Integer id = Integer.parseInt(idStr);
            
            boolean result = deliveryAddressService.deleteAddress(id, userId);
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("删除地址成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("删除地址失败")));
            }
        } catch (NumberFormatException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("ID格式不正确")));
        }
    }
    
    /**
     * 处理设置默认地址
     */
    private void handleSetDefaultAddress(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // 检查用户是否登录
        HttpSession session = req.getSession();
        Object userIdObj = session.getAttribute("userId");
        
        if (userIdObj == null) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户未登录")));
            return;
        }
        
        String idStr = req.getParameter("id");
        if (StringUtils.isEmpty(idStr)) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("地址ID不能为空")));
            return;
        }
        
        try {
            Integer userId = Integer.parseInt(userIdObj.toString());
            Integer id = Integer.parseInt(idStr);
            
            boolean result = deliveryAddressService.setDefaultAddress(id, userId);
            if (result) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("设置默认地址成功")));
            } else {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("设置默认地址失败")));
            }
        } catch (NumberFormatException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("ID格式不正确")));
        }
    }
    
    /**
     * 处理获取默认地址
     */
    private void handleGetDefaultAddress(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // 检查用户是否登录
        HttpSession session = req.getSession();
        Object userIdObj = session.getAttribute("userId");
        
        if (userIdObj == null) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户未登录")));
            return;
        }
        
        try {
            Integer userId = Integer.parseInt(userIdObj.toString());
            DeliveryAddress defaultAddress = deliveryAddressService.selectDefaultAddressByUserId(userId);
            
            if (defaultAddress == null) {
                ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("暂无默认地址")));
                return;
            }
            
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.success("查询成功", defaultAddress)));
        } catch (NumberFormatException e) {
            ServletUtils.renderString(resp, JSON.toJSONString(AjaxResult.error("用户ID格式不正确")));
        }
    }
}