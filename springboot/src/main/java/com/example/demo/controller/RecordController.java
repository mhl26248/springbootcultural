package com.example.demo.controller;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.Likes;
import com.example.demo.entity.Record;
import com.example.demo.entity.RecordApply;
import com.example.demo.entity.User;
import com.example.demo.mapper.LikesMapper;
import com.example.demo.mapper.RecordApplyMapper;
import com.example.demo.mapper.RecordMapper;
import com.example.demo.mapper.UserMapper;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/record")
public class RecordController extends BaseController {

    @Resource
    RecordMapper recordMapper;
    @Resource
    RecordApplyMapper recordApplyMapper;
    @Resource
    LikesMapper likesMapper;
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


    @PostMapping("/save")
    public Result<?> save(@RequestBody Record obj) {
        obj.setRecordNo(IdUtil.fastSimpleUUID());
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


    @GetMapping("/getWeather")
    public Result<?> getWeather(String city) {
        String url = "http://www.weather.com.cn/data/cityinfo/"+city+".html";
        String weatherInfo = getWeatherInfo(url);
        return Result.success(JSONUtil.parseObj(weatherInfo));
    }

    public static String getWeatherInfo(String url) {
        CloseableHttpClient client;
        client = HttpClients.createDefault();

        HttpGet get = new HttpGet(url);
        HttpResponse response;
        try {
            response = client.execute(get);
            HttpEntity entity = response.getEntity();
            if (entity != null) {
                InputStream instreams = entity.getContent();
                String str = convertStreamToString(instreams);
                get.abort();
                return str;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static String convertStreamToString(InputStream is) {
        StringBuilder sb1 = new StringBuilder();
        byte[] bytes = new byte[4096];
        int size;

        try {
            while ((size = is.read(bytes)) > 0) {
                String str = new String(bytes, 0, size, "UTF-8");
                sb1.append(str);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return sb1.toString();
    }

    @GetMapping("/getById")
    public Result<?> getById(@RequestParam("id") Long id) {
        Record r = recordMapper.selectById(id);
        int views = r.getViews()+1;
        LambdaQueryWrapper<Likes> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(Likes::getRecordId,id);
        LambdaQueryWrapper<RecordApply> wrapper2 = Wrappers.lambdaQuery();
        wrapper2.eq(RecordApply::getRecordId,id.intValue());
        //更新热度  浏览次数+收藏次数+订单量
        int hots = views
                +likesMapper.selectCount(wrapper)
                +recordApplyMapper.selectCount(wrapper2);

        recordMapper.updateViews(id.intValue(),hots,views);

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
                                      @RequestParam(defaultValue = "") String search2,
                                      @RequestParam(defaultValue = "") String search1,
                                      @RequestParam(defaultValue = "") String sort) {

        LambdaQueryWrapper<Record> wrapper = Wrappers.lambdaQuery();
        if (userId!=null) {
            wrapper.eq(Record::getUserId, userId);
        }
        if (StrUtil.isNotBlank(search2)) {
            wrapper.like(Record::getTitle, search2);
        }
        if (StrUtil.isNotBlank(search1)) {
            wrapper.like(Record::getStatus, search1);
        }
        if(StrUtil.isNotBlank(sort)){
            if(sort.equals("1")){
                wrapper.orderByDesc(Record::getHots);
            }
            if(sort.equals("2")){
                wrapper.orderByDesc(Record::getId);
            }
        }
        Page<Record> page = recordMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        List<Record> records = page.getRecords();
        if(page!=null && CollectionUtils.isNotEmpty(records)){
            for(Record r:records){
                User u = userMapper.selectById(r.getUserId());
                if(u!=null){
                    r.setUserName(u.getUsername());
                }
            }
        }

        return Result.success(page);
    }



}
