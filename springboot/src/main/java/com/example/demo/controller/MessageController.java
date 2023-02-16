package com.example.demo.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.CheckCode;
import com.example.demo.entity.Message;
import com.example.demo.mapper.CheckCodeMapper;
import com.example.demo.mapper.MessageMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;

@RestController
@RequestMapping("/message")
public class MessageController extends BaseController {

    @Resource
    MessageMapper messageMapper;


    @PostMapping("/save")
    public Result<?> save(@RequestBody Message obj) {
        obj.setCreated(new Date());
        messageMapper.insert(obj);
        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody Message obj) {
        messageMapper.updateById(obj);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> update(@PathVariable Long id) {
        messageMapper.deleteById(id);
        return Result.success();
    }


    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id) {
        return Result.success(messageMapper.selectById(id));
    }

    @GetMapping("/findPage")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search) {
        LambdaQueryWrapper<Message> wrapper = Wrappers.lambdaQuery();
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(Message::getRecordId, search);
        }
        Page<Message> page = messageMapper.selectPage(new Page<>(pageNum, pageSize), wrapper.orderByDesc(Message::getId));

        return Result.success(page);
    }
}
