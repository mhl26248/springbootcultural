<template>
  <div style="padding: 10px">
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="请输入内容" style="width: 20%" clearable></el-input>
      <el-button type="primary" style="margin-left: 5px" @click="load">查询</el-button>
    </div>
    <el-table
        v-loading="loading"
        :data="tableData"
        border
       >
      <el-table-column min-width="50"
          label="图片">
        <template #default="scope">
          <img  :src="scope.row.images" style="width: 50px;height: 50px">
        </template>
      </el-table-column>
      <el-table-column min-width="150"
          prop="title"
          label="标题">
      </el-table-column>
      <el-table-column min-width="50"
                       prop="userName"
                       label="用户名">
      </el-table-column>
      <el-table-column min-width="100"
                       prop="remark"
                       label="内容">
      </el-table-column>
      <el-table-column width="50"
                       prop="score"
                       label="分数">
      </el-table-column>
      <el-table-column label="操作" width="100">
        <template #default="scope">
            <el-popconfirm title="确定删除吗？" @confirm="handleUpdate(scope.row.id)">
              <template #reference>
                <el-button size="mini" type="info">删除</el-button>
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
      dialogVisible: false,
      search: '',
      search1: '',
      search2: '',
      currentPage: 1,
      pageSize: 10,
      total: 0,
      tableData: [],
      options: [],
      fileList: [],
      file:{
        name:'',
        url:''
      }
    }
  },
  created() {
    this.load()
  },
  methods: {
    handleRemove(file, fileList) {
      var index = this.fileList.findIndex(item => {
        if (item.name == file.name){
          return true
        }
      })
      this.fileList.splice(index,1)
      this.form.images = ''
      this.fileList.forEach((item, index) => {
        if (this.form.images == "") {
          this.form.images = item.name;
        } else {
          this.form.images = this.form.images + ";" + item.name;
        }
      });
      console.log( this.fileList);
    },
    handlePreviewVideo(file){
      console.log(file.data)
      if (file) {
        if(this.form.images == undefined){
          this.form.images = ''
        }
        else{
          this.form.images = this.form.images+ ';'
        }
        this.form.images = this.form.images+file.data;
        // this.$set(this.form, "images", file.data.name);
        this.$message.info('成功');
      } else {
        this.fileList = [];
        this.$message.error('失败');
      }
    },
    handlePreview(file) {
      console.log(file);
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
    handleIn(row){
      request.post("/record/recordIn", row).then(res => {
        if (res.code === '0') {
          this.$message.success("入库成功")
          this.load()
        }
      })
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
    loadDoctors(){
      console.log(this.form.inDate)
      if(this.form.inDate == '' || this.form.inDate == undefined){
        this.$message({
          type: "error",
          message: "请先选择预约时间"
        })
        return ;
      }
      request.get("/user/selectByRoleIdDate", {
        params: {
          roleId:5,
          date:this.form.inDate
        }
      }).then(res => {
        this.options = res.data
      })
    },
    load() {
      this.loading = true
      let userStr = sessionStorage.getItem("user") || "{}"
      let user = JSON.parse(userStr)
      this.userName = user.username
      request.get("/comment/findPage", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search1: this.search,
        }
      }).then(res => {
        this.loading = false
        this.tableData = res.data.records
        this.total = res.data.total
      })



    },
    add() {
      this.options = []
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
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
      this.fileList = []
      this.options = []
      this.initProductImgs();
    },
    initProductImgs() {
      this.fileList = []
      if (this.form.images != undefined) {
        if (this.form.images.indexOf(";") != -1) {
          let urls = this.form.images.split(";");
          urls.forEach((url, index) => {
            this.file.name = url;
            this.file.url =  url;
            this.fileList.push(this.file);
            this.resetImgobject();
          });
        } else {
          this.file.name = this.form.images;
          this.file.url = this.form.images;
          this.fileList.push(this.file);
          this.resetImgobject();
        }
      }
    },
    resetImgobject() {
      this.file = {
        name: "",
        url: "",
      };
    },
    handleUpdate(id) {
      request.get("/comment/deleteById?id=" + id).then(res => {
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
