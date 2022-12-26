package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;
import java.util.List;

@TableName("record")
@Data
public class Record {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer userId;
    private Integer status;//
    private String remark;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date created;
    private String images;

    private String idNo;
    private String mobile;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date inDate;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date outDate;
    private String inRemark;
    private String recordNo;


    @TableField(exist = false)
    Integer recordApplyStatus;
    @TableField(exist = false)
    Integer recordApplyId;
//    @TableField(exist = false)
//    List<RecordLogs> recordLogs;

}
