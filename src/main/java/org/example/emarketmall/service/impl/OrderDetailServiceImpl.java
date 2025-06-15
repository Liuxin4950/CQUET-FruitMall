package org.example.emarketmall.service.impl;

import org.example.emarketmall.dao.OrderDetailDao;
import org.example.emarketmall.dao.impl.OrderDetailDaoImpl;
import org.example.emarketmall.entity.OrderDetail;
import org.example.emarketmall.service.OrderDetailService;
import org.example.emarketmall.utils.DateUtils;
import org.example.emarketmall.utils.StringUtils;

import java.util.List;

/**
 * @Description: 订单详情服务实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class OrderDetailServiceImpl implements OrderDetailService {
    private OrderDetailDao orderDetailDao;

    public OrderDetailServiceImpl() {
        orderDetailDao = new OrderDetailDaoImpl();
    }

    @Override
    public List<OrderDetail> selectOrderDetailList(OrderDetail orderDetail) {
        try {
            return orderDetailDao.selectOrderDetailList(orderDetail);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public OrderDetail selectOrderDetailById(Integer orderDetailId) {
        try {
            return orderDetailDao.selectOrderDetailById(orderDetailId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<OrderDetail> selectOrderDetailByOrderId(Integer orderId) {
        try {
            return orderDetailDao.selectOrderDetailByOrderId(orderId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<OrderDetail> selectOrderDetailByProductId(Integer productId) {
        try {
            return orderDetailDao.selectOrderDetailByProductId(productId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int insertOrderDetail(OrderDetail orderDetail) {
        if (StringUtils.isEmpty(orderDetail.getCreatedBy())) {
            orderDetail.setCreatedBy("admin");
        }
        if (orderDetail.getCreatedTime() == null) {
            orderDetail.setCreatedTime(DateUtils.getTime());
        }
        if (orderDetail.getUpdatedTime() == null) {
            orderDetail.setUpdatedTime(DateUtils.getTime());
        }
        return orderDetailDao.insertOrderDetail(orderDetail);
    }

    @Override
    public int insertOrderDetailBatch(List<OrderDetail> orderDetailList) {
        if (orderDetailList == null || orderDetailList.isEmpty()) {
            return 0;
        }
        
        int result = 0;
        for (OrderDetail orderDetail : orderDetailList) {
            if (StringUtils.isEmpty(orderDetail.getCreatedBy())) {
                orderDetail.setCreatedBy("admin");
            }
            if (orderDetail.getCreatedTime() == null) {
                orderDetail.setCreatedTime(DateUtils.getTime());
            }
            if (orderDetail.getUpdatedTime() == null) {
                orderDetail.setUpdatedTime(DateUtils.getTime());
            }
            result += orderDetailDao.insertOrderDetail(orderDetail);
        }
        return result;
    }

    @Override
    public int updateOrderDetail(OrderDetail orderDetail) {
        Integer id = orderDetail.getId();
        orderDetail.setUpdatedTime(DateUtils.getTime());
        return orderDetailDao.updateOrderDetail(id, orderDetail);
    }

    @Override
    public int deleteOrderDetailByIds(Integer[] orderDetailIds) {
        return orderDetailDao.deleteOrderDetailByIds(orderDetailIds);
    }

    @Override
    public int deleteOrderDetailById(Integer orderDetailId) {
        return orderDetailDao.deleteOrderDetailById(orderDetailId);
    }

    @Override
    public int deleteOrderDetailByOrderId(Integer orderId) {
        return orderDetailDao.deleteOrderDetailByOrderId(orderId);
    }
}