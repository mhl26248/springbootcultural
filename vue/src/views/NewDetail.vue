<template>
  <el-container>
    <el-container>
    <el-aside width="500px" style="padding-top: 100px;height: 450px">
      <img :src="detail.defaultImage" style="height: 220px"  class="image">
    </el-aside>
      <div  style="height: 50px;padding-top: 120px" >
        <div style="font-size: 20px;padding-left: 30px">{{ detail.title}}</div>
        <div style="font-size: 10px;padding-left: 30px;padding-top: 40px">
          <span>作者：{{ detail.author}}&nbsp;</span>
          <span style="padding-left: 100px">日期：{{ detail.time}}</span>
        </div>
      </div>
    </el-container>
    <el-footer >
      <el-card class="box-card"  shadow="hover">
        <div slot="header" >
          <span style="font-size: 30px">详情</span>
        </div>
        <div v-html="detail.content" style="min-height: 100px"></div>

      </el-card>


    </el-footer>

  </el-container>


</template>

<script>

import request from "@/utils/request";

export default {
  name: 'Role',
  components: {},
  data() {
    return {
      dialogFormVisible: false,
      entity: {},
      comments:{},
      activeNames:[],
      detail:{},
      form:{},
      user: {},
      messages:[],
      dialogVisible:false
    }
  },
  created() {
    this.user = sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {};
    this.load()
    // this.loadMessage()
  },
  methods: {
    reply() {
      this.entity.content = this.entity.reply;
      this.save();
    },

    save() {
      if (!this.user.username) {
        this.$message({
          message: "请登录",
          type: "warning"
        });
        return;
      }
      if (!this.entity.content) {
        this.$message({
          message: "请填写内容",
          type: "warning"
        });
        return;
      }
      this.entity.recordId = this.detail.id
      this.entity.username = this.user.username
      // 如果是评论的话，在 save的时候要注意设置 当前模块的id为 foreignId。也就是  entity.foreignId = 模块id
      request.post("/message/save", this.entity).then(res => {
        if (res.code === '0') {
          this.$message({
            message: "评论成功",
            type: "success"
          });
        } else {
          this.$message({
            message: res.msg,
            type: "error"
          });
        }
        this.entity = {}
        this.loadMessage();
        this.dialogFormVisible = false;
      })
    },
    loadMessage() {
      // 如果是留言的话，就写死=0
      // 如果是 评论，则需要设置 当前被评论的模块的id作为foreignId
      request.get("/message/findPage?search=" + this.detail.id).then(res => {
        this.messages = res.data.records;
      })

      // request.get("/comment/findPage", {
      //   params: {
      //     search2: this.$route.query.sid
      //   }
      // }).then(res => {
      //   this.activeNames = res.data.records
      // })
    },
    load() {
      request.get("/news/getById", {
        params: {
          id: this.$route.query.sid
        }
      }).then(res => {
        this.detail = res.data
      })

    },
    book() {
      this.form = this.detail
      this.dialogVisible = true
      this.fileList = []
      this.options = []
      this.form.payType = '支付宝'
      this.initProductImgs();
    },
    like() {
      let userStr = sessionStorage.getItem("user") || "{}"
      console.log(userStr)
      let user = JSON.parse(userStr)
      this.userName = user.username
      this.form.userId = user.id
      this.form.recordId = this.detail.id

      request.post("/like/save", this.form).then(res => {
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "收藏成功"
          })

        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
      })
    },

  }
}
</script>
<style>
.el-header, .el-footer {
  /*background-color: #B3C0D1;*/
  /*color: #333;*/
  text-align: center;
  line-height: 60px;
}

.el-aside {
  /*background-color: #D3DCE6;*/
  /*color: #333;*/
  text-align: center;
  line-height: 160px;
}

.el-main {
  /*background-color: #E9EEF3;*/
  /*color: #333;*/
  text-align: center;
  line-height: 160px;
}

body > .el-container {
  margin-bottom: 40px;
}

.el-container:nth-child(5) .el-aside,
.el-container:nth-child(6) .el-aside {
  line-height: 260px;
}

.el-container:nth-child(7) .el-aside {
  line-height: 320px;
}
.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both
}

.box-card {
  text-align: left;
  width: 100%;
}
</style>
