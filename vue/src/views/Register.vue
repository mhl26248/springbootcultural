<template>
  <div style="width: 100%; height: 100vh; overflow: hidden">
    <div style="width: 400px; margin: 100px auto">
      <div style="font-size: 30px; text-align: center; padding: 30px 0">欢迎注册</div>
      <el-form ref="form" :model="form" size="normal" :rules="rules">
        <el-form-item prop="username">
          <el-input prefix-icon="el-icon-user-solid" v-model="form.username" placeholder="请输入账号"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input prefix-icon="el-icon-lock" v-model="form.password" show-password></el-input>
        </el-form-item>
        <el-form-item prop="confirm">
          <el-input prefix-icon="el-icon-lock" v-model="form.confirm" show-password></el-input>
        </el-form-item>
<!--        <el-form-item prop="email">-->
<!--          <el-input v-model="form.email" placeholder="请输入邮箱"></el-input>-->
<!--          <el-button type="success" @click="send">发送</el-button>-->
<!--        </el-form-item>-->
<!--        <el-form-item prop="code">-->
<!--          <el-input  v-model="form.code" placeholder="请输入验证码"></el-input>-->
<!--        </el-form-item>-->
        <el-form-item>
          <el-button style="width: 100%" type="primary" @click="register">注册</el-button>
        </el-form-item>
        <el-form-item><el-button type="text" @click="$router.push('/login')">&lt;&lt;返回登录 </el-button></el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Register",
  data() {
    return {
      form: {},
      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
        ],
        confirm: [
          {required: true, message: '请确认密码', trigger: 'blur'},
        ],
        email: [
          {required: true, message: '请确认邮箱', trigger: 'blur'},
        ],
        code: [
          {required: true, message: '请确认验证码', trigger: 'blur'},
        ],
      }
    }
  },
  methods: {
    send(){
      if (!this.form.email ) {
        this.$message({
          type: "error",
          message: '请先输入邮箱！'
        })
        return
      }
      request.get("/user/sendmail", {
        params: {
          e: this.form.email
        }
      }).then(res => {
        this.$message({
          type: "success",
          message: '请去邮箱查看！'
        })
      })
    },
    register() {

      if (this.form.password !== this.form.confirm) {
        this.$message({
          type: "error",
          message: '2次密码输入不一致！'
        })
        return
      }

      this.$refs['form'].validate((valid) => {
        if (valid) {
          request.post("/user/register", this.form).then(res => {
            if (res.code === '0') {
              this.$message({
                type: "success",
                message: "注册成功"
              })
              this.$router.push("/login")  //登录成功之后进行页面的跳转，跳转到主页
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

</style>
