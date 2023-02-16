<template>

  <Header v-if="user == ''" :user="user"/>
  <div style="padding: 10px">
    <div style="margin: 10px 100px;">
      <el-input v-model="search" placeholder="请输入关键词" style="width: 60%" clearable></el-input>
      <el-button type="primary" style="margin-left: 5px" @click="load()">查询</el-button>
    </div>

    <el-carousel :interval="2000" type="card"  v-if="tableData.length>0" >
      <el-carousel-item v-for="item in tableData" style="height: 250px;">
        <h3 class="medium"  @click="toDetail(item)" ><img  :src="item.images" ></h3>
      </el-carousel-item>
    </el-carousel>
    <el-row style="padding-top: 30px">
      <el-col :span="4" v-for="(o, index) in tableData" :offset="index%4? 1 : 2"
      style="margin-top: 10px;margin-bottom: 10px">
      <el-card :body-style="{ padding: '10px'}" @click="toDetail(o)" style="width:300px;height:220px" shadow="hover">
<!--        <img :src="o.images" style="height: 120px"   class="image">-->
        <div style="padding: 14px;" >
          <span style="font-size: 18px">{{ o.title }}</span>
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

    <el-dialog title="下单" v-model="dialogVisible" width="70%">
      <el-form ref="form"   :model="form" label-width="80px">
        <el-form-item label="标题">
          <el-input v-model="form.title" disabled style="width: 30%"></el-input>
        </el-form-item>
<!--        <el-form-item label="图片">-->
<!--          <img :src="form.images" style="width: 200px;height: 200px">-->
<!--        </el-form-item>-->
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
          <el-radio v-model="form.payType" label="余额">余额</el-radio>
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
import Header from "@/components/Header";

export default {
  name: 'Role',
  components: {
    Header
  },
  data() {
    return {
      drawer: false,
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
      },
      user: ''
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
      // if(this.form.inDate == '' || this.form.inDate == undefined){
      //   this.$message({
      //     type: "error",
      //     message: "请先选择预约时间"
      //   })
      //   return ;
      // }
      request.get("/user/selectByRoleIdDate", {
        params: {
          roleId:5,
          date:this.form.inDate
        }
      }).then(res => {
        this.options = res.data
      })
    },
    load(sort) {
      this.loading = true
      let userStr = sessionStorage.getItem("user") || "{}"
      let user = JSON.parse(userStr)
      this.userName = user.username
      if(this.userName){
        this.user = user
      }
      request.get("/record/index", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search2:this.search,
          // search1:0,
          sort:sort
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
    toDetail(row){
      // sessionStorage.setItem("itemid", JSON.stringify(res.data))  // 缓存用户信息
      // this.$router.push('/RecordDetail');
      //
      this.$router.push({name: 'RecordDetail', query: {sid: row.id}});
    },
    word(row) {
      let userStr = sessionStorage.getItem("user") || "{}"
      console.log(userStr)
      let user = JSON.parse(userStr)
      this.userName = user.username
      this.form.userId = user.id
      this.form.recordId = row.id

      request.post("/word/save", this.form).then(res => {
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "举报成功"
          })

        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
      })
    },
    cart(row) {
      let userStr = sessionStorage.getItem("user") || "{}"
      console.log(userStr)
      let user = JSON.parse(userStr)
      this.userName = user.username
      this.form.userId = user.id
      this.form.recordId = row.id

      request.post("/cart/save", this.form).then(res => {
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "加入成功"
          })

        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
      })
    },
    book(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.form.payType = '支付宝'
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
<style>
.el-carousel__item h3 {
  color: #475669;
  font-size: 14px;
  opacity: 0.75;
  line-height: 200px;
  margin: 0;
}

.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n+1) {
  background-color: #d3dce6;
}
</style>
