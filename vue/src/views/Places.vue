<template>
  <div style="padding: 10px">

    <!--    搜索区域-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="请输入关键字" style="width: 20%" clearable></el-input>
      <el-button type="primary" style="margin-left: 5px" @click="load">查询</el-button>
      <el-button type="primary" @click="add">新增</el-button>
    </div>
    <el-table
        v-loading="loading"
        :data="tableData"
        border
        stripe
        style="width: 100%">
      <el-table-column
          prop="id"
          label="ID"
          sortable
      >
      </el-table-column>
      <el-table-column
          prop="placeName"
          label="站点名称">
      </el-table-column>
      <el-table-column
          prop="city"
          label="城市">
      </el-table-column>
      <el-table-column
          prop="area"
          label="区域">
      </el-table-column>
      <el-table-column
          prop="placeLocation"
          min-width="200"
          label="位置">
      </el-table-column>
      <el-table-column
          prop="managerName"
          label="负责人">
      </el-table-column>
      <el-table-column
          prop="workTime" min-width="100"
          label="工作时间">
      </el-table-column>
      <el-table-column label="操作" width="400">
        <template #default="scope">
          <el-button size="mini" @click="handleEdit1(scope.row)">编辑</el-button>
          <el-popconfirm title="确定删除吗？" @confirm="handleDelete(scope.row.id)">
            <template #reference>
              <el-button size="mini" type="danger">删除</el-button>
            </template>
          </el-popconfirm>
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


    <el-dialog title="用户拥有的图书列表" v-model="bookVis" width="30%">
      <el-table :data="bookList" stripe border>
        <el-table-column prop="id" label="ID"></el-table-column>
        <el-table-column prop="name" label="名称"></el-table-column>
        <el-table-column prop="price" label="价格"></el-table-column>
      </el-table>
    </el-dialog>

    <el-dialog title="提示" v-model="dialogVisible" width="40%">
      <el-form :model="form" label-width="120px">
        <el-form-item label="站点名称">
          <el-input v-model="form.placeName" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="城市">
          <el-input v-model="form.city" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="区域">
          <el-input v-model="form.area" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="位置">
          <el-input v-model="form.placeLocation" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="负责人">
          <el-select v-model="form.managerName" @change="resetManagerId">
            <el-option
                v-for="item in options2"
                :key="item.username"
                :label="item.username"
                :value="item">
            </el-option>
          </el-select>
<!--          <el-input type="hidden" v-model="form.managerId" style="width: 80%"></el-input>-->
        </el-form-item>
        <el-form-item label="工作时间">
          <el-input v-model="form.workTime" style="width: 80%"></el-input>
        </el-form-item>
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
  name: 'Home',
  components: {},
  data() {
    return {
      options2:[],
      loading: true,
      form: {},
      dialogVisible: false,
      bookVis: false,
      search: '',
      currentPage: 1,
      pageSize: 10,
      total: 0,
      tableData: [],
      bookList: [],
      roles: []
    }
  },
  created() {
    this.load()
  },
  methods: {

    showBooks(books) {
      this.bookList = books
      this.bookVis = true
    },
    load() {
      this.loading = true
      request.get("/places/findPage", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res => {
        this.loading = false
        this.tableData = res.data.records
        this.total = res.data.total
      })
    },
    handleUploadSuccess(res) {
      if (res.code === "0") {
        this.$message.success("导入成功")
        this.load()
      }
    },
    exportUser() {
      location.href = "http://" + window.server.filesUploadUrl + ":9090/user/export";
    },
    add() {
      request.get("/user/getAllPlaceManager", {
        params: {
        }
      }).then(res => {
        this.options2 = res.data
      })
      this.dialogVisible = true
      this.form = {}
    },
    resetManagerId(value){
      console.log(value.username)
      console.log(value.id)
      this.form.managerId = value.id;
      this.form.managerName = value.username;
    },
    save() {
      if (this.form.id) {  // 更新
        request.post("/places/update", this.form).then(res => {
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
        request.post("/places/save", this.form).then(res => {
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
    handleEdit1(row) {
      request.get("/user/getAllPlaceManager", {
        params: {
        }
      }).then(res => {
        this.options2 = res.data
      })
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true

    },
    handleDelete(id) {
      console.log(id)
      request.delete("/places/" + id).then(res => {
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "删除成功"
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
