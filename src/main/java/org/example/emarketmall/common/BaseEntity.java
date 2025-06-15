package org.example.emarketmall.common;

import java.io.Serializable;
import java.util.Date;
import java.util.UUID;

/**
 * Entity基类
 * apache commons-dbutils包只支持数据字段使用驼峰命名，不支持下划线
 */
public class BaseEntity implements Serializable
{
    private static final long serialVersionUID = 1L;

    /** 数据唯一标识 */
    private Integer id;

    /** 创建者 */
    private String createdBy;

    /** 创建时间 */
    private String createdTime;

    /** 更新者 */
    private String updatedBy;

    /** 更新时间 */
    private String updatedTime;

    /** 备注 */
    private String remark;

    /** 删除状态 0正常，1已删除。默认值0 */
    private int delFlag = 0;

    /**
     * 通用唯一识别码，是由一组32位数的16进制数字所构成
     * 总共有 2^ 128个数字，大概是3.4 * 10^38个
     * 特点：不会重复
     * 举例：550e8400-e29b-41d4-a716-446655440000
     * @return 返回一个UUID字符串，不含连接符-
     */
    public static String getUUID() {
        return UUID.randomUUID().toString().replace("-", "");
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(String createdTime) {
        this.createdTime = createdTime;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public String getUpdatedTime() {
        return updatedTime;
    }

    public void setUpdatedTime(String updatedTime) {
        this.updatedTime = updatedTime;
    }

    public int getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(int delFlag) {
        this.delFlag = delFlag;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }



}
