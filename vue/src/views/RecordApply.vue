<template>
  <div style="padding: 10px">
    <!--    功能区域-->
<!--    <div style="margin: 10px 0">-->
<!--    </div>-->

    <!--    搜索区域-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="请输入关键字" style="width: 20%" clearable></el-input>
      <el-button type="primary" style="margin-left: 5px" @click="load">查询</el-button>
<!--      <el-button type="primary" @click="add">新增</el-button>-->
    </div>
    <el-table
        v-loading="loading"
        :data="tableData"
        border
        stripe
        style="width: 100%">
      <el-table-column
          prop="recordNo"
          label="实训号">
      </el-table-column>
      <el-table-column
          prop="inRemark"
          label="实训说明">
      </el-table-column>
      <el-table-column
          prop="sickName"
          label="学生">
      </el-table-column>
      <el-table-column
          prop="doctorName"
          label="老师">
      </el-table-column>
      <el-table-column
          label="申请状态">
        <template #default="scope" >
          <el-tag v-if="scope.row.recordApplyStatus == 0">申请中</el-tag>
          <el-tag v-if="scope.row.recordApplyStatus == 1">通过</el-tag>
          <el-tag type="info" v-if="scope.row.recordApplyStatus == 2">拒绝</el-tag>
          <el-tag type="info" v-if="scope.row.recordApplyStatus == 3">归还</el-tag>
          <el-tag type="danger" v-if="scope.row.recordApplyStatus == null">未申请</el-tag>
        </template>
      </el-table-column>

      <el-table-column label="操作" min-width="200px">
        <template #default="scope" >
          <el-button v-if="userName != 'admin' && (scope.row.recordApplyStatus == null || scope.row.recordApplyStatus == 2|| scope.row.recordApplyStatus == 3)" @click="handleApply(scope.row,1)" size="mini" type="danger">申请实训</el-button>
<!--          <el-button v-if="scope.row.recordApplyStatus == 1" size="mini" type="danger">查看</el-button>-->
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

    <el-dialog title="提示" v-model="dialogVisible" width="70%">

      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="病人">
          <el-select v-model="form.sickId">
            <el-option
                v-for="item in options"
                :key="item.username"
                :label="item.username"
                :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="病例备注">
          <el-input v-model="form.remark" style="width: 80%"></el-input>
        </el-form-item>
        <div v-for="(item, index) in form.recordLogs" :key="index">

          <el-form-item
              label="病例详情"
          >
            <el-input v-model="item.remark"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button v-if="index+1 == form.recordLogs.length" @click="addItem" type="primary">增加</el-button>
            <el-button v-if="index !== 0" @click="deleteItem(item, index)" type="danger">删除</el-button>
          </el-form-item>
        </div>
      </el-form>

      <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
          </span>
      </template>
    </el-dialog>

    <el-dialog title="审核" v-model="dialogVisible2" width="70%">
      <el-form ref="form"   :model="form" label-width="80px">
        <el-form-item label="申请人">
          <el-select v-model="form.applyId">
            <el-option
                v-for="item in options2"
                :key="item.username"
                :label="item.username"
                :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="form.remark" style="width: 80%"></el-input>
        </el-form-item>

      </el-form>

      <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">拒绝</el-button>
            <el-button type="primary" @click="save">通过</el-button>
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
      request.get("/record/findPageUserId", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          userId: user.id
        }
      }).then(res => {
        this.loading = false
        this.tableData = res.data.records
        this.total = res.data.total
      })

      request.get("/user/allSick", {
        params: {
        }
      }).then(res => {
        this.options = res.data
      })


      // request.get("/user/all", {
      //   params: {
      //   }
      // }).then(res => {
      //   this.options2 = res.data
      // })

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
      if (this.form.id) {  // 更新
        request.post("/record/update", this.form).then(res => {
          console.log(res)
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "更新成功"
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
      } else {  // 新增
        let userStr = sessionStorage.getItem("user") || "{}"
        let user = JSON.parse(userStr)
        this.form.doctorId = user.id

        request.post("/record/save", this.form).then(res => {
          console.log(res)
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "新增成功"
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
      }

    },
    handleUpdate(row){
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible2 = true
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
    },
    handleApply(row,type) {
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
