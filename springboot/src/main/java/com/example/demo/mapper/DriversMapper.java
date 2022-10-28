package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.entity.Drivers;
import com.example.demo.entity.Places;
import org.apache.ibatis.annotations.Update;

public interface DriversMapper extends BaseMapper<Drivers> {


    @Update("update drivers set place_id = null where id = #{id} ")
    int updateHistoryPlace(long id);

    @Update("update drivers set car_id = null where id = #{id} ")
    int updateHistoryCar(long id);
}
