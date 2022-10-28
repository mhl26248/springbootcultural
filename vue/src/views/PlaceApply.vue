<template>
  <div style="padding: 10px">

    <!--    搜索区域-->
    <div style="margin: 10px 0">

      <el-radio-group @change="load" v-model="queryMstatus">
        <el-radio-button  label="-1">全部</el-radio-button>
        <el-radio-button  label="0">待审核</el-radio-button>
        <el-radio-button  label="1">审核通过</el-radio-button>
      </el-radio-group>
      <!--      <el-input v-model="search" placeholder="请输入关键字" style="width: 20%" clearable></el-input>-->
      <el-button type="primary" style="margin-left: 5px" @click="load">刷新</el-button>
      <!--      <el-button type="primary" @click="add">新增</el-button>-->
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
      >
      </el-table-column>
      <el-table-column
          prop="driverName"
          label="申请人"
      >
      </el-table-column>
      <el-table-column
          prop="placesName" min-width="100px"
          label="站点名称">
      </el-table-column>
      <el-table-column
          prop="applyTime" min-width="100px"
          label="申请时间">
      </el-table-column>
      <el-table-column
          min-width="100px"
          label="申请状态">
        <template #default="scope">
          <span v-if="scope.row.applyStatus == 0">待审核</span>
          <span v-if="scope.row.applyStatus == 1">审核通过</span>
          <span v-if="scope.row.applyStatus == 2">拒绝</span>
          <span v-if="scope.row.applyStatus == 3">失效</span>
        </template>
      </el-table-column>
      <el-table-column
          min-width="200px"
          label="操作">
        <template #default="scope">
          <el-popconfirm title="确定通过吗？" v-if="scope.row.applyStatus == 0" @confirm="updateStatusUp(scope.row)">
            <template #reference>
              <el-button size="mini" >通过</el-button>
            </template>
          </el-popconfirm>
          <el-popconfirm title="确定驳回吗？" v-if="scope.row.applyStatus == 0||scope.row.applyStatus == 1" @confirm="updateStatusDown(scope.row)">
            <template #reference>
              <el-button size="mini" type="danger">驳回</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>


    <el-dialog title="提示" v-model="dialogVisible" width="50%">
      <el-form :model="form" label-width="120px">
        <el-form-item label="标题">
          <el-input v-model="form.title" style="width: 50%"></el-input>
        </el-form-item>

        <div id="div1"></div>
        <!--        <el-form-item label="内容">-->
        <!--          <el-input v-model="form.price" style="width: 80%"></el-input>-->
        <!--        </el-form-item>-->
      </el-form>
      <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
          </span>
      </template>
    </el-dialog>

    <el-dialog title="详情" v-model="vis" width="50%">
      <el-card>
        <div v-html="detail.content" style="min-height: 100px"></div>
      </el-card>
    </el-dialog>

  </div>
</template>

<script>

import E from 'wangeditor'
import request from "@/utils/request";

let editor;

export default {
  name: 'News',
  components: {},
  data() {
    return {
      queryMstatus: '-1',
      loading: true,
      form: {},
      dialogVisible: false,
      search: '2',
      currentPage: 1,
      pageSize: 10,
      total: 0,
      tableData: [],
      vis: false,
      detail: {},
    }
  },
  created() {
    this.load()
  },
  methods: {
    updateStatusUp(row){
      let n = row
      // this.$set(n, "newsStatus", 1);
      request.post("/driversApply/updateStatusUp", n).then(res => {
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
    //下线
    updateStatusDown(row){
      let n = row
      request.post("/driversApply/updateStatusDown", n).then(res => {
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
    details(row) {
      this.detail = row
      this.vis = true
    },
    filesUploadSuccess(res) {
      console.log(res)
      this.form.cover = res.data
    },
    load() {
      this.loading = true
      request.get("/driversApply/findPage", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          queryMstatus: this.queryMstatus,
          search: this.search
        }
      }).then(res => {
        this.loading = false
        this.tableData = res.data.records
        // this.total = res.data.total
      })
    },
    add() {
      this.dialogVisible = true
      this.form = {}

      this.$nextTick(() => {
        // 关联弹窗里面的div，new一个 editor对象
        if (!editor) {
          editor = new E('#div1')

          // 配置 server 接口地址
          editor.config.uploadImgServer = 'http://' + window.server.filesUploadUrl + ':9090/files/editor/upload'
          editor.config.uploadFileName = "file"  // 设置上传参数名称
          editor.create()
        }

        editor.txt.html("")

      })

    },
    save() {
      this.form.content = editor.txt.html()  // 获取 编辑器里面的值，然后赋予到实体当中

      if (this.form.id) {  // 更新
        request.put("/news", this.form).then(res => {
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
        this.form.author = user.nickName

        request.post("/news", this.form).then(res => {
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

      this.$nextTick(() => {
        // 关联弹窗里面的div，new一个 editor对象
        // 关联弹窗里面的div，new一个 editor对象
        if (!editor) {
          editor = new E('#div1')

          // 配置 server 接口地址
          editor.config.uploadImgServer = 'http://localhost:9090/files/editor/upload'
          editor.config.uploadFileName = "file"  // 设置上传参数名称
          editor.create()
        }

        editor.txt.html(row.content)
      })
    },
    handleDelete(id) {
      console.log(id)
      request.delete("/news/" + id).then(res => {
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
