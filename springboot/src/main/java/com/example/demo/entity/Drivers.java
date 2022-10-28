package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@TableName("drivers")
@Data
public class Drivers {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String driverName;
    private String sex;
    private Integer age;
    Integer workAge;
    Integer placeId;
    Integer carId;
    Integer driverStatus;//0 休息 1 驾驶
    Integer applyStatus;//0 未申请  1通过

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date created;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updated;

    @TableField(exist = false)
    String carName;
    @TableField(exist = false)
    String placeName;

}
