package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.entity.DriversApply;
import org.apache.ibatis.annotations.Update;

public interface DriversApplyMapper extends BaseMapper<DriversApply> {

    @Update("update drivers_apply set apply_status = #{apply_status} where id = #{id}")
    int updateStatus(int apply_status,long id);


    @Update("update drivers_apply set apply_status = 3 where drivers_id = #{id} and apply_type = #{type}")
    int updateHistoryStatus(long id,int type);
}
