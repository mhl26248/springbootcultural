package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@TableName("car_logs")
@Data
public class CarLogs {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer carId;
    private String type;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date created;

    @TableField(exist = false)
    String placeName;
    @TableField(exist = false)
    String userName;
    @TableField(exist = false)
    String carName;
    @TableField(exist = false)
    String carNo;
}
