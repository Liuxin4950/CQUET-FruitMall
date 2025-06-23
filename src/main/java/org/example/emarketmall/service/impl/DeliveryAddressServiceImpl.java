package org.example.emarketmall.service.impl;

import org.example.emarketmall.dao.DeliveryAddressDao;
import org.example.emarketmall.dao.impl.DeliveryAddressDaoImpl;
import org.example.emarketmall.entity.DeliveryAddress;
import org.example.emarketmall.service.DeliveryAddressService;
import org.example.emarketmall.utils.DateUtils;
import org.example.emarketmall.utils.StringUtils;

import java.util.List;

/**
 * @Description: 收货地址服务实现类
 * @author: 若若
 * @date: 2024年12月19日
 */
public class DeliveryAddressServiceImpl implements DeliveryAddressService {
    
    private DeliveryAddressDao deliveryAddressDao;
    
    public DeliveryAddressServiceImpl() {
        this.deliveryAddressDao = new DeliveryAddressDaoImpl();
    }
    
    @Override
    public List<DeliveryAddress> selectAddressByUserId(Integer userId) {
        try {
            if (userId == null) {
                throw new IllegalArgumentException("用户ID不能为空");
            }
            return deliveryAddressDao.selectAddressByUserId(userId);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("查询收货地址失败：" + e.getMessage());
        }
    }
    
    @Override
    public DeliveryAddress selectAddressById(Integer id) {
        try {
            if (id == null) {
                throw new IllegalArgumentException("地址ID不能为空");
            }
            return deliveryAddressDao.selectAddressById(id);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("查询收货地址失败：" + e.getMessage());
        }
    }
    
    @Override
    public DeliveryAddress selectDefaultAddressByUserId(Integer userId) {
        try {
            if (userId == null) {
                throw new IllegalArgumentException("用户ID不能为空");
            }
            return deliveryAddressDao.selectDefaultAddressByUserId(userId);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("查询默认收货地址失败：" + e.getMessage());
        }
    }
    
    @Override
    public boolean insertAddress(DeliveryAddress address) {
        try {
            // 参数验证
            validateAddress(address);
            
            // 如果设置为默认地址，先清除其他默认地址
            if (address.getIsDefault() != null && address.getIsDefault()) {
                deliveryAddressDao.clearDefaultAddress(address.getUserId());
            }
            
            // 设置创建时间
            String currentTime = DateUtils.getTime();
            address.setCreatedTime(currentTime);
            address.setUpdatedTime(currentTime);
            address.setCreatedBy("user");
            
            int result = deliveryAddressDao.insertAddress(address);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("新增收货地址失败：" + e.getMessage());
        }
    }
    
    @Override
    public boolean updateAddress(DeliveryAddress address) {
        try {
            // 参数验证
            validateAddress(address);
            
            if (address.getId() == null) {
                throw new IllegalArgumentException("地址ID不能为空");
            }
            
            // 如果设置为默认地址，先清除其他默认地址
            if (address.getIsDefault() != null && address.getIsDefault()) {
                deliveryAddressDao.clearDefaultAddress(address.getUserId());
            }
            
            // 设置更新时间
            address.setUpdatedTime(DateUtils.getTime());
            
            int result = deliveryAddressDao.updateAddress(address);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("更新收货地址失败：" + e.getMessage());
        }
    }
    
    @Override
    public boolean deleteAddress(Integer id, Integer userId) {
        try {
            if (id == null) {
                throw new IllegalArgumentException("地址ID不能为空");
            }
            if (userId == null) {
                throw new IllegalArgumentException("用户ID不能为空");
            }
            
            // 验证地址所有权
            boolean isOwner = deliveryAddressDao.validateAddressOwnership(id, userId);
            if (!isOwner) {
                throw new RuntimeException("无权限删除该地址");
            }
            
            int result = deliveryAddressDao.deleteAddress(id);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("删除收货地址失败：" + e.getMessage());
        }
    }
    
    @Override
    public boolean setDefaultAddress(Integer id, Integer userId) {
        try {
            if (id == null) {
                throw new IllegalArgumentException("地址ID不能为空");
            }
            if (userId == null) {
                throw new IllegalArgumentException("用户ID不能为空");
            }
            
            // 验证地址所有权
            boolean isOwner = deliveryAddressDao.validateAddressOwnership(id, userId);
            if (!isOwner) {
                throw new RuntimeException("无权限操作该地址");
            }
            
            // 先清除所有默认地址
            deliveryAddressDao.clearDefaultAddress(userId);
            
            // 设置新的默认地址
            int result = deliveryAddressDao.setDefaultAddress(id);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("设置默认地址失败：" + e.getMessage());
        }
    }
    
    /**
     * 验证地址信息
     */
    private void validateAddress(DeliveryAddress address) {
        if (address == null) {
            throw new IllegalArgumentException("地址信息不能为空");
        }
        if (address.getUserId() == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        if (StringUtils.isEmpty(address.getReceiverName())) {
            throw new IllegalArgumentException("收货人姓名不能为空");
        }
        if (StringUtils.isEmpty(address.getPhone())) {
            throw new IllegalArgumentException("手机号码不能为空");
        }
        if (StringUtils.isEmpty(address.getProvince())) {
            throw new IllegalArgumentException("省份不能为空");
        }
        if (StringUtils.isEmpty(address.getCity())) {
            throw new IllegalArgumentException("城市不能为空");
        }
        if (StringUtils.isEmpty(address.getDistrict())) {
            throw new IllegalArgumentException("区县不能为空");
        }
        if (StringUtils.isEmpty(address.getDetailAddress())) {
            throw new IllegalArgumentException("详细地址不能为空");
        }
        
        // 手机号格式验证
        if (!address.getPhone().matches("^1[3-9]\\d{9}$")) {
            throw new IllegalArgumentException("手机号码格式不正确");
        }
    }
}