package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.controller.dto.PlaceCityDto;
import com.example.demo.entity.CarLogs;
import com.example.demo.entity.Cars;
import org.apache.ibatis.annotations.Select;

import java.math.BigDecimal;
import java.util.List;

public interface CarLogsMapper extends BaseMapper<CarLogs> {


}
