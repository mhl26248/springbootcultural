<template>
  <div  class="homepage-hero-module">
    <div class="video-container">
      <div :style="bg"  class="filter">
        <div style="width: 400px; margin: 100px auto">
          <div style="font-size: 30px; text-align: center; padding: 30px 0; color: #333">非遗申报平台</div>
          <el-form ref="form" :model="form" size="normal" :rules="rules">
            <el-form-item prop="username">
              <el-input prefix-icon="el-icon-user-solid" v-model="form.username" placeholder="请输入账号"></el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input prefix-icon="el-icon-lock" v-model="form.password" show-password placeholder="请输入密码"></el-input>
            </el-form-item>
<!--            <el-form-item>-->
<!--              <div style="display: flex">-->
<!--                <el-input prefix-icon="el-icon-key" v-model="form.validCode" style="width: 50%;" placeholder="请输入验证码"></el-input>-->
<!--                <ValidCode @input="createValidCode" />-->
<!--              </div>-->
<!--            </el-form-item>-->
<!--            <el-form-item>-->
<!--              <el-radio v-model="form.role" :label="1" style="color: white">管理员</el-radio>-->
<!--              <el-radio v-model="form.role" :label="2" style="color: white">普通用户</el-radio>-->
<!--            </el-form-item>-->
            <el-form-item>
              <el-button style="width: 40%" type="primary" @click="login">登 录</el-button>
<!--              <el-button style="width: 30%" type="success" @click="register">注 册</el-button>-->
              <el-button style="width: 20%" @click="$router.push('/index')">首页</el-button>
            </el-form-item>
            <el-form-item><el-button type="text" @click="$router.push('/register')">前往注册 >> </el-button></el-form-item>
          </el-form>
        </div>

      </div>

    </div>
  </div>

</template>

<script>
import request from "@/utils/request";
import ValidCode from "@/components/ValidCode";
import {activeRouter} from "@/utils/permission";

export default {
  name: "Login",
  components: {
    ValidCode,
  },
  data() {
    return {
      vedioCanPlay: false,
      fixStyle: '',
      form: {role: 1},
      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
        ],
      },
      validCode: '',
      // 加背景图片
      bg: {
        // backgroundColor: "red",
        // backgroundImage: "url(" + require("@/assets/1.jpeg") + ")",
        backgroundRepeat: "no-repeat",
        backgroundSize: "100% 150%"
      }
    }
  },
  mounted() {
    sessionStorage.removeItem("user")

    window.onresize = () => {
      const windowWidth = document.body.clientWidth
      const windowHeight = document.body.clientHeight
      const windowAspectRatio = windowHeight / windowWidth
      let videoWidth
      let videoHeight
      if (windowAspectRatio < 0.5625) {
        videoWidth = windowWidth
        videoHeight = videoWidth * 0.5625
        this.fixStyle = {
          height: windowWidth * 0.5625 + 'px',
          width: windowWidth + 'px',
          'margin-bottom': (windowHeight - videoHeight) / 2 + 'px',
          'margin-left': 'initial'
        }
      } else {
        videoHeight = windowHeight
        videoWidth = videoHeight / 0.5625
        this.fixStyle = {
          height: windowHeight + 'px',
          width: windowHeight / 0.5625 + 'px',
          'margin-left': (windowWidth - videoWidth) / 2 + 'px',
          'margin-bottom': 'initial'
        }
      }
    }
    window.onresize()
  },
  methods: {
    canplay() {
      this.vedioCanPlay = true
    },
    // 接收验证码组件提交的 4位验证码
    createValidCode(data) {
      this.validCode = data
    },
    register(){
      this.$refs['form'].validate((valid) => {
        if (valid) {
          request.post("/user/register", this.form).then(res => {
            if (res.code === '0') {
              this.$message({
                type: "success",
                message: "注册"
              })
              sessionStorage.setItem("user", JSON.stringify(res.data))  // 缓存用户信息

              // 登录成功的时候更新当前路由
              activeRouter()
              this.$router.push("/")  //登录成功之后进行页面的跳转，跳转到主页

            } else {
              this.$message({
                type: "error",
                message: res.msg
              })
            }
          })
        }
      })
    },
    login () {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          request.post("/user/login", this.form).then(res => {
            if (res.code === '0') {
              this.$message({
                type: "success",
                message: "登录成功"
              })
              sessionStorage.setItem("user", JSON.stringify(res.data))  // 缓存用户信息

              // 登录成功的时候更新当前路由
              activeRouter()
              if(this.form.username == 'admin'){
                this.$router.push("/")  //登录成功之后进行页面的跳转，跳转到主页
              }
              else if(res.data.roles[0] == 6){
                this.$router.push("/")  //登录成功之后进行页面的跳转，跳转到主页
              }
              else{
                this.$router.push("/Index")  //登录成功之后进行页面的跳转，跳转到主页
              }

            } else {
              this.$message({
                type: "error",
                message: res.msg
              })
            }
          })
        }
      })
    }
  }
}
</script>

<style scoped>
.homepage-hero-module,
.video-container {
  position: relative;
  height: 100vh;
  overflow: hidden;
}

.video-container .poster img{
  z-index: 0;
  position: absolute;
}

.video-container .filter {
  z-index: 1;
  position: absolute;
  background: darkslategray;
  width: 100%;
  height: 100%;
}

.fillWidth {
  width: 100%;
}
</style>
