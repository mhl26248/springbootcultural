<template>
  <el-container>
    <el-aside width="500px" style="padding-top: 100px;">
      <img :src="detail.images" style="height: 220px"  class="image">
    </el-aside>
    <el-container>
      <el-main >
        <el-descriptions class="margin-top" title="商品详情" :column="4" direction="vertical">
          <el-descriptions-item label="标题" :span="4">{{ detail.title}}</el-descriptions-item>
          <el-descriptions-item label="价格" :span="4"><font color="red">{{ detail.price}}</font></el-descriptions-item>
          <el-descriptions-item label="折扣" :span="4"><el-tag>{{ detail.diff}}</el-tag></el-descriptions-item>
<!--          <el-descriptions-item label="备注">-->
<!--            <el-tag size="small">{{ detail.remark}}</el-tag>-->
<!--          </el-descriptions-item>-->
          <el-descriptions-item label="详情" :span="2">{{ detail.remark}}</el-descriptions-item>
        </el-descriptions>

      </el-main>
      <el-footer>
        <el-button type="success" @click="book()">购买</el-button>
<!--        <el-button type="text" @click="book()" class="button">预约</el-button>-->
      </el-footer>
    </el-container>
  </el-container>

  <el-dialog title="预约" v-model="dialogVisible" width="70%">

    <el-form ref="form"   :model="detail" label-width="80px">


      <el-form-item label="标题">
        <el-input v-model="detail.title" style="width: 30%"></el-input>
      </el-form-item>
      <el-form-item label="图片">
        <img :src="detail.images" style="width: 200px;height: 200px">

      </el-form-item>
      <el-form-item label="预约日期">
        <el-date-picker
            value-format="YYYY-MM-DD"
            v-model="detail.applyTime"
            type="date"
            placeholder="选择日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="数量">
        <el-input-number v-model="num" @change="handleChange" :min="1" :max="10" label="描述文字"></el-input-number>
      </el-form-item>
    </el-form>

    <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
          </span>
    </template>
  </el-dialog>
</template>

<script>

import request from "@/utils/request";

export default {
  name: 'Role',
  components: {},
  data() {
    return {
      detail:{},
      dialogVisible:false
    }
  },
  created() {
    this.load()
  },
  methods: {

    load() {
      console.log(this.$route.query.sid)
      let userStr = sessionStorage.getItem("user") || "{}"
      let user = JSON.parse(userStr)
      this.userName = user.username
      request.get("/record/getById", {
        params: {
          id: this.$route.query.sid
        }
      }).then(res => {
        this.detail = res.data
      })
    },
    book(row) {
      // this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
      this.fileList = []
      this.options = []
      this.initProductImgs();
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
  line-height: 200px;
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
</style>
