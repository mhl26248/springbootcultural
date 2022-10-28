package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@TableName("drivers_apply")
@Data
public class DriversApply {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer driversId;
    private Integer carsId;
    private Integer oldCarsId;
    private Integer placesId;
    private Integer oldPlacesId;
    private Integer applyStatus;//0 待审核 1 审核通过 2 拒绝 3 失效
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date applyTime;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date created;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date updated;
    private Integer applyType;//1 车辆申请  2 站点申请 3 司机入驻审核 4 站点变更

    @TableField(exist = false)
    String carsName;
    @TableField(exist = false)
    String oldCarsName;
    @TableField(exist = false)
    String placesName;
    @TableField(exist = false)
    String oldPlacesName;
    @TableField(exist = false)
    String driverName;
    @TableField(exist = false)
    Integer userId;

}
