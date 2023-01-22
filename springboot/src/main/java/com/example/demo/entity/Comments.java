package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@TableName("comments")
@Data
public class Comments {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer userId;
    private Integer recordId;//订单id
    private Integer goodsId;//商品id

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    private Date created;
    private String remark;
    private String score;

    @TableField(exist = false)
    String userName;
    @TableField(exist = false)
    String title;
    @TableField(exist = false)
    String images;

}
