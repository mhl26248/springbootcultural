<template>
  <div style="padding: 10px">
    <el-form ref="form"   :model="form" label-width="80px">

      <el-form-item label="余额">
        <el-input v-model="form.account" disabled style="width: 30%"></el-input>
      </el-form-item>
      <el-form-item label="金额">
        <el-input v-model="form.add"  style="width: 30%"></el-input>
      </el-form-item>
      <el-form-item label="支付方式">
        <el-radio v-model="form.payType" label="支付宝">支付宝</el-radio>
        <el-radio v-model="form.payType" label="微信">微信</el-radio>
<!--        <el-radio v-model="form.payType" label="余额">余额</el-radio>-->
      </el-form-item>
    </el-form>

        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="save">确 定</el-button>
        </span>

  </div>
</template>

<script>

import request from "@/utils/request";

export default {
  name: 'Role',
  components: {},
  data() {
    return {
      loading: true,
      form: {
        recordLogs: [
          {
            desc: ""
          }
        ]},
      dialogVisible2: false,
      dialogVisible: false,
      search: '',
      currentPage: 1,
      pageSize: 10,
      total: 0,
      tableData: [],
      options: [],
      options2:[],
      userName:''
    }
  },
  created() {
    this.load()
  },
  methods: {

    save() {
      if(!this.form.add){
        this.$message({
          type: "error",
          message: '请填写充值金额'
        })
        return
      }

      this.form.account = parseInt(this.form.account)+parseInt(this.form.add)

      request.post("/user/updateaccount", this.form).then(res => {
        console.log(res)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "充值成功"
          })
          this.load() // 刷新表格的数据
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }

      })

    },

    load() {
      this.loading = true
      let userStr = sessionStorage.getItem("user") || "{}"
      this.form = JSON.parse(userStr)
      console.log(this.form)
      request.get("/user/"+this.form.id, {

      }).then(res => {
        this.form = res.data
        this.userName = this.form.username
        // this.form.account = user.account
        this.form.payType = '支付宝'
      })

    }
  }
}
</script>
