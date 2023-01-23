package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.entity.Record;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface RecordMapper extends BaseMapper<Record> {


    @Select("select count(*) from record where in_date = DATE_FORMAT(NOW(), '%Y-%c-%d' )")
    int selectAll();

    @Select("select count(*) from record where in_date = DATE_FORMAT(NOW(), '%Y-%c-%d') and status = 5")
    int selectFix();

    @Select("select count(*) from record where id not in(select record_id from record_apply where apply_id = #{applyId})")
    int selectApplyRecordCount(int applyId);

    @Select("select * from record where id not in(select record_id from record_apply where apply_id = #{applyId}) limit #{start},#{end}  ")
    List<Record> selectApplyRecord2(int applyId ,Integer start,Integer end);


    @Select("select r.*,(select status from record_apply where apply_id = #{applyId} and  r.id = record_id order by id desc limit 1) as recordApplyStatus from record r   limit #{start},#{end}  ")
    List<Record> selectApplyRecord(int applyId ,Integer start,Integer end);


    @Select("select r.*,(select id from record_apply where apply_id = #{applyId} and  r.id = record_id order by id desc limit 1) as recordApplyId" +
            " from record r where " +
            "r.id in (select t2.* from(select ra.record_id from record_apply ra where ra.apply_id = #{applyId} and ra.status = 1 order by id desc ) as t2)  limit #{start},#{end}  ")
    List<Record> selectPassApplyRecord(int applyId ,Integer start,Integer end);

    @Select("select id from record  where user_id = #{user_id}   ")
    List<Integer> findStoreRecordIds(int user_id );

    @Select("select r.* from record r where r.sick_id = #{sickId} limit #{start},#{end}  ")
    List<Record> findPageMyRecord(int sickId ,Integer start,Integer end);

    @Select("update record set  status = 1 where id = #{id}")
    void updateRecordOutside(int id);

    @Select("update record set  in_status = 1 where id = #{id}")
    void recordIn(int id);

    @Select("update record set  in_status = 0 where id = #{id}")
    void handleOut(int id);

    @Select("update record set  in_status = 0 where id = #{id}")
    void rein(int id);

    @Select("update record_apply set status = 3 where id = #{id}")
    void reinApply(int id);


    @Select("update record set  status = #{status} where id = #{id}")
    void updateStatus(int id,int status);

}
