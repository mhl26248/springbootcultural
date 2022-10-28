package com.example.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.Cars;
import com.example.demo.entity.Places;
import com.example.demo.mapper.CarsMapper;
import com.example.demo.mapper.PlacesMapper;
import com.example.demo.mapper.UserMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;

@RestController
@RequestMapping("/places")
public class PlacesController extends BaseController {

    @Resource
    PlacesMapper placesMapper;
    @Resource
    UserMapper userMapper;
    /**
     *
     * @param pageNum
     * @param pageSize
     * @param search
     * @return
     */
    @GetMapping("/findPage")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search) {
        LambdaQueryWrapper<Places> wrapper = Wrappers.<Places>lambdaQuery().orderByAsc(Places::getId);
        wrapper.like(Places::getPlaceName,search);
        Page<Places> userPage = placesMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);


        return Result.success(userPage);
    }
    @PostMapping("/save")
    public Result<?> save(@RequestBody Places obj) {
        //更新 user 表 站点管理人员关联
//        userMapper.resetPlace(obj.getId());//删除原有售点绑定的用户
        obj.setCreated(new Date());
        placesMapper.insert(obj);
        userMapper.updatePlace(obj.getId(),obj.getManagerId());//绑定新的用户
        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody Places obj) {
        //更新 user 表 站点管理人员关联
        userMapper.resetPlace(obj.getId());//删除原有售点绑定的用户
        userMapper.updatePlace(obj.getId(),obj.getManagerId());//绑定新的用户

        obj.setUpdated(new Date());
        placesMapper.updateById(obj);
        return Result.success();
    }


    @DeleteMapping("/{id}")
    public Result<?> update(@PathVariable Long id) {
        placesMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id) {
        return Result.success(placesMapper.selectById(id));
    }

    @GetMapping("/all")
    public Result<?> findAll() {
        return Result.success(placesMapper.selectList(null));
    }

    /**
     * 统计数据
     *
     * @return
     */
    @GetMapping("/count")
    public Result<?> count() {
//        carsMapper.countAddress()
        return Result.success();
    }




}
