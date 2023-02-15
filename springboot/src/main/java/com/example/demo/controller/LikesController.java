package com.example.demo.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.Comments;
import com.example.demo.entity.Likes;
import com.example.demo.entity.Record;
import com.example.demo.entity.RecordApply;
import com.example.demo.mapper.CommentsMapper;
import com.example.demo.mapper.LikesMapper;
import com.example.demo.mapper.RecordMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/like")
public class LikesController extends BaseController {
    @Resource
    LikesMapper likesMapper;
    @Resource
    RecordMapper recordMapper;


    @PostMapping("/save")
    public Result<?> save(@RequestBody Likes obj) {
        LambdaQueryWrapper<Likes> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(Likes::getUserId, obj.getUserId());
        wrapper.eq(Likes::getRecordId, obj.getRecordId());
        if(likesMapper.selectCount(wrapper)>0){
            return Result.error("001","已经收藏过");
        }
        obj.setCreated(new Date());
        likesMapper.insert(obj);
        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody Likes obj) {
        likesMapper.updateById(obj);
        return Result.success();
    }
    @GetMapping("/deleteById")
    public Result<?> deleteById(@RequestParam("id") Long id) {
        likesMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping("/getById")
    public Result<?> getById(@RequestParam("id") Long id) {
        return Result.success(likesMapper.selectById(id));
    }

    @GetMapping("/findPage")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "") String search2) {
        LambdaQueryWrapper<Likes> wrapper = Wrappers.lambdaQuery();
        if (StrUtil.isNotBlank(search)) {
            wrapper.eq(Likes::getUserId, search);
        }
//
        wrapper.orderByDesc(Likes::getId);
        Page<Likes> page = likesMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        List<Likes> objs = page.getRecords();
        for (Likes obj : objs) {

            Record r = recordMapper.selectById(obj.getRecordId());
            if(r!=null){
                obj.setTitle(r.getTitle());
                obj.setImages(r.getImages());
                obj.setStatus(r.getStatus());
            }

        }
        return Result.success(page);
    }
}
