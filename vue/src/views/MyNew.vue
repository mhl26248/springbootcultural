<template>
  <div style="padding: 10px">

    <!--    搜索区域-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="请输入关键字" style="width: 20%" clearable></el-input>

      <el-button type="primary" style="margin-left: 5px" @click="load">查询</el-button>
      <el-button type="primary" @click="add">发布</el-button>
    </div>
    <el-table
        v-loading="loading"
        :data="tableData"
        stripe
        style="width: 100%">
      <el-table-column
          label="默认图"
      >
        <template #default="scope">
<!--          {{scope.row.defaultImage}}-->
          <img style="width: 100px"  :src="scope.row.defaultImage">
        </template>
      </el-table-column>
      <el-table-column
          prop="title" min-width="200px"
          label="标题">
      </el-table-column>
      <el-table-column
          prop="newsFrom"
          label="来源">
      </el-table-column>
      <el-table-column
          prop="typeName"
          label="类别">
      </el-table-column>
      <el-table-column
          prop="time"
          label="时间">
      </el-table-column>
      <el-table-column label="操作" min-width="200px">
        <template #default="scope">
          <el-button size="mini" @click="handleEdit(scope.row)">编辑</el-button>
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

    <el-dialog title="提示" v-model="dialogVisible" width="50%" >
      <el-form :model="form" label-width="120px">
        <el-form-item label="标题">
          <el-input v-model="form.title" style="width: 50%"></el-input>
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="form.desc2" style="width: 50%"></el-input>
        </el-form-item>
        <el-form-item label="默认图片">
          <el-input v-model="form.defaultImage" style="width: 50%" disabled></el-input>
          <el-upload ref="upload" :action="filesUploadUrl" :on-success="filesUploadSuccess">
            <el-button type="primary">点击上传</el-button>
          </el-upload>
        </el-form-item>
<!--        <el-form-item label="默认视频">-->
<!--          <el-input v-model="form.defaultVideo" style="width: 50%" disabled></el-input>-->
<!--          <el-upload ref="upload" :action="filesUploadUrl" :on-success="filesUploadSuccess2">-->
<!--            <el-button type="primary">点击上传</el-button>-->
<!--          </el-upload>-->
<!--        </el-form-item>-->
        <el-form-item label="作者">
          <el-input disabled v-model="form.memberName" style="width: 50%"></el-input>
        </el-form-item>
        <el-form-item label="来源">
          <el-input v-model="form.newsFrom" style="width: 50%"></el-input>
        </el-form-item>
        <el-form-item label="类别">
          <el-select v-model="form.type">
            <el-option
                v-for="item in options2"
                :key="item.id"
                :label="item.name"
                :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <div id="div1">
        </div>
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
      let userStr = JSON.parse(sessionStorage.getItem("user") || "{}")

      this.loading = true
      request.get("/news", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search,
          search2: userStr.username
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
          editor = new E('#div1')
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
