package com.example.demo.controller;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.*;
import com.example.demo.mapper.CommentsMapper;
import com.example.demo.mapper.RecordApplyMapper;
import com.example.demo.mapper.RecordMapper;
import com.example.demo.mapper.UserMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/recordApply")
public class RecordApplyController extends BaseController {
    @Resource
    RecordMapper recordMapper;
    @Resource
    UserMapper userMapper;
    @Resource
    RecordApplyMapper recordApplyMapper;
    @Resource
    CommentsMapper commentsMapper;


    @PostMapping("/save")
    public Result<?> save(@RequestBody RecordApply obj) {
//        if(null == obj.getApplyTime() ||obj.getApplyTime().equals("")){
//            return Result.error("001","请选择预约日期");
//        }
        Record record = recordMapper.selectById(obj.getRecordId());
        if(record == null || record.getStatus() != 0){
            return Result.error("001","商品已经下架");
        }
        LambdaQueryWrapper<RecordApply> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(RecordApply::getRecordId,obj.getRecordId());
        wrapper.eq(RecordApply::getApplyId,obj.getApplyId());
        wrapper.eq(RecordApply::getApplyTime,DateUtil.format(obj.getApplyTime(),"yyyy-MM-dd"));
//        int c  = recordApplyMapper.selectCount(wrapper);
//        if(c>0){
//            return Result.error("001","该日期已经预约过了");
//        }
        obj.setCreated(new Date());
        obj.setStatus(0);
        recordApplyMapper.insert(obj);

        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody RecordApply obj) {
        if(obj.getStatus() == 1 && obj.getType() == 2){//借阅审核通过 线下阅读才是借出
            //更新 病例 状态是 借出
            recordMapper.updateRecordOutside(obj.getRecordId());
        }
        recordApplyMapper.updateById(obj);
        return Result.success();
    }
    @GetMapping("/deleteById")
    public Result<?> deleteById(@RequestParam("id") Long id) {
        recordApplyMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping("/getById")
    public Result<?> getById(@RequestParam("id") Long id) {
        return Result.success(recordApplyMapper.selectById(id));
    }

    @GetMapping("/findPage")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "") String search2) {
        LambdaQueryWrapper<RecordApply> wrapper = Wrappers.lambdaQuery();
        if (StrUtil.isNotBlank(search)) {
            wrapper.eq(RecordApply::getApplyTime, search);
        }
        if (StrUtil.isNotBlank(search2)) {
            wrapper.eq(RecordApply::getApplyId, search2);
        }
        wrapper.orderByDesc(RecordApply::getId);
        Page<RecordApply> page = recordApplyMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        List<RecordApply> recordApplies = page.getRecords();
        for (RecordApply recordApply : recordApplies) {

            Record r = recordMapper.selectById(recordApply.getRecordId());
            if(r!=null){
                recordApply.setTitle(r.getTitle());
                recordApply.setImages(r.getImages());
                recordApply.setPrice(r.getPrice());
                recordApply.setDiff(r.getDiff());
            }

            User user = userMapper.selectById(recordApply.getApplyId());
            if(user!=null){
                recordApply.setApplyName(user.getUsername());
            }
            LambdaQueryWrapper<Comments> wrapper2 = Wrappers.lambdaQuery();
            wrapper2.eq(Comments::getRecordId, recordApply.getId());
            wrapper2.eq(Comments::getUserId, recordApply.getApplyId());
            List<Comments> comments = commentsMapper.selectList(wrapper2);
            if(comments!=null && comments.size()>0){
                recordApply.setComments(comments.get(0));
            }

        }
        return Result.success(page);
    }
}
