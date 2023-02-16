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

@TableName("record")
@Data
public class Record {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer userId;
    private Integer status;//0 审核中 1 通过 2 驳回
    private String remark;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date created;
    private String images;
    private String successor;

    private String title;
    private String recordNo;
    private String detail;
    private String type;
    private Integer views;
    private Integer hots;


    @TableField(exist = false)
    Integer recordApplyStatus;
    @TableField(exist = false)
    Integer recordApplyId;

    @TableField(exist = false)
    String userName;


//    @TableField(exist = false)
//    List<RecordLogs> recordLogs;

}
