package org.example.emarketmall.dao;

import org.example.emarketmall.entity.DeliveryAddress;

import java.util.List;

/**
 * @Description: 收货地址DAO接口
 * @author: 若若
 * @date: 2024年12月19日
 */
public interface DeliveryAddressDao {
    
    /**
     * 根据用户ID查询收货地址列表
     * @param userId 用户ID
     * @return 收货地址列表
     * @throws Exception
     */
    List<DeliveryAddress> selectAddressByUserId(Integer userId) throws Exception;
    
    /**
     * 根据ID查询收货地址
     * @param id 地址ID
     * @return 收货地址
     * @throws Exception
     */
    DeliveryAddress selectAddressById(Integer id) throws Exception;
    
    /**
     * 获取用户默认收货地址
     * @param userId 用户ID
     * @return 默认收货地址
     * @throws Exception
     */
    DeliveryAddress selectDefaultAddressByUserId(Integer userId) throws Exception;
    
    /**
     * 新增收货地址
     * @param address 收货地址
     * @return 影响行数
     * @throws Exception
     */
    int insertAddress(DeliveryAddress address) throws Exception;
    
    /**
     * 更新收货地址
     * @param address 收货地址
     * @return 影响行数
     * @throws Exception
     */
    int updateAddress(DeliveryAddress address) throws Exception;
    
    /**
     * 删除收货地址（逻辑删除）
     * @param id 地址ID
     * @return 影响行数
     * @throws Exception
     */
    int deleteAddress(Integer id) throws Exception;
    
    /**
     * 清除用户所有地址的默认状态
     * @param userId 用户ID
     * @return 影响行数
     * @throws Exception
     */
    int clearDefaultAddress(Integer userId) throws Exception;
    
    /**
     * 设置默认收货地址
     * @param id 地址ID
     * @return 影响行数
     * @throws Exception
     */
    int setDefaultAddress(Integer id) throws Exception;
    
    /**
     * 验证地址是否属于指定用户
     * @param id 地址ID
     * @param userId 用户ID
     * @return 是否属于该用户
     * @throws Exception
     */
    boolean validateAddressOwnership(Integer id, Integer userId) throws Exception;
}