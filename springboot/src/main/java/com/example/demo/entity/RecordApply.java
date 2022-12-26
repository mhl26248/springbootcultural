package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@TableName("record_apply")
@Data
public class RecordApply {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer applyId;
    private Integer passId;
    private Integer sickId;
    private Integer recordId;
    private Integer status;
    private String rejectMsg;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date created;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date updated;
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm", timezone = "GMT+8")
    private Date applyTime;
    private Integer type;


    @TableField(exist = false)
    private String recordNo;

    @TableField(exist = false)
    String applyName;
    @TableField(exist = false)
    String passName;
    @TableField(exist = false)
    String sickName;
}
