<template>
  <div style="height: 70px; line-height: 50px; border-bottom: 1px solid #ccc; display: flex">
    <div style="width: 100px;flex: 1; padding-left: 30px; font-weight: bold; color: dodgerblue">
<!--      非遗申报平台-->
<img style="width: 440px;" src="http://127.0.0.1:9091/files/11.png">
<!--      <div style="margin: 10px 0" v-if="user.nickName!='管理员'" >-->
<!--        <el-input v-if="user.nickName!='管理员'" v-model="search" placeholder="请输入商品名称" style="width: 50%" clearable></el-input>-->
<!--        <el-button v-if="user.nickName!='管理员'" type="primary" style="margin-left: 5px" @click="load">查询</el-button>-->
<!--      </div>-->

<!--      <el-tag>{{city}}-->
<!--        {{weather}}</el-tag>-->
    </div>
<!--    <div style="padding-left: 10px">-->
<!--      <el-tag>{{city}}-->
<!--        {{weather}}</el-tag>-->
<!--    </div>-->
    <div style="flex: 1;width: 250px; padding-left: 30px;">
      <el-menu v-if="user!='' && user.nickName!='管理员' && role != 6" :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
        <el-menu-item index="1" >首页</el-menu-item>
        <el-menu-item index="2" >公告</el-menu-item>
        <el-menu-item index="3">文化资讯</el-menu-item>
        <el-menu-item index="4">申报</el-menu-item>
        <el-menu-item index="5">我的资讯</el-menu-item>
<!--        <el-menu-item index="6">发表资讯</el-menu-item>-->
      </el-menu>

      <el-menu v-if="user==''" :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
        <el-menu-item index="1" >首页</el-menu-item>
        <el-menu-item index="2" >公告</el-menu-item>
        <el-menu-item index="3">文化资讯</el-menu-item>
        <el-menu-item index="4">申报</el-menu-item>
        <el-menu-item index="5">我的资讯</el-menu-item>
<!--        <el-menu-item index="6">发表资讯</el-menu-item>-->
      </el-menu>
    </div>


    <div style="width: 100px" v-if="user!=''">
      <el-dropdown>
        <span class="el-dropdown-link" >
          <el-avatar :size="30" :src="user.avatar" style="position: relative; top: 10px"></el-avatar>
           {{ user.nickName }}
          <i class="el-icon-arrow-down el-icon--right"></i>
        </span>
        <template #dropdown>
          <el-dropdown-menu >
            <el-dropdown-item v-if="user.nickName!='管理员'" @click="$router.push('/person')">个人信息</el-dropdown-item>
            <el-dropdown-item @click="$router.push('/password')">修改密码</el-dropdown-item>
            <el-dropdown-item @click="$router.push('/login')">退出系统</el-dropdown-item>
          </el-dropdown-menu>

        </template>
      </el-dropdown>
    </div>

    <div style="width: 100px" v-if="user==''">
            <el-button @click="$router.push('/login')">登录</el-button>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import request from "@/utils/request";
export default {
  name: "Header",
  props: ['user'],
  data() {
    return {
      activeIndex:'1',
      role:0,
      city:'',
      weather:{}
    }
  },
  created() {
    this.refreshUser()
    // this.getWeather2()
  },
  methods: {
    getWeather:function(){
      var that = this;
      var url = "https://apia.aidioute.cn/weather/?location_type=0&from=vmweather";

      axios.get(url).then(response=>{
        console.log(response.data);
        that.city = response.data.data.location.city
        that.weather=response.data.data.weather.weather+"/"+response.data.data.weather.WD+response.data.data.weather.WS;
      }).catch(error=>console.log(err));
    },
    getWeather2:function(){
      request.get("/record/getWeather?city=101010100").then(res => {
        this.city = res.data.weatherinfo.city
        this.weather = res.data.weatherinfo.weather+"("+res.data.weatherinfo.temp1+"-"+res.data.weatherinfo.temp2+")"
      })
    },
    refreshUser() {

      if(sessionStorage.getItem("activeIndex")){
        this.activeIndex = sessionStorage.getItem("activeIndex")
      }
      let userJson = sessionStorage.getItem("user");
      // console.log(JSON.parse(userJson).roles[0])
      if (!userJson) {
        return
      }
      this.role = JSON.parse(userJson).roles[0]
    },
    handleSelect(key, keyPath) {
      console.log(key, keyPath);
      sessionStorage.setItem("activeIndex",key)
      if(key == '3'){
        this.$router.push('/NewList');
      }
      else if(key == '2'){
        this.$router.push('/NoticeList');
      }
      else if(key == '1'){
        this.$router.push('/Index');
      }
      else if(key == '4'){
        this.$router.push('/MyRecord');
      }
      else if(key == '5'){
        this.$router.push('/MyNew');
      }
      // else if(key == '6'){
      //   this.$router.push('/Charge');
      // }
    }
  }
}
</script>

<style scoped>

</style>
