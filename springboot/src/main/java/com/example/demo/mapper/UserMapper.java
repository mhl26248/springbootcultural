package com.example.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.controller.dto.UserAddressDto;
import com.example.demo.entity.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

public interface UserMapper extends BaseMapper<User> {
    // 一对多查询
    Page<User> findPage(Page<User> page, @Param("nickName") String nickName);

    @Select("select count(id) count, address from member GROUP BY address")
    List<UserAddressDto> countAddress();

    // 查询用户名
    @Select("select password from user where username=#{username}")
    User selectByName(String username);

    @Update("update user set password = #{newPass} where id = #{userId}")
    int updatePass(Map<String, Object> map);

    @Select("select * from user u " +
            " left join user_role ur on u.id = ur.user_id" +
            " where ur.role_id = 2 and ISNULL(place_id)")
    List<User> getPlaceManager();



//    @Update("select id from user where place_id=#{place_id})")
//    List<Integer> queryIdFromPlace(int place_id);

    @Update("update user set place_id = null where id = (select id from (" +
            "select id from user u left join user_role ur on u.id = ur.user_id  where place_id= #{place_id} and ur.role_id = 2 limit 1)  tmp)")
    int resetPlace(int place_id);

    @Update("update user set place_id = #{place_id} where id = #{userId}")
    int updatePlace(Integer place_id,int userId);


    @Select("select id from user where driver_id=#{driver_id}")
    int selectIdByDriverid(int driver_id);

    @Select("select place_id from user where driver_id=#{driver_id}")
    Integer getPlaceIdByDriverId(int driver_id);
}
