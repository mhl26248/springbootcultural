<template>
  <div>
    <!--    头部-->
    <Header :user="user"/>
<!--    <v-mini-weather></v-mini-weather>-->
    <!--    主体-->
    <div style="display: flex"  v-if="role != 2">
      <!--      侧边栏-->
      <Aside/>
<!--      <Aside />-->
      <!--      内容区域-->
      <router-view style="flex: 1" @userInfo="refreshUser"/>
    </div>

    <div  v-if="role == 2 ">
      <!--      内容区域-->
      <router-view style="flex: 1" @userInfo="refreshUser"/>
    </div>
  </div>
</template>

<script>
import Header from "@/components/Header";
import Aside from "@/components/Aside";
import request from "@/utils/request";

import axios from "axios";

export default {
  name: "Layout",
  components: {
    Header,
    Aside,
  },
  data() {
    return {
      user: {},
      role: {},
    }
  },
  created() {
    this.refreshUser()
    // this.getWeather()
  },
  methods: {

    refreshUser() {
      let userJson = sessionStorage.getItem("user");

      console.log(JSON.parse(userJson).roles[0])
      if (!userJson) {
        return
      }
      let userId = JSON.parse(userJson).id
      this.role = JSON.parse(userJson).roles[0]
      // 从后台取出更新后的最新用户信息
      request.get("/user/" + userId).then(res => {
        this.user = res.data
      })
    }
  }
}
</script>

<style scoped>

</style>
