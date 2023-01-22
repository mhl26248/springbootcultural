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
        <el-button type="danger" @click="like()" class="button">收藏</el-button>
      </el-footer>
    </el-container>
  </el-container>


  <el-dialog title="下单" v-model="dialogVisible" width="70%">
    <el-form ref="form"   :model="form" label-width="80px">
      <el-form-item label="标题">
        <el-input v-model="form.title" disabled style="width: 30%"></el-input>
      </el-form-item>
      <el-form-item label="图片">
        <img :src="form.images" style="width: 200px;height: 200px">
      </el-form-item>
      <el-form-item label="单价">
        <el-input v-model="form.price" disabled style="width: 30%"></el-input>
      </el-form-item>
      <el-form-item label="折扣">
        <el-input v-model="form.diff" disabled style="width: 30%"></el-input>
      </el-form-item>
      <el-form-item label="待支付">
          <span v-if="form.diff">
          {{form.diff*form.price}}
          </span>
        <span v-if="!form.diff">
          {{form.price}}
          </span>
      </el-form-item>
      <el-form-item label="支付方式">
        <el-radio v-model="form.payType" label="支付宝">支付宝</el-radio>
        <el-radio v-model="form.payType" label="微信">微信</el-radio>
      </el-form-item>
      <!--        <el-form-item label="预约日期">-->
      <!--          <el-date-picker-->
      <!--              value-format="YYYY-MM-DD"-->
      <!--              v-model="form.applyTime"-->
      <!--              type="date"-->
      <!--              placeholder="选择日期">-->
      <!--          </el-date-picker>-->
      <!--        </el-form-item>-->
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
      form:{},
      dialogVisible:false
    }
  },
  created() {
    this.load()
  },
  methods: {

    load() {
      request.get("/record/getById", {
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
    save() {
      let userStr = sessionStorage.getItem("user") || "{}"
      let user = JSON.parse(userStr)

      let req = {}
      req.applyId = user.id
      req.recordId = this.form.id
      req.applyTime = this.form.applyTime
      if(this.form.diff >0 && this.form.diff<1){
        req.payAmt = this.form.price*this.form.diff
      }else{
        req.payAmt = this.form.price
      }
      req.payType = this.form.payType
      req.payPrice = this.form.price
      req.payDiff = this.form.diff

      request.post("/recordApply/save", req).then(res => {
        console.log(res)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "下单成功"
          })
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }

        this.load() // 刷新表格的数据
        this.dialogVisible = false  // 关闭弹窗
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
