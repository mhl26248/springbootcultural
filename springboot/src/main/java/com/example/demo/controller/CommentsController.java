package com.example.demo.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.Comments;
import com.example.demo.mapper.CommentsMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/comment")
public class CommentsController extends BaseController {
    @Resource
    CommentsMapper commentsMapper;


    @PostMapping("/save")
    public Result<?> save(@RequestBody Comments obj) {
        commentsMapper.insert(obj);
        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody Comments obj) {
        commentsMapper.updateById(obj);
        return Result.success();
    }
    @GetMapping("/deleteById")
    public Result<?> deleteById(@RequestParam("id") Long id) {
        commentsMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping("/getById")
    public Result<?> getById(@RequestParam("id") Long id) {
        return Result.success(commentsMapper.selectById(id));
    }

    @GetMapping("/findPage")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "") String search2) {
        LambdaQueryWrapper<Comments> wrapper = Wrappers.lambdaQuery();
        if (StrUtil.isNotBlank(search)) {
            wrapper.eq(Comments::getUserId, search);
        }
//
        wrapper.orderByDesc(Comments::getId);
        Page<Comments> page = commentsMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
//        List<RecordApply> recordApplies = page.getRecords();
//        for (RecordApply recordApply : recordApplies) {
//
//            Record r = recordMapper.selectById(recordApply.getRecordId());
//            if(r!=null){
//                recordApply.setTitle(r.getTitle());
//            }
//
//            User user = userMapper.selectById(recordApply.getApplyId());
//            if(user!=null){
//                recordApply.setApplyName(user.getUsername());
//            }
//        }
        return Result.success(page);
    }
}
