package com.example.demo.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.Comments;
import com.example.demo.entity.Record;
import com.example.demo.entity.RecordApply;
import com.example.demo.entity.User;
import com.example.demo.mapper.CommentsMapper;
import com.example.demo.mapper.RecordApplyMapper;
import com.example.demo.mapper.RecordMapper;
import com.example.demo.mapper.UserMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/comment")
public class CommentsController extends BaseController {
    @Resource
    CommentsMapper commentsMapper;
    @Resource
    UserMapper userMapper;
    @Resource
    RecordMapper recordMapper;
    @Resource
    RecordApplyMapper recordApplyMapper;

    @PostMapping("/save")
    public Result<?> save(@RequestBody Comments obj) {
        obj.setCreated(new Date());
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
            wrapper.like(Comments::getRemark, search);
        }
        if (StrUtil.isNotBlank(search2)) {
            wrapper.like(Comments::getGoodsId, search2);
        }
//
        wrapper.orderByDesc(Comments::getId);
        Page<Comments> page = commentsMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        List<Comments> objs = page.getRecords();
        for (Comments obj : objs) {
            RecordApply recordApply = recordApplyMapper.selectById(obj.getRecordId());
            if(recordApply!=null){
                Record r = recordMapper.selectById(recordApply.getRecordId());
                if(r!=null){
                    obj.setTitle(r.getTitle());
                    obj.setImages(r.getImages());
                }
            }
//
            User user = userMapper.selectById(obj.getUserId());
            if(user!=null){
                obj.setUserName(user.getUsername());
            }
        }
        return Result.success(page);
    }
}
