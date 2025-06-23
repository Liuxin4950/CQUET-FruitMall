package org.example.emarketmall.dao.impl;

import cquet.aibd.soft.ObjectUtil;
import org.example.emarketmall.dao.DeliveryAddressDao;
import org.example.emarketmall.entity.DeliveryAddress;
import org.example.emarketmall.utils.DateUtils;

import java.util.List;

/**
 * @Description: 收货地址DAO实现类
 * @author: 若若
 * @date: 2024年12月19日
 */
public class DeliveryAddressDaoImpl implements DeliveryAddressDao {
    
    @Override
    public List<DeliveryAddress> selectAddressByUserId(Integer userId) throws Exception {
        String sql = "SELECT id, user_id as userId, receiver_name as receiverName, phone, " +
                     "province, city, district, detail_address as detailAddress, " +
                     "is_default as isDefault, createdTime, updatedTime, remark " +
                     "FROM delivery_address WHERE user_id = ? AND delFlag = 0 " +
                     "ORDER BY is_default DESC, createdTime DESC";
        
        return new ObjectUtil<DeliveryAddress>().getList(sql, DeliveryAddress.class, userId);
    }
    
    @Override
    public DeliveryAddress selectAddressById(Integer id) throws Exception {
        String sql = "SELECT id, user_id as userId, receiver_name as receiverName, phone, " +
                     "province, city, district, detail_address as detailAddress, " +
                     "is_default as isDefault, createdTime, updatedTime, remark " +
                     "FROM delivery_address WHERE id = ? AND delFlag = 0";
        
        return new ObjectUtil<DeliveryAddress>().getOne(sql, DeliveryAddress.class, id);
    }
    
    @Override
    public DeliveryAddress selectDefaultAddressByUserId(Integer userId) throws Exception {
        String sql = "SELECT id, user_id as userId, receiver_name as receiverName, phone, " +
                     "province, city, district, detail_address as detailAddress, " +
                     "is_default as isDefault, createdTime, updatedTime, remark " +
                     "FROM delivery_address WHERE user_id = ? AND is_default = 1 AND delFlag = 0";
        
        return new ObjectUtil<DeliveryAddress>().getOne(sql, DeliveryAddress.class, userId);
    }
    
    @Override
    public int insertAddress(DeliveryAddress address) throws Exception {
        String sql = "INSERT INTO delivery_address (user_id, receiver_name, phone, province, " +
                     "city, district, detail_address, is_default, delFlag, createdBy, " +
                     "createdTime, updatedTime, remark) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0, 'user', ?, ?, ?)";
        
        String currentTime = DateUtils.getTime();
        
        return new ObjectUtil<DeliveryAddress>().add(sql,
                address.getUserId(),
                address.getReceiverName(),
                address.getPhone(),
                address.getProvince(),
                address.getCity(),
                address.getDistrict(),
                address.getDetailAddress(),
                address.getIsDefault() ? 1 : 0,
                currentTime,
                currentTime,
                address.getRemark());
    }
    
    @Override
    public int updateAddress(DeliveryAddress address) throws Exception {
        String sql = "UPDATE delivery_address SET receiver_name = ?, phone = ?, province = ?, " +
                     "city = ?, district = ?, detail_address = ?, is_default = ?, " +
                     "updatedTime = ?, remark = ? " +
                     "WHERE id = ? AND delFlag = 0";
        
        return new ObjectUtil<DeliveryAddress>().update(sql,
                address.getReceiverName(),
                address.getPhone(),
                address.getProvince(),
                address.getCity(),
                address.getDistrict(),
                address.getDetailAddress(),
                address.getIsDefault() ? 1 : 0,
                DateUtils.getTime(),
                address.getRemark(),
                address.getId());
    }
    
    @Override
    public int deleteAddress(Integer id) throws Exception {
        String sql = "UPDATE delivery_address SET delFlag = 1, updatedTime = ? WHERE id = ?";
        return new ObjectUtil<DeliveryAddress>().delete(sql, DateUtils.getTime(), id);
    }
    
    @Override
    public int clearDefaultAddress(Integer userId) throws Exception {
        String sql = "UPDATE delivery_address SET is_default = 0, updatedTime = ? " +
                     "WHERE user_id = ? AND delFlag = 0";
        return new ObjectUtil<DeliveryAddress>().update(sql, DateUtils.getTime(), userId);
    }
    
    @Override
    public int setDefaultAddress(Integer id) throws Exception {
        String sql = "UPDATE delivery_address SET is_default = 1, updatedTime = ? " +
                     "WHERE id = ? AND delFlag = 0";
        return new ObjectUtil<DeliveryAddress>().update(sql, DateUtils.getTime(), id);
    }
    
    @Override
    public boolean validateAddressOwnership(Integer id, Integer userId) throws Exception {
        String sql = "SELECT COUNT(*) as count FROM delivery_address " +
                     "WHERE id = ? AND user_id = ? AND delFlag = 0";
        
        Integer count = new ObjectUtil<Integer>().getOne(sql, Integer.class, id, userId);
        return count != null && count > 0;
    }
}