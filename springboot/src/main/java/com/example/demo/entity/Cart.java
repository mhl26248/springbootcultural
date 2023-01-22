package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@TableName("cart")
@Data
public class Cart {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer userId;
    private Integer recordId;
    private Integer nums;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    private Date created;

    @TableField(exist = false)
    private String title;
    @TableField(exist = false)
    private String images;
    @TableField(exist = false)
    private BigDecimal price;
    @TableField(exist = false)
    private BigDecimal diff;
    @TableField(exist = false)
    private Integer status;
}
