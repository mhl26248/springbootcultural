<template>
  <div style="padding: 10px">
    <el-table
        v-loading="loading"
        :data="tableData"
        stripe
        style="width: 100%">
      <el-table-column
          prop="id"
          label="订单编号">
      </el-table-column>
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
          prop="payType"
          label="支付方式">
      </el-table-column>
      <el-table-column
          label="折扣">
        <template #default="scope" >
          <el-tag>{{scope.row.diff}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
          prop="payAmt"
          label="已支付">
      </el-table-column>
      <el-table-column
          prop="created"
          label="日期">
      </el-table-column>


      <el-table-column label="操作" min-width="200px">
        <template #default="scope" >
<!--          <el-popconfirm title="确定取消吗？" v-if="scope.row.status == 0" @confirm="handleEdit(scope.row.id)">&ndash;&gt;-->
<!--            <template #reference>-->
<!--              <el-button size="mini" type="info">取消</el-button>-->
<!--            </template>-->
<!--          </el-popconfirm>-->
            <el-button size="mini" v-if="scope.row.comments == null" @click="pj(scope.row)">评价</el-button>
          <el-button size="mini" type="danger" v-if="scope.row.comments != null" @click="pj2(scope.row)">查看评价</el-button>
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

    <el-dialog title="评价" v-model="dialogVisible" width="70%">
      <el-form ref="form"   :model="form" label-width="90px">
        <el-form-item label="商品">
          <el-input v-model="form.title" disabled style="width: 30%"></el-input>
        </el-form-item>
        <el-form-item label="图片">
          <img :src="form.images" style="width: 200px;height: 200px">
        </el-form-item>
        <el-form-item label="评价">
          <textarea cols="10" rows="10" v-model="form.remark"  style="width: 30%"></textarea>
        </el-form-item>
        <el-form-item label="评分">
          <el-input v-model="form.score"  style="width: 30%"></el-input>
        </el-form-item>
      </el-form>

      <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" v-if="form.comments == null" @click="save">确 定</el-button>
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
    pj(row){
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
    },
    pj2(row){
      this.form = JSON.parse(JSON.stringify(row))
      this.form.remark = this.form.comments.remark
      this.form.score = this.form.comments.score
      this.dialogVisible = true
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
      request.get("/recordApply/findPage", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search2: user.id
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
    save() {
      let userStr = sessionStorage.getItem("user") || "{}"
      let user = JSON.parse(userStr)

      let req = {}
      req.userId = user.id
      req.recordId = this.form.id
      req.remark = this.form.remark
      req.score = this.form.score

      request.post("/comment/save", req).then(res => {
        console.log(res)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "评价成功"
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
    handleUpdate(row){
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible2 = true
    },
    handleEdit(id) {
      request.get("/recordApply/deleteById", {
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
