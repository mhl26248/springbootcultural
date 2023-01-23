<template>
  <div style="padding: 10px">
    <el-table
        v-loading="loading"
        :data="tableData"
        stripe
        style="width: 100%">
      <el-table-column
          label="图片">
        <template #default="scope" >
          <img :src="scope.row.images" style="width: 50px">
        </template>
      </el-table-column>
      <el-table-column
          prop="title"
          label="名称">
      </el-table-column>
      <el-table-column
          label="状态">
        <template #default="scope" >
          <el-tag v-if="scope.row.status == 0" >上架中</el-tag>
          <el-tag v-if="scope.row.status == 1" type="danger">已下架</el-tag>
        </template>
      </el-table-column>
      <el-table-column
          prop="price"
          label="单价">
      </el-table-column>
      <el-table-column
          label="折扣">
        <template #default="scope" >
          <el-tag>{{scope.row.diff}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
          prop="created"
          label="日期">
      </el-table-column>
      <el-table-column label="操作" min-width="200px">
        <template #default="scope" >
          <el-popconfirm title="确定取消吗？" @confirm="handleEdit(scope.row.id)">
            <template #reference>
              <el-button size="mini" type="info">取消</el-button>
            </template>
          </el-popconfirm>
          <el-button  class="button" @click="book(scope.row)">购买</el-button>
        </template>
      </el-table-column>
    </el-table>

    <div style="margin: 10px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          :page-sizes="[5, 10, 20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </div>
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

    book(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.form.payType = '支付宝'
      this.dialogVisible = true
      this.fileList = []
      this.options = []
    },
    save() {
      let userStr = sessionStorage.getItem("user") || "{}"
      let user = JSON.parse(userStr)

      let req = {}
      req.applyId = user.id
      req.recordId = this.form.recordId
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
    addItem() {
      this.form.recordLogs.push({
        desc: ""
      });
    },
    sure(form) {
      console.log(this.form.recordLogs.length, "length");
      this.$refs[form].validate(valid => {
        if (valid) {
          alert("submit!");
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    deleteItem(item, index) {
      this.form.recordLogs.splice(index, 1);
      console.log(this.form.recordLogs, "删除");
    },
    handleChange(row) {
      request.put("/role/changePermission", row).then(res => {
        if (res.code === '0') {
          this.$message.success("更新成功")
          if (res.data) {
            this.$router.push("/login")
          }
        }
      })
    },
    load() {
      this.loading = true
      let userStr = sessionStorage.getItem("user") || "{}"
      let user = JSON.parse(userStr)
      this.userName = user.username
      request.get("/like/findPage", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: user.id
        }
      }).then(res => {
        this.loading = false
        this.tableData = res.data.records
        this.total = res.data.total
      })



    },
    add() {
      this.dialogVisible = true
      this.form =  {
        recordLogs: [
          {
            name: "",
            phone: ""
          }
        ]}
      // this.addItem()
    },

    handleUpdate(row){
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible2 = true
    },
    handleEdit(id) {
      request.get("/like/deleteById", {
        params: {
          id: id
        }
      }).then(res => {
        this.$message({
          type: "success",
          message: "取消成功"
        })
        this.load() // 刷新表格的数据
      })
    },
    handleApply(row) {
      let userStr = sessionStorage.getItem("user") || "{}"
      let user = JSON.parse(userStr)
      this.form = {}
      this.form.applyId = user.id
      this.form.recordId = row.id
      this.form.sickId = row.sickId
      this.form.type = type
      request.post("/recordApply/save" ,this.form).then(res => {
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "申请成功"
          })
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.load()  // 删除之后重新加载表格的数据
      })
    },
    handleSizeChange(pageSize) {   // 改变当前每页的个数触发
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) {  // 改变当前页码触发
      this.currentPage = pageNum
      this.load()
    }
  }
}
</script>
