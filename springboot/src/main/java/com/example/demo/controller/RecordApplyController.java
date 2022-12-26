package com.example.demo.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.Record;
import com.example.demo.entity.RecordApply;
import com.example.demo.entity.User;
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
//    @Resource
//    RecordLogsMapper recordLogsMapper;


    @PostMapping("/save")
    public Result<?> save(@RequestBody RecordApply obj) {
        obj.setCreated(new Date());
        obj.setStatus(0);
        obj.setApplyTime(new Date());
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
//    @GetMapping("/export")
//    public Result<?> export(
//            @RequestParam(defaultValue = "") String qEndDate,
//            @RequestParam(defaultValue = "") String qStartDate) {
//        if(StringUtils.isBlank(qEndDate) || StringUtils.isBlank(qStartDate)){
//            return Result.error("001","开始时间和结束时间不能为空");
//        }
//        DateTime date_str = DateUtil.beginOfDay(DateUtil.parse(qStartDate,"yyyy-MM-dd"));
//        DateTime date_str2 = DateUtil.endOfDay(DateUtil.parse(qEndDate,"yyyy-MM-dd"));
//        List<Summary> summaryList = recordApplyMapper.summary(date_str,date_str2);
//        String fileName = DateUtil.format(date_str,"yyyy-MM-dd") + DateUtil.format(date_str2,"yyyy-MM-dd");
//        ExcelWriter writer = ExcelUtil.getWriter(FileUtil.file(System.getProperty("user.dir")+"/"+fileName+".xlsx"));
//        ExcelWriter write = writer.write(summaryList);
//        write.flush();
//        writer.flush();
//        writer.close();
//        return Result.success(summaryList);
//    }

//    @GetMapping("/summary2")
//    public Result<?> summary2(
//                              @RequestParam(defaultValue = "") String qEndDate,
//                              @RequestParam(defaultValue = "") String qStartDate) {
//        if(StringUtils.isBlank(qEndDate) || StringUtils.isBlank(qStartDate)){
//            return Result.error("001","开始时间和结束时间不能为空");
//        }
//        DateTime date_str = DateUtil.beginOfDay(DateUtil.parse(qStartDate,"yyyy-MM-dd"));
//        DateTime date_str2 = DateUtil.endOfDay(DateUtil.parse(qEndDate,"yyyy-MM-dd"));
//        return Result.success(recordApplyMapper.summary(date_str,date_str2));
//    }
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
                              @RequestParam(defaultValue = "") String search) {
        LambdaQueryWrapper<RecordApply> wrapper = Wrappers.lambdaQuery();
        if (StrUtil.isNotBlank(search)) {
            wrapper.eq(RecordApply::getStatus, search);
        }
        wrapper.orderByDesc(RecordApply::getId);
        Page<RecordApply> page = recordApplyMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        List<RecordApply> recordApplies = page.getRecords();
        for (RecordApply recordApply : recordApplies) {
            User u1 = userMapper.selectById(recordApply.getApplyId());
            if(u1!=null){
                recordApply.setApplyName(u1.getUsername());
            }
            User u2 = userMapper.selectById(recordApply.getPassId());
            if(u2!=null){
                recordApply.setPassName(u2.getUsername());
            }
            User u3 = userMapper.selectById(recordApply.getSickId());
            if(u3!=null){
                recordApply.setSickName(u3.getUsername());
            }
            Record r = recordMapper.selectById(recordApply.getRecordId());
            if(r!=null){
                recordApply.setRecordNo(r.getRecordNo());
            }
        }
        return Result.success(page);
    }
}
