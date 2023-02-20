<template>
  <el-container>
    <el-container>
    <el-aside width="500px" style="padding-top: 100px;height: 450px">
      <img :src="detail.images" style="height: 220px"  class="image">
    </el-aside>
      <el-main style="padding-top: 80px;height: 450px">
        <el-card class="box-card" style="height: 250px" border="0"  shadow="hover">
          <div  style="height: 50px"  class="text item">
            <div style="font-size: 30px">{{ detail.title}}</div>
          </div>

          <div  style="height: 50px"  class="text item">
            分类:&nbsp;&nbsp;&nbsp;&nbsp;<el-tag>{{ detail.type}}</el-tag>
          </div>
          <div  style="height: 50px"  class="text item">

          </div>
          <div  style="height: 70px"  >
          </div>
        </el-card>

      </el-main>
    </el-container>
    <el-footer >
      <el-card class="box-card"  shadow="hover">
        <div slot="header" >
          <span style="font-size: 30px">详情</span>
        </div>
        <div  style="font-size: 15px">
          {{ detail.remark}}
        </div>
      </el-card>
      <el-card>
        <div style="padding: 20px; color: #888">
          <div>
            <el-input type="textarea" :rows="3" v-model="entity.content"></el-input>
            <div style="text-align: right; padding: 10px"><el-button type="primary" @click="save">留言</el-button></div>
          </div>
        </div>

        <div class="block" style="text-align: left">
          <el-timeline v-for="item in messages">
            <el-timeline-item  placement="top">
              <el-card>
                <h4><el-image :src="item.userHead" style="width: 100px; border-radius: 50%"></el-image>
                  {{ item.username }}</h4> {{item.created}}
                <p>{{ item.content }}</p>
              </el-card>
            </el-timeline-item>

          </el-timeline>
        </div>


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
    this.loadMessage()
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
      this.entity.userHead = this.user.avatar
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
      request.get("/record/getById", {
        params: {
          id: this.$route.query.sid
        }
      }).then(res => {
        this.detail = res.data
      })
      request.get("/comment/findPage", {
        params: {
          search2: this.$route.query.sid
        }
      }).then(res => {
        this.activeNames = res.data.records
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
