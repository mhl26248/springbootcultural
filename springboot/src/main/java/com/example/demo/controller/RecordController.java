package com.example.demo.controller;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.Record;
import com.example.demo.mapper.RecordMapper;
import com.example.demo.mapper.UserMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/record")
public class RecordController extends BaseController {

    @Resource
    RecordMapper recordMapper;
    @Resource
    UserMapper userMapper;


    @PostMapping("/updateStatus")
    public Result<?> updateStatus(@RequestBody Record obj) {
        recordMapper.updateStatus(obj.getId(),obj.getStatus());
        return Result.success();
    }
    @PostMapping("/rein")
    public Result<?> rein(@RequestBody Record obj) {
        recordMapper.rein(obj.getId());
        recordMapper.reinApply(obj.getRecordApplyId());
        return Result.success();
    }
    @PostMapping("/handleOut")
    public Result<?> handleOut(@RequestBody Record obj) {
        recordMapper.handleOut(obj.getId());
        return Result.success();
    }
    @PostMapping("/recordIn")
    public Result<?> recordIn(@RequestBody Record obj) {
        recordMapper.recordIn(obj.getId());
        return Result.success();
    }


    public Result<?> save(@RequestBody Record obj) {
        obj.setCreated(new Date());
        obj.setStatus(0);
        recordMapper.insert(obj);


        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody Record obj) {
        recordMapper.updateById(obj);


        return Result.success();
    }

    @GetMapping("/deleteById")
    public Result<?> deleteById(@RequestParam("id") Long id) {
        recordMapper.deleteById(id);
        return Result.success();
    }



    @GetMapping("/getById")
    public Result<?> getById(@RequestParam("id") Long id) {
        return Result.success(recordMapper.selectById(id));
    }

    @GetMapping("/findPage")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "") String search1,
                              @RequestParam(defaultValue = "") String search2,
                              @RequestParam(defaultValue = "") String search3) {
        LambdaQueryWrapper<Record> wrapper = Wrappers.lambdaQuery();


        if (StrUtil.isNotBlank(search2)) {
            wrapper.eq(Record::getStatus, search2);
        }
        Page<Record> page = recordMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        List<Record> records = page.getRecords();
        for (Record record : records) {
            Integer recordId = record.getId();
//            User sick = userMapper.selectById(record.getSickId());
//            if(sick!=null){
//                record.setSickName(sick.getUsername());
//            }
//            User doctor = userMapper.selectById(record.getDoctorId());
//            if(doctor!=null){
//                record.setDoctorName(doctor.getUsername());
//            }
//            LambdaQueryWrapper<RecordLogs> wrapper_logs = Wrappers.lambdaQuery();
//            wrapper_logs.eq(RecordLogs::getRecordId, recordId);
//            record.setRecordLogs(recordLogsMapper.selectList(wrapper_logs));

        }
        return Result.success(page);
    }
    @GetMapping("/findPageUserId")
    public Result<?> findPageUserId(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") Integer userId) {

        Page<Record> page = new Page<>();
        List<Record> records = recordMapper.selectApplyRecord(userId,(pageNum-1)*pageSize,pageNum*pageSize);

        page.setTotal(recordMapper.selectApplyRecordCount(userId));
        page.setRecords(records);
        return Result.success(page);
    }

    @GetMapping("/findPassPageUserId")
    public Result<?> findPassPageUserId(@RequestParam(defaultValue = "1") Integer pageNum,
                                    @RequestParam(defaultValue = "10") Integer pageSize,
                                    @RequestParam(defaultValue = "") Integer userId) {

        Page<Record> page = new Page<>();
        List<Record> records = recordMapper.selectPassApplyRecord(userId,(pageNum-1)*pageSize,pageNum*pageSize);
        page.setTotal(recordMapper.selectApplyRecordCount(userId));
        page.setRecords(records);
        return Result.success(page);
    }
    @GetMapping("/findPageMyRecord")
    public Result<?> findPageMyRecord(@RequestParam(defaultValue = "1") Integer pageNum,
                                        @RequestParam(defaultValue = "10") Integer pageSize,
                                        @RequestParam(defaultValue = "") Integer userId,
                                      @RequestParam(defaultValue = "") String search2) {

        LambdaQueryWrapper<Record> wrapper = Wrappers.lambdaQuery();
        if (StrUtil.isNotBlank(search2)) {
            wrapper.like(Record::getTitle, search2);
        }
        Page<Record> page = recordMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(page);
    }



}
