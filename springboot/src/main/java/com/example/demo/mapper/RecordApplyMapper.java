package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.controller.dto.RecordDto;
import com.example.demo.entity.RecordApply;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface RecordApplyMapper extends BaseMapper<RecordApply> {


    @Select("select count(id) count, record_id, (select title from record where id = record_id) as title from record_apply GROUP BY record_id")
    List<RecordDto> count();


    //set global sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';


//    @Select("select count(*) as total," +
////            "(select count(*) from record_logs where record_id in(select record_id from record_apply where (`status` =1 or `status` = 3) and apply_id=ra.apply_id and ra.apply_time >= #{qStartDate} and ra.apply_time <= #{qEndDate})) as totalLogs," +
//            "(select count(*) from record_apply where (`status` =1 or `status` = 3) and apply_id=ra.apply_id and ra.apply_time >= #{qStartDate} and ra.apply_time <= #{qEndDate}) as pass," +
//            "(select count(*) from record_apply where `status` =2 and apply_id=ra.apply_id and ra.apply_time >= #{qStartDate} and ra.apply_time <= #{qEndDate}) as unpass," +
//            "ra.apply_id from record_apply  ra where ra.apply_time >= #{qStartDate} and ra.apply_time <= #{qEndDate} GROUP BY ra.apply_id")
//    List<Summary> summary(DateTime qStartDate, DateTime qEndDate);
}
