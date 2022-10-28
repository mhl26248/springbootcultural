package com.example.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.Drivers;
import com.example.demo.entity.DriversApply;
import com.example.demo.entity.NewsMessage;
import com.example.demo.entity.Places;
import com.example.demo.mapper.*;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/driversApply")
public class DriversApplyController extends BaseController {

    @Resource
    DriversApplyMapper driversApplyMapper;
    @Resource
    CarsMapper carsMapper;
    @Resource
    PlacesMapper placesMapper;
    @Resource
    DriversMapper driversMapper;
    @Resource
    UserMapper userMapper;
    @PostMapping("/updateStatus")
    public Result<?> updateStatus(@RequestBody DriversApply driversApply) {
//        Drivers drivers = driversMapper.selectById(driversApply.getDriversId());
//        if(driversApply.getApplyType().equals(3)){
//            drivers.setApplyStatus(0);
//        }
//        if(driversApply.getApplyType().equals(2)){
//            drivers.setPlaceId(driversApply.getPlacesId());
//        }
//        if(driversApply.getApplyType().equals(1)){
//            drivers.setCarId(driversApply.getCarsId());
//        }
//        driversMapper.updateById(drivers);//更新人员站点数据
        driversApplyMapper.updateStatus(3,driversApply.getId());//失效
        return Result.success();
    }
    @PostMapping("/updateStatusDown")
    public Result<?> updateStatusDown(@RequestBody DriversApply driversApply) {
        Drivers drivers = driversMapper.selectById(driversApply.getDriversId());
        if(driversApply.getApplyType().equals(3)){
            drivers.setApplyStatus(0);
        }
        if(driversApply.getApplyType().equals(2)){
            drivers.setPlaceId(driversApply.getPlacesId());
            userMapper.updatePlace(null,userMapper.selectIdByDriverid(driversApply.getDriversId()));
        }
        if(driversApply.getApplyType().equals(1)){
            drivers.setCarId(driversApply.getCarsId());
        }
        driversMapper.updateById(drivers);//更新人员站点数据
        driversApplyMapper.updateStatus(0,driversApply.getId());
        return Result.success();
    }
    @PostMapping("/updateStatusUp")
    public Result<?> updateStatusUp(@RequestBody DriversApply driversApply) {
        Drivers drivers = driversMapper.selectById(driversApply.getDriversId());
        if(driversApply.getApplyType().equals(3)){
            drivers.setApplyStatus(1);
        }
        if(driversApply.getApplyType().equals(2)){
            drivers.setPlaceId(driversApply.getPlacesId());
            userMapper.updatePlace(driversApply.getPlacesId(),userMapper.selectIdByDriverid(driversApply.getDriversId()));
        }
        if(driversApply.getApplyType().equals(1)){
            drivers.setCarId(driversApply.getCarsId());
        }
        driversMapper.updateById(drivers);//更新人员状态是已通过
        driversApplyMapper.updateStatus(1,driversApply.getId());
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
                              @RequestParam(defaultValue = "") String queryMstatus,
                              @RequestParam(defaultValue = "") String userId,
                              @RequestParam(defaultValue = "") String placeId) {
        LambdaQueryWrapper<DriversApply> wrapper = Wrappers.<DriversApply>lambdaQuery().orderByDesc(DriversApply::getId);
        wrapper.eq(DriversApply::getApplyType,search);//申请类型
        if(StringUtils.isNotBlank(queryMstatus) && !queryMstatus.equals("-1")){
            wrapper.eq(DriversApply::getApplyStatus,queryMstatus);//申请状态
        }
        if(StringUtils.isNotBlank(userId)){
            wrapper.eq(DriversApply::getDriversId,userId);
        }
        if(StringUtils.isNotBlank(placeId)){
            wrapper.eq(DriversApply::getPlacesId,placeId);
        }
        Page<DriversApply> userPage = driversApplyMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);

        List<DriversApply> driversApplyList = userPage.getRecords();
        if(driversApplyList!=null){
            for(DriversApply driversApply:driversApplyList){
                try{
                    driversApply.setDriverName(driversMapper.selectById(driversApply.getDriversId()).getDriverName());
                    if(driversApply.getCarsId()!=null)
                        driversApply.setCarsName(carsMapper.selectById(driversApply.getCarsId()).getCarName());
                    if(driversApply.getPlacesId()!=null)
                        driversApply.setPlacesName(placesMapper.selectById(driversApply.getPlacesId()).getPlaceName());
                }
                catch (Exception e){
                    //
                }
            }
        }

        return Result.success(userPage);
    }
    @PostMapping("/save")
    public Result<?> save(@RequestBody DriversApply obj) {
        //历史申请 设置为无效
        driversApplyMapper.updateHistoryStatus(obj.getDriversId(),obj.getApplyType());

        if(obj.getApplyType().equals(2))
            driversMapper.updateHistoryPlace(obj.getDriversId());
        if(obj.getApplyType().equals(1))
            driversMapper.updateHistoryCar(obj.getDriversId());

        obj.setApplyStatus(0);
        obj.setApplyTime(new Date());
        obj.setCreated(new Date());
        driversApplyMapper.insert(obj);
        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody DriversApply obj) {
        obj.setUpdated(new Date());
        driversApplyMapper.updateById(obj);
        return Result.success();
    }


    @DeleteMapping("/{id}")
    public Result<?> update(@PathVariable Long id) {
        driversApplyMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id) {
        return Result.success(driversApplyMapper.selectById(id));
    }

    @GetMapping("/all")
    public Result<?> findAll() {
        return Result.success(driversApplyMapper.selectList(null));
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
