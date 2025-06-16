package org.example.emarketmall.dao.impl;

import cquet.aibd.soft.ObjectUtil;
import org.example.emarketmall.dao.IDataAccess;
import org.example.emarketmall.dao.OrderDetailDao;
import org.example.emarketmall.entity.OrderDetail;
import org.example.emarketmall.utils.StringUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @Description: 订单详情数据访问实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class OrderDetailDaoImpl implements OrderDetailDao {

    private IDataAccess dac;

    public OrderDetailDaoImpl() {
        dac = new DataAccessImpl();
    }

    @Override
    public List<OrderDetail> selectOrderDetailList(OrderDetail orderDetail) throws Exception {
        // 如果orderDetail对象不为空，说明有查询条件
        if (orderDetail != null) {
            return selectOrderDetailByParams(orderDetail);
        }
        return dac.getList(OrderDetail.class);
    }

    /**
     * 通过orderDetail对象中包含的属性查询订单详情
     *
     * @param orderDetail
     * @return
     */
    private List<OrderDetail> selectOrderDetailByParams(OrderDetail orderDetail) throws Exception {
        List<OrderDetail> orderDetailList = new ArrayList<>();
        // 可查询的属性
        List<String> params = Arrays.asList("id", "orderId", "productId", "productName");

        for (String p : params) {
            switch (p) {
                case "id":
                    if (orderDetail.getId() != null) {
                        OrderDetail detail = selectOrderDetailById(orderDetail.getId());
                        if (detail != null) {
                            orderDetailList.add(detail);
                        }
                    }
                    break;
                case "orderId":
                    if (orderDetail.getOrderId() != null) {
                        List<OrderDetail> details = selectOrderDetailByOrderId(orderDetail.getOrderId());
                        if (details != null && !details.isEmpty()) {
                            orderDetailList.addAll(details);
                        }
                    }
                    break;
                case "productId":
                    if (orderDetail.getProductId() != null) {
                        List<OrderDetail> details = selectOrderDetailByProductId(orderDetail.getProductId());
                        if (details != null && !details.isEmpty()) {
                            orderDetailList.addAll(details);
                        }
                    }
                    break;
                case "productName":
                    if (StringUtils.isNotEmpty(orderDetail.getProductName())) {
                        List<OrderDetail> details = selectOrderDetailByProductName(orderDetail.getProductName());
                        if (details != null && !details.isEmpty()) {
                            orderDetailList.addAll(details);
                        }
                    }
                    break;
            }
        }
        return orderDetailList;
    }

    @Override
    public OrderDetail selectOrderDetailById(Integer orderDetailId) throws Exception {
        return dac.getEntityById(OrderDetail.class, orderDetailId);
    }

    @Override
    public List<OrderDetail> selectOrderDetailByOrderId(Integer orderId) {
        String sql = "select * from order_detail where order_id = ? and delFlag = 0";
        return new ObjectUtil<OrderDetail>().getList(sql, OrderDetail.class, orderId);
    }

    @Override
    public List<OrderDetail> selectOrderDetailByProductId(Integer productId) {
        String sql = "select * from order_detail where product_id = ? and delFlag = 0";
        return new ObjectUtil<OrderDetail>().getList(sql, OrderDetail.class, productId);
    }

    /**
     * 根据商品名称查询订单详情
     *
     * @param productName 商品名称
     * @return 订单详情列表
     */
    private List<OrderDetail> selectOrderDetailByProductName(String productName) {
        String sql = "select * from order_detail where product_name like ? and delFlag = 0";
        return new ObjectUtil<OrderDetail>().getList(sql, OrderDetail.class, "%" + productName + "%");
    }

    @Override
    public int insertOrderDetail(OrderDetail orderDetail) {
        String sql = "insert into order_detail(order_id, product_id, product_name, amount, product_price, " +
                "createdBy, createdTime, updatedBy, updatedTime, delFlag, remark) " +
                "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        if (orderDetail == null) {
            return 0;
        }
        
        return new ObjectUtil<OrderDetail>().add(sql,
                orderDetail.getOrderId(), orderDetail.getProductId(), orderDetail.getProductName(),
                orderDetail.getAmount(), orderDetail.getProductPrice(), orderDetail.getCreatedBy(),
                orderDetail.getCreatedTime(), orderDetail.getUpdatedBy(), orderDetail.getUpdatedTime(),
                orderDetail.getDelFlag(), orderDetail.getRemark());
    }

    @Override
    public int insertOrderDetailBatch(List<OrderDetail> orderDetails) {
        if (orderDetails == null || orderDetails.isEmpty()) {
            return 0;
        }
        
        int result = 0;
        for (OrderDetail orderDetail : orderDetails) {
            result += insertOrderDetail(orderDetail);
        }
        return result;
    }

    @Override
    public int updateOrderDetail(Integer orderDetailId, OrderDetail orderDetail) {
        if (orderDetail == null) {
            return 0;
        }
        
        String sql = "update order_detail set order_id=?, product_id=?, product_name=?, amount=?, " +
                "product_price=?, createdBy=?, createdTime=?, updatedBy=?, updatedTime=?, " +
                "delFlag=?, remark=? where id=?";
        
        return new ObjectUtil<OrderDetail>().update(sql,
                orderDetail.getOrderId(), orderDetail.getProductId(), orderDetail.getProductName(),
                orderDetail.getAmount(), orderDetail.getProductPrice(), orderDetail.getCreatedBy(),
                orderDetail.getCreatedTime(), orderDetail.getUpdatedBy(), orderDetail.getUpdatedTime(),
                orderDetail.getDelFlag(), orderDetail.getRemark(), orderDetailId);
    }

    @Override
    public int deleteOrderDetailById(Integer orderDetailId) {
        String sql = "update order_detail set delFlag = 1 where id = ?";
        return new ObjectUtil<OrderDetail>().update(sql, orderDetailId);
    }

    @Override
    public int deleteOrderDetailByOrderId(Integer orderId) {
        String sql = "update order_detail set delFlag = 1 where order_id = ?";
        return new ObjectUtil<OrderDetail>().update(sql, orderId);
    }

    @Override
    public int deleteOrderDetailByIds(Integer[] orderDetailIds) {
        if (orderDetailIds == null || orderDetailIds.length == 0) {
            return 0;
        }
        
        StringBuilder sql = new StringBuilder("update order_detail set delFlag = 1 where id in (");
        for (int i = 0; i < orderDetailIds.length; i++) {
            if (i > 0) {
                sql.append(",");
            }
            sql.append("?");
        }
        sql.append(")");
        
        return new ObjectUtil<OrderDetail>().update(sql.toString(), (Object[]) orderDetailIds);
    }
}