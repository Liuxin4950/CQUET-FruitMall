package org.example.emarketmall.dao.impl;

import cquet.aibd.soft.ObjectUtil;
import org.example.emarketmall.dao.IDataAccess;
import org.example.emarketmall.dao.OrderCartDao;
import org.example.emarketmall.entity.OrderCart;
import org.example.emarketmall.utils.StringUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @Description: 购物车数据访问实现类
 * @author: system
 * @date: 2024年12月19日
 */
public class OrderCartDaoImpl implements OrderCartDao {

    private IDataAccess dac;

    public OrderCartDaoImpl() {
        dac = new DataAccessImpl();
    }

    @Override
    public List<OrderCart> selectOrderCartList(OrderCart orderCart) throws Exception {
        // 如果orderCart对象不为空，说明有查询条件
        if (orderCart != null) {
            return selectOrderCartByParams(orderCart);
        }
        return dac.getList(OrderCart.class);
    }

    /**
     * 通过orderCart对象中包含的属性查询购物车
     *
     * @param orderCart
     * @return
     */
    private List<OrderCart> selectOrderCartByParams(OrderCart orderCart) throws Exception {
        List<OrderCart> orderCartList = new ArrayList<>();
        // 可查询的属性
        List<String> params = Arrays.asList("id", "userId", "productId", "productName", "isSelected");

        for (String p : params) {
            switch (p) {
                case "id":
                    if (orderCart.getId() != null) {
                        OrderCart cart = selectOrderCartById(orderCart.getId());
                        if (cart != null) {
                            orderCartList.add(cart);
                        }
                    }
                    break;
                case "userId":
                    if (orderCart.getUserId() != null) {
                        List<OrderCart> carts = selectOrderCartByUserId(orderCart.getUserId());
                        if (carts != null && !carts.isEmpty()) {
                            orderCartList.addAll(carts);
                        }
                    }
                    break;
                case "productId":
                    if (StringUtils.isNotEmpty(orderCart.getProductId())) {
                        List<OrderCart> carts = selectOrderCartByProductId(orderCart.getProductId());
                        if (carts != null && !carts.isEmpty()) {
                            orderCartList.addAll(carts);
                        }
                    }
                    break;
                case "productName":
                    if (StringUtils.isNotEmpty(orderCart.getProductName())) {
                        List<OrderCart> carts = selectOrderCartByProductName(orderCart.getProductName());
                        if (carts != null && !carts.isEmpty()) {
                            orderCartList.addAll(carts);
                        }
                    }
                    break;
                case "isSelected":
                    if (orderCart.getIsSelected() != null && orderCart.getUserId() != null) {
                        List<OrderCart> carts = selectOrderCartByUserIdAndSelected(orderCart.getUserId(), orderCart.getIsSelected());
                        if (carts != null && !carts.isEmpty()) {
                            orderCartList.addAll(carts);
                        }
                    }
                    break;
            }
        }
        return orderCartList;
    }

    @Override
    public OrderCart selectOrderCartById(Integer cartId) throws Exception {
        String sql = "select id, product_id as productId, amount, price, user_id as userId, is_selected as isSelected, " +
                     "product_name as productName, product_pic as productPic, delFlag, createdBy, createdTime, " +
                     "updatedBy, updatedTime, remark from order_cart where id = ? and delFlag = 0";
        return new ObjectUtil<OrderCart>().getOne(sql, OrderCart.class, cartId);
    }

    @Override
    public List<OrderCart> selectOrderCartByUserId(Integer userId) {
        String sql = "select id, product_id as productId, amount, price, user_id as userId, is_selected as isSelected, " +
                     "product_name as productName, product_pic as productPic, delFlag, createdBy, createdTime, " +
                     "updatedBy, updatedTime, remark from order_cart where user_id = ? and delFlag = 0 order by createdTime desc";
        return new ObjectUtil<OrderCart>().getList(sql, OrderCart.class, userId);
    }

    @Override
    public OrderCart selectOrderCartByUserIdAndProductId(Integer userId, String productId) {
        String sql = "select id, product_id as productId, amount, price, user_id as userId, is_selected as isSelected, " +
                     "product_name as productName, product_pic as productPic, delFlag, createdBy, createdTime, " +
                     "updatedBy, updatedTime, remark from order_cart where user_id = ? and product_id = ? and delFlag = 0";
        return new ObjectUtil<OrderCart>().getOne(sql, OrderCart.class, userId, productId);
    }

    @Override
    public List<OrderCart> selectSelectedOrderCartByUserId(Integer userId) {
        String sql = "select id, product_id as productId, amount, price, user_id as userId, is_selected as isSelected, " +
                     "product_name as productName, product_pic as productPic, delFlag, createdBy, createdTime, " +
                     "updatedBy, updatedTime, remark from order_cart where user_id = ? and is_selected = 1 and delFlag = 0";
        return new ObjectUtil<OrderCart>().getList(sql, OrderCart.class, userId);
    }

    /**
     * 根据商品ID查询购物车
     *
     * @param productId 商品ID
     * @return 购物车列表
     */
    private List<OrderCart> selectOrderCartByProductId(String productId) {
        String sql = "select id, product_id as productId, amount, price, user_id as userId, is_selected as isSelected, " +
                     "product_name as productName, product_pic as productPic, delFlag, createdBy, createdTime, " +
                     "updatedBy, updatedTime, remark from order_cart where product_id = ? and delFlag = 0";
        return new ObjectUtil<OrderCart>().getList(sql, OrderCart.class, productId);
    }

