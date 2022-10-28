package com.example.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.Cars;
import com.example.demo.entity.Drivers;
import com.example.demo.entity.Places;
import com.example.demo.mapper.CarsMapper;
import com.example.demo.mapper.DriversMapper;
import com.example.demo.mapper.PlacesMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;

@RestController
@RequestMapping("/drivers")
public class DriversController extends BaseController {
    @Resource
    DriversMapper driversMapper;
    @Resource
    PlacesMapper placesMapper;
    @Resource
    CarsMapper carsMapper;

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
                              @RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "") String placeId) {
        LambdaQueryWrapper<Drivers> wrapper = Wrappers.<Drivers>lambdaQuery().orderByAsc(Drivers::getId);
        wrapper.like(Drivers::getDriverName,search);
        if(StringUtils.isNotBlank(placeId)){
            wrapper.eq(Drivers::getPlaceId,placeId);
        }
        Page<Drivers> userPage = driversMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        if(userPage!=null &&userPage.getRecords()!=null){
            userPage.getRecords().stream().forEach(o->{
                if(o.getCarId()!=null){
                    Cars cars = carsMapper.selectById(o.getCarId());
                    if(cars!=null)
                        o.setCarName(cars.getCarName());
                }
                if(o.getPlaceId()!=null){
                    Places places = placesMapper.selectById(o.getPlaceId());
                    if(places!=null)
                        o.setPlaceName(places.getPlaceName());
                }
            });
        }

        return Result.success(userPage);
    }
    @PostMapping("/save")
    public Result<?> save(@RequestBody Drivers obj) {
        obj.setDriverStatus(0);
        obj.setCreated(new Date());
        driversMapper.insert(obj);
        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody Drivers obj) {
        obj.setUpdated(new Date());
        driversMapper.updateById(obj);
        return Result.success();
    }


    @DeleteMapping("/{id}")
    public Result<?> update(@PathVariable Long id) {
        driversMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id) {
        return Result.success(driversMapper.selectById(id));
    }

    @GetMapping("/all")
    public Result<?> findAll() {
        return Result.success(driversMapper.selectList(null));
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
