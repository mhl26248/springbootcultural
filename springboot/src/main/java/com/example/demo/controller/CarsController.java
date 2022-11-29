package com.example.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.Cars;
import com.example.demo.entity.Places;
import com.example.demo.entity.User;
import com.example.demo.mapper.CarsMapper;
import com.example.demo.mapper.PlacesMapper;
import com.example.demo.mapper.UserMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.*;

@RestController
@RequestMapping("/cars")
public class CarsController extends BaseController {

    @Resource
    CarsMapper carsMapper;
    @Resource
    PlacesMapper placesMapper;
    @Resource
    UserMapper userMapper;


    @GetMapping("/summary")
    public Result<?> summary() {
        Map rst = new HashMap<>();
        //城市数
//        rst.put("citys",carsMapper.countCitys());
//        //站点数
        rst.put("places",carsMapper.countPlaces());
        //司机数
//        rst.put("drivers",carsMapper.countDrivers());
        //车辆数
        rst.put("cars",carsMapper.countCars());
        //总里程数
//        rst.put("miles",carsMapper.sumMiles());
//        rst.put("countCity",carsMapper.countCity());

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

    @GetMapping("/countCity")
    public Result<?> countCity() {

        return Result.success(carsMapper.countCity());
    }

    @PostMapping("/save")
    public Result<?> save(@RequestBody Cars cars) {
        cars.setCreated(new Date());
        carsMapper.insert(cars);
        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody Cars cars) {
        cars.setUpdated(new Date());
        carsMapper.updateById(cars);
        return Result.success();
    }


    @DeleteMapping("/{id}")
    public Result<?> update(@PathVariable Long id) {
        carsMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id) {
        return Result.success(carsMapper.selectById(id));
    }

    @GetMapping("/all")
    public Result<?> findAll() {
        return Result.success(carsMapper.selectList(null));
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
        LambdaQueryWrapper<Cars> wrapper = Wrappers.<Cars>lambdaQuery().orderByAsc(Cars::getId);
        wrapper.like(Cars::getCarName,search);
        if(StringUtils.isNotBlank(placeId)){
            wrapper.eq(Cars::getCarZd,placeId);
        }
        Page<Cars> userPage = carsMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);

        if(userPage!=null){
            List<Cars> carsList = userPage.getRecords();
            carsList.stream().forEach(o->{
                if(o.getCarZd()!=null){
                    Places p =placesMapper.selectById(o.getCarZd());
                    if(p!=null){
                        o.setPlaceName(p.getPlaceName());
                    }
                }
                if(o.getCarSj()!=null){
                    User user = userMapper.selectById(o.getCarSj());
                    if(user!=null){
                        o.setUserName(user.getUsername());
                    }
                }
            });
        }

        return Result.success(userPage);
    }


}
