package com.example.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.CheckCode;
import com.example.demo.mapper.CheckCodeMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;

@RestController
@RequestMapping("/checkCode")
public class CheckCodeController extends BaseController {

    @Resource
    CheckCodeMapper checkCodeMapper;


    @PostMapping("/save")
    public Result<?> save(@RequestBody CheckCode obj) {
        obj.setCreated(new Date());
        checkCodeMapper.insert(obj);
        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody CheckCode obj) {
        checkCodeMapper.updateById(obj);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> update(@PathVariable Long id) {
        checkCodeMapper.deleteById(id);
        return Result.success();
    }


    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id) {
        return Result.success(checkCodeMapper.selectById(id));
    }

    @GetMapping("/findPage")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search) {
        LambdaQueryWrapper<CheckCode> wrapper = Wrappers.lambdaQuery();
//        if (StrUtil.isNotBlank(search)) {
//            wrapper.like(CheckCode::getTitle, search);
//        }
        Page<CheckCode> page = checkCodeMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);

        return Result.success(page);
    }
}
