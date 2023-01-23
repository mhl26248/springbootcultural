package com.example.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@TableName("notice")
@Data
public class Notice {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String title;
    private String context;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date created;
}
