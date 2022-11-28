package com.example.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.CarLogs;
import com.example.demo.entity.Cars;
import com.example.demo.entity.Places;
import com.example.demo.entity.User;
import com.example.demo.mapper.CarLogsMapper;
import com.example.demo.mapper.CarsMapper;
import com.example.demo.mapper.PlacesMapper;
import com.example.demo.mapper.UserMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.*;

@RestController
@RequestMapping("/carlogs")
public class CarLogsController extends BaseController {

    @Resource
    CarsMapper carsMapper;
    @Resource
    CarLogsMapper carLogsMapper;
    @Resource
    PlacesMapper placesMapper;
    @Resource
    UserMapper userMapper;


    @GetMapping("/summary")
    public Result<?> summary() {
        Map rst = new HashMap<>();
        //城市数
//        rst.put("citys",carsMapper.countCitys());
        //站点数
        rst.put("places",carsMapper.countPlaces());
        //司机数
        rst.put("drivers",carsMapper.countDrivers());
        //车辆数
        rst.put("cars",carsMapper.countCars());
        //总里程数
        rst.put("miles",carsMapper.sumMiles());
        rst.put("countCity",carsMapper.countCity());

        return Result.success(rst);
    }


    @GetMapping("/summary2")
    public Result<?> summary2() {
        List places_arr = new ArrayList();
        List count_arr = new ArrayList();
        //站点
        List<Places> place = placesMapper.selectList(null);
        if(CollectionUtils.isNotEmpty(place)){
            place.stream().forEach(p->{
                places_arr.add(p.getPlaceName());
                //站点车辆数量
                count_arr.add(carsMapper.countPlaceCars(p.getId()));
            });
        }

        Map rst = new HashMap<>();
        //站点数
        rst.put("places_arr",places_arr);
        //司机数
        rst.put("count_arr",count_arr);

        return Result.success(rst);
    }

    @PostMapping("/save")
    public Result<?> save(@RequestBody CarLogs obj) {
        obj.setCreated(new Date());
        carLogsMapper.insert(obj);
        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody CarLogs obj) {
        carLogsMapper.updateById(obj);
        return Result.success();
    }


    @GetMapping("/findPage")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String start,
                              @RequestParam(defaultValue = "") String end) {
        LambdaQueryWrapper<CarLogs> wrapper = Wrappers.<CarLogs>lambdaQuery().orderByDesc(CarLogs::getId);
        if(StringUtils.isNotBlank(start)){
            wrapper.ge(CarLogs::getCreated,start);
        }
        if(StringUtils.isNotBlank(end)){
            wrapper.le(CarLogs::getCreated,end);
        }
        Page<CarLogs> page = carLogsMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);

        if(page!=null && page.getRecords() != null){
            for(CarLogs c:page.getRecords()){
                Cars o = carsMapper.selectById(c.getCarId());
                c.setCarName(o.getCarName());
                c.setCarNo(o.getCarNo());
                if(o.getCarZd()!=null){
                    Places p =placesMapper.selectById(o.getCarZd());
                    if(p!=null){
                        c.setPlaceName(p.getPlaceName());
                    }
                }
                if(o.getCarSj()!=null){
                    User user = userMapper.selectById(o.getCarSj());
                    if(user!=null){
                        c.setUserName(user.getUsername());
                    }
                }
            }
        }

        return Result.success(page);
    }


}
