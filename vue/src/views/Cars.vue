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
          prop="carName"
          label="车辆名称">
      </el-table-column>
      <el-table-column
          prop="carNo" min-width="120px"
          label="车牌">
      </el-table-column>
      <el-table-column
          prop="age"
          label="车龄">
      </el-table-column>
      <el-table-column
          prop="brand"
          label="分类">
      </el-table-column>
      <el-table-column
          prop="userName"
          label="车主">
      </el-table-column>
      <el-table-column
          prop="placeName" min-width="120px"
          label="车库">
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


    <el-dialog title="提示" v-model="dialogVisible" width="40%">
      <el-form :model="form" label-width="120px">
        <el-form-item label="车辆名称">
          <el-input v-model="form.carName" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="车牌">
          <el-input v-model="form.carNo" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="车龄">
          <el-input v-model="form.age" style="width: 80%"></el-input>
        </el-form-item>
<!--        <el-form-item label="品牌">-->
<!--          <el-radio v-model="form.brand" label="大众">大众</el-radio>-->
<!--          <el-radio v-model="form.brand" label="本田">本田</el-radio>-->
<!--          <el-radio v-model="form.brand" label="未知">未知</el-radio>-->
<!--        </el-form-item>-->
        <el-form-item label="分类">
          <el-select v-model="form.brand">
            <el-option
                v-for="item in options4"
                :key="item.name"
                :label="item.name"
                :value="item.name">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="用户">
          <el-select v-model="form.carSj">
            <el-option
                v-for="item in options3"
                :key="item.username"
                :label="item.username"
                :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="车库">
          <el-select v-model="form.carZd">
            <el-option
                v-for="item in options2"
                :key="item.placeName"
                :label="item.placeName"
                :value="item.id">
            </el-option>
          </el-select>
          <!--          <el-input type="hidden" v-model="form.managerId" style="width: 80%"></el-input>-->
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
      options3: [],
      options2: [],
      options4: [],
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
    handleChange(row) {
      request.put("/cars/changeRole", row).then(res => {
        if (res.code === '0') {
          this.$message.success("更新成功")
          if (res.data) {
            this.$router.push("/login")
          }
        }
      })
    },
    showBooks(books) {
      this.bookList = books
      this.bookVis = true
    },
    load() {
      this.loading = true
      request.get("/cars/findPage", {
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
      this.dialogVisible = true
      this.form = {}

      //查询所有站点 options2
      request.get("/places/findPage", {
        params: {
          pageNum: 1,
          pageSize: 1000,
          search: ''
        }
      }).then(res => {
        this.options2 = [];
        this.options2 = res.data.records
      })
      //
      request.get("/user/all", {
        params: {
          pageNum: 1,
          pageSize: 1000,
          search: ''
        }
      }).then(res => {
        this.options3 = [];
        this.options3 = res.data
      })
      request.get("/category/getAll", {
        params: {
          pageNum: 1,
          pageSize: 1000,
          search: ''
        }
      }).then(res => {
        this.options4 = [];
        this.options4 = res.data
      })
    },
    save() {
      if (this.form.id) {  // 更新
        request.post("/cars/update", this.form).then(res => {
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
        request.post("/cars/save", this.form).then(res => {
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
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
      //查询所有站点 options2
      request.get("/places/findPage", {
        params: {
          pageNum: 1,
          pageSize: 1000,
          search: ''
        }
      }).then(res => {
        this.options2 = [];
        this.options2 = res.data.records
      })
      //
      request.get("/user/all", {
        params: {
          pageNum: 1,
          pageSize: 1000,
          search: ''
        }
      }).then(res => {
        this.options3 = [];
        this.options3 = res.data
      })
      request.get("/category/getAll", {
        params: {
          pageNum: 1,
          pageSize: 1000,
          search: ''
        }
      }).then(res => {
        this.options4 = [];
        this.options4 = res.data
      })
    },
    handleDelete(id) {
      console.log(id)
      request.delete("/cars/" + id).then(res => {
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
