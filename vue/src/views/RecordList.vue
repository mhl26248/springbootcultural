<template>
  <div style="padding: 10px">
    <!--    功能区域-->
<!--    <div style="margin: 10px 0">-->
<!--    </div>-->

    <!--    搜索区域-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="请输入标题" style="width: 20%" clearable></el-input>
      <el-button type="primary" style="margin-left: 5px" @click="load">查询</el-button>
<!--      <el-button  @click="add">创建</el-button>-->
    </div>
    <el-row>
      <el-col :span="8" v-for="(o, index) in tableData" :key="o" :offset="index > 0 ? 2 : 0">
        <el-card :body-style="{ padding: '0px' }">
          <img :src="o.images" style="height: 220px" class="image">
          <div style="padding: 14px;">
            <span></span>
            <div class="bottom clearfix">
              {{ o.title }}

            </div><el-button type="text" @click="book(o)" class="button">预约</el-button>
          </div>
        </el-card>
      </el-col>
    </el-row>

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

    <el-dialog title="预约" v-model="dialogVisible" width="70%">

      <el-form ref="form"   :model="form" label-width="80px">


        <el-form-item label="标题">
          <el-input v-model="form.title" style="width: 30%"></el-input>
        </el-form-item>
        <el-form-item label="图片">
          <img :src="form.images" style="width: 200px;height: 200px">
<!--          <el-input v-model="form.images" style="width: 80%" disabled></el-input>-->
<!--          <el-upload-->
<!--              class="upload-demo"-->
<!--              action="http://127.0.0.1:9091/files/upload"-->
<!--              :on-preview="handlePreview"-->
<!--              :on-success="handlePreviewVideo"-->
<!--              :on-remove="handleRemove"-->
<!--              :file-list="fileList"-->
<!--              list-type="picture">-->
<!--            <el-button size="small" type="primary">点击上传</el-button>-->
<!--&lt;!&ndash;            <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>&ndash;&gt;-->
<!--          </el-upload>-->
        </el-form-item>
        <el-form-item label="预约日期">
          <el-date-picker
              value-format="YYYY-MM-DD"
              v-model="form.applyTime"
              type="date"
              placeholder="选择日期">
          </el-date-picker>
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
      request.get("/record/findPageMyRecord", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search2:this.search,
        }
      }).then(res => {
        this.loading = false
        this.tableData = res.data.records
        this.total = res.data.total
      })



    },
    save() {
      let userStr = sessionStorage.getItem("user") || "{}"
      let user = JSON.parse(userStr)

      let req = {}
      req.applyId = user.id
      req.recordId = this.form.id
      req.applyTime = this.form.applyTime

      request.post("/recordApply/save", req).then(res => {
        console.log(res)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "预约成功"
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
    book(row) {
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

    handleUpdate(id,status) {
      console.log(id)
      let re = {}
      re.id = id
      re.status = status
      request.post("/record/updateStatus", re).then(res => {
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
        this.load()
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
