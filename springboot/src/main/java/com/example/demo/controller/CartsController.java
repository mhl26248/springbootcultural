package com.example.demo.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.Cart;
import com.example.demo.entity.Likes;
import com.example.demo.entity.Record;
import com.example.demo.mapper.CartsMapper;
import com.example.demo.mapper.RecordMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/cart")
public class CartsController extends BaseController {
    @Resource
    CartsMapper cartsMapper;

    @Resource
    RecordMapper recordMapper;

    @PostMapping("/save")
    public Result<?> save(@RequestBody Cart obj) {
        LambdaQueryWrapper<Cart> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(Cart::getUserId, obj.getUserId());
        wrapper.eq(Cart::getRecordId, obj.getRecordId());
        if(cartsMapper.selectCount(wrapper)>0){
            return Result.error("001","已经添加过");
        }
        obj.setCreated(new Date());
        cartsMapper.insert(obj);
        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody Cart obj) {
        cartsMapper.updateById(obj);
        return Result.success();
    }
    @GetMapping("/deleteById")
    public Result<?> deleteById(@RequestParam("id") Long id) {
        cartsMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping("/getById")
    public Result<?> getById(@RequestParam("id") Long id) {
        return Result.success(cartsMapper.selectById(id));
    }

    @GetMapping("/findPage")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "") String search2) {
        LambdaQueryWrapper<Cart> wrapper = Wrappers.lambdaQuery();
        if (StrUtil.isNotBlank(search)) {
            wrapper.eq(Cart::getUserId, search);
        }

        wrapper.orderByDesc(Cart::getId);
        Page<Cart> page = cartsMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        List<Cart> objs = page.getRecords();
        for (Cart obj : objs) {

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
