package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.controller.dto.PlaceCityDto;
import com.example.demo.controller.dto.UserAddressDto;
import com.example.demo.entity.Cars;
import com.example.demo.entity.Member;
import org.apache.ibatis.annotations.Select;

import java.math.BigDecimal;
import java.util.List;

public interface CarsMapper extends BaseMapper<Cars> {

    @Select("select count(*) from cars where car_zd = #{placeId}")
    int countPlaceCars(int placeId);

    @Select("select count(*) from cars ")
    int countCars();

    @Select("select sum(car_miles) from cars ")
    BigDecimal sumMiles();


    @Select("select count(*) from places ")
    int countPlaces();

    @Select("select count(*) from drivers ")
    int countDrivers();


//    @Select("select count(*) from places group by city")
//    int countCitys();


    @Select("select count(id) count, city from places GROUP BY city")
    List<PlaceCityDto> countCity();

}