    /**
     * 根据商品名称查询购物车
     *
     * @param productName 商品名称
     * @return 购物车列表
     */
    private List<OrderCart> selectOrderCartByProductName(String productName) {
        String sql = "select id, product_id as productId, amount, price, user_id as userId, is_selected as isSelected, " +
                     "product_name as productName, product_pic as productPic, delFlag, createdBy, createdTime, " +
                     "updatedBy, updatedTime, remark from order_cart where product_name like ? and delFlag = 0";
        return new ObjectUtil<OrderCart>().getList(sql, OrderCart.class, "%" + productName + "%");
    }

    /**
     * 根据用户ID和选中状态查询购物车
     *
     * @param userId 用户ID
     * @param isSelected 是否选中
     * @return 购物车列表
     */
    private List<OrderCart> selectOrderCartByUserIdAndSelected(Integer userId, Boolean isSelected) {
        String sql = "select id, product_id as productId, amount, price, user_id as userId, is_selected as isSelected, " +
                     "product_name as productName, product_pic as productPic, delFlag, createdBy, createdTime, " +
                     "updatedBy, updatedTime, remark from order_cart where user_id = ? and is_selected = ? and delFlag = 0";
        return new ObjectUtil<OrderCart>().getList(sql, OrderCart.class, userId, isSelected ? 1 : 0);
    }

    @Override
    public int insertOrderCart(OrderCart orderCart) {
        String sql = "insert into order_cart(product_id, amount, price, user_id, is_selected, " +
                "product_name, product_pic, createdBy, createdTime, updatedBy, updatedTime, delFlag, remark) " +
                "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        if (orderCart == null) {
            return 0;
        }
        
        return new ObjectUtil<OrderCart>().add(sql,
                orderCart.getProductId(), orderCart.getAmount(), orderCart.getPrice(),
                orderCart.getUserId(), orderCart.getIsSelected() ? 1 : 0, orderCart.getProductName(),
                orderCart.getProductPic(), orderCart.getCreatedBy(), orderCart.getCreatedTime(),
                orderCart.getUpdatedBy(), orderCart.getUpdatedTime(), orderCart.getDelFlag(),
                orderCart.getRemark());
    }

    @Override
    public int updateOrderCart(Integer cartId, OrderCart orderCart) {
        if (orderCart == null) {
            return 0;
        }
        
        String sql = "update order_cart set product_id=?, amount=?, price=?, user_id=?, is_selected=?, " +
                "product_name=?, product_pic=?, createdBy=?, createdTime=?, updatedBy=?, updatedTime=?, " +
                "delFlag=?, remark=? where id=?";
        
        return new ObjectUtil<OrderCart>().update(sql,
                orderCart.getProductId(), orderCart.getAmount(), orderCart.getPrice(),
                orderCart.getUserId(), orderCart.getIsSelected() ? 1 : 0, orderCart.getProductName(),
                orderCart.getProductPic(), orderCart.getCreatedBy(), orderCart.getCreatedTime(),
                orderCart.getUpdatedBy(), orderCart.getUpdatedTime(), orderCart.getDelFlag(),
                orderCart.getRemark(), cartId);
    }

    @Override
    public int updateOrderCartAmount(Integer cartId, Integer amount) {
        String sql = "update order_cart set amount = ?, updatedTime = now() where id = ?";
        return new ObjectUtil<OrderCart>().update(sql, amount, cartId);
    }

    @Override
    public int updateOrderCartSelected(Integer cartId, Boolean isSelected) {
        String sql = "update order_cart set is_selected = ?, updatedTime = now() where id = ?";
        return new ObjectUtil<OrderCart>().update(sql, isSelected ? 1 : 0, cartId);
    }

    @Override
    public int updateOrderCartSelectedByUserId(Integer userId, Boolean isSelected) {
        String sql = "update order_cart set is_selected = ?, updatedTime = now() where user_id = ? and delFlag = 0";
        return new ObjectUtil<OrderCart>().update(sql, isSelected ? 1 : 0, userId);
    }

    @Override
    public int deleteOrderCartById(Integer cartId) {
        String sql = "update order_cart set delFlag = 1 where id = ?";
        return new ObjectUtil<OrderCart>().update(sql, cartId);
    }

    @Override
    public int deleteOrderCartByUserId(Integer userId) {
        String sql = "update order_cart set delFlag = 1 where user_id = ?";
        return new ObjectUtil<OrderCart>().update(sql, userId);
    }

    @Override
    public int deleteSelectedOrderCartByUserId(Integer userId) {
        String sql = "update order_cart set delFlag = 1 where user_id = ? and is_selected = 1";
        return new ObjectUtil<OrderCart>().update(sql, userId);
    }

    @Override
    public int deleteOrderCartByIds(Integer[] cartIds) {
        if (cartIds == null || cartIds.length == 0) {
            return 0;
        }
        
        StringBuilder sql = new StringBuilder("update order_cart set delFlag = 1 where id in (");
        for (int i = 0; i < cartIds.length; i++) {
            if (i > 0) {
                sql.append(",");
            }
            sql.append("?");
        }
        sql.append(")");
        
        return new ObjectUtil<OrderCart>().update(sql.toString(), (Object[]) cartIds);
    }

    @Override
    public int countOrderCartByUserId(Integer userId) {
        String sql = "select count(*) from order_cart where user_id = ? and delFlag = 0";
        List<Integer> result = new ObjectUtil<Integer>().getList(sql, Integer.class, userId);
        return result.isEmpty() ? 0 : result.get(0);
    }
}