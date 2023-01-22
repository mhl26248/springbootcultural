package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@TableName("record_apply")
@Data
public class RecordApply {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer applyId;
    private Integer recordId;
    private Integer status;
    private String rejectMsg;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date created;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date updated;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date applyTime;
    private Integer type;
    private String payType;
    private BigDecimal payAmt;
    private BigDecimal payDiff;
    private BigDecimal payPrice;


    @TableField(exist = false)
    private String title;
    @TableField(exist = false)
    private String applyName;
    @TableField(exist = false)
    private String images;
    @TableField(exist = false)
    private BigDecimal price;
    @TableField(exist = false)
    private BigDecimal diff;

}
