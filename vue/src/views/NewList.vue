<template>
  <div style="padding: 10px">

    <el-row style="padding-top: 30px">
      <el-col :span="24" v-for="(o, index) in tableData"
              style="margin-top: 10px;margin-bottom: 10px;">
        <el-row >
          <el-card>
            <el-col :span="12">
              <div class="grid-content bg-purple"> <img :src="o.defaultImage" style="width: 350px"   class="image"></div>
            </el-col>
            <el-col :span="16" style="padding-left: 40px"><div >{{ o.title }}</div></el-col>
          </el-card>
        </el-row>

      </el-col>
    </el-row>




  </div>
</template>

<script>

import E from 'wangeditor'
// import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import request from "@/utils/request";

let editor;

export default {
  name: 'News',
  components: {},
  data() {
    return {
      options: [{
        value: 1,
        label: '图片'
      }, {
        value: 2,
        label: '视频'
      }, {
        value: 3,
        label: '文字'
      }],
      options3: [{
        value: '来源1',
        label: '来源1'
      }, {
        value: '来源2',
        label: '来源2'
      }, {
        value: '来源4',
        label: '来源4'
      }, {
        value: '来源3',
        label: '来源3'
      }],
      options2: [],
      filesUploadUrl: "http://" + window.server.filesUploadUrl + ":9091/files/upload",
      loading: true,
      form: {},
      dialogVisible: false,
      search: '',
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
    details(row) {
      this.detail = row
      this.vis = true
    },
    filesUploadSuccess(res) {
      console.log(res)
      this.form.defaultImage = res.data
    },
    filesUploadSuccess2(res) {
      console.log(res)
      this.form.defaultVideo = res.data
    },
    load() {
      this.loading = true
      request.get("/news", {
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
      request.get("/news/catList", {

      }).then(res => {
        this.options2 = res.data
        // this.total = res.data.total
      })
    },
    //上线
    updateStatusUp(row){
      let n = row
      // this.$set(n, "newsStatus", 1);
      request.post("/news/updateStatusUp", n).then(res => {
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
      })

    },
    //下线
    updateStatusDown(row){
      let n = row
      request.post("/news/updateStatusDown", n).then(res => {
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
      })
    },
    add() {
      this.dialogVisible = true
      let userJson = sessionStorage.getItem("user");
      this.form = {

      }
      this.form.memberName = JSON.parse(userJson).username

      this.$nextTick(() => {
        // 关联弹窗里面的div，new一个 editor对象
        if (!editor) {
          editor = new E('#div2')
          // 配置 server 接口地址
          editor.config.uploadImgServer = 'http://' + window.server.filesUploadUrl + ':9091/files/editor/upload'
          editor.config.uploadFileName = "file"  // 设置上传参数名称
          editor.config.uploadVideoServer = 'http://' + window.server.filesUploadUrl + ':9091/files/editor/uploadvideo'
          editor.config.uploadVideoName ="file"
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
        this.form.author = user.username

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
          editor.config.uploadImgServer = 'http://localhost:9091/files/editor/upload'
          editor.config.uploadFileName = "file"  // 设置上传参数名称
          editor.config.uploadVideoServer = 'http://' + window.server.filesUploadUrl + ':9091/files/editor/uploadvideo'
          editor.config.uploadVideoName ="file"
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
    },
    del(id) {
      request.get("/news/deleteById/" + id).then(res => {
        this.$message({
          message: "删除成功",
          type: "success"
        });
        this.load()
      })
    }
  }
}
</script>
