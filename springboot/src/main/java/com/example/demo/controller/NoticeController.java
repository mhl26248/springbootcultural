package com.example.demo.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.Notice;
import com.example.demo.mapper.NoticeMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;

@RestController
@RequestMapping("/notice")
public class NoticeController extends BaseController {

    @Resource
    NoticeMapper noticeMapper;


    @PostMapping("/save")
    public Result<?> save(@RequestBody Notice notice) {
        notice.setCreated(new Date());
        noticeMapper.insert(notice);
        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody Notice notice) {
        noticeMapper.updateById(notice);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> update(@PathVariable Long id) {
        noticeMapper.deleteById(id);
        return Result.success();
    }


    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id) {
        return Result.success(noticeMapper.selectById(id));
    }

    @GetMapping("/findPage")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search) {
        LambdaQueryWrapper<Notice> wrapper = Wrappers.lambdaQuery();
        if (StrUtil.isNotBlank(search)) {
            wrapper.like(Notice::getTitle, search);
        }
        Page<Notice> page = noticeMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);

        return Result.success(page);
    }
}
