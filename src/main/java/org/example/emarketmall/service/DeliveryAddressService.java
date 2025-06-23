package org.example.emarketmall.service;

import org.example.emarketmall.entity.DeliveryAddress;

import java.util.List;

/**
 * @Description: 收货地址服务接口
 * @author: 若若
 * @date: 2024年12月19日
 */
public interface DeliveryAddressService {
    
    /**
     * 根据用户ID查询收货地址列表
     * @param userId 用户ID
     * @return 收货地址列表
     */
    List<DeliveryAddress> selectAddressByUserId(Integer userId);
    
    /**
     * 根据ID查询收货地址
     * @param id 地址ID
     * @return 收货地址
     */
    DeliveryAddress selectAddressById(Integer id);
    
    /**
     * 获取用户默认收货地址
     * @param userId 用户ID
     * @return 默认收货地址
     */
    DeliveryAddress selectDefaultAddressByUserId(Integer userId);
    
    /**
     * 新增收货地址
     * @param address 收货地址
     * @return 是否成功
     */
    boolean insertAddress(DeliveryAddress address);
    
    /**
     * 更新收货地址
     * @param address 收货地址
     * @return 是否成功
     */
    boolean updateAddress(DeliveryAddress address);
    
    /**
     * 删除收货地址
     * @param id 地址ID
     * @param userId 用户ID（用于权限验证）
     * @return 是否成功
     */
    boolean deleteAddress(Integer id, Integer userId);
    
    /**
     * 设置默认收货地址
     * @param id 地址ID
     * @param userId 用户ID（用于权限验证）
     * @return 是否成功
     */
    boolean setDefaultAddress(Integer id, Integer userId);
}