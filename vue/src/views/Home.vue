<template>

  <div style="padding: 10px">
    <el-row :gutter="20">
      <el-col :span="22">
        <el-card>
          <el-timeline :reverse="reverse">
            <el-timeline-item
                v-for="(activity, index) in activities"
                :key="index"
                :timestamp="activity.created">
              {{activity.title}}<br>
              {{activity.context}}
            </el-timeline-item>
          </el-timeline>
        </el-card>
<!--        <el-card>-->
<!--          <div id="myChart" :style="{width: '600px', height: '500px'}"></div>-->
<!--        </el-card>-->

      </el-col>
<!--      <el-col :span="12">-->
<!--        &lt;!&ndash;        <el-card>&ndash;&gt;-->
<!--        &lt;!&ndash;          站点排行榜：{{summary.newsc}} || 里程排行榜：{{summary.newsMessage}}&ndash;&gt;-->
<!--        &lt;!&ndash;        </el-card>&ndash;&gt;-->
<!--        <el-card>-->
<!--          司机数：{{summary.drivers}}  ||-->
<!--          车辆数：{{summary.cars}} || 里程数：{{summary.miles}}-->
<!--        </el-card>-->

<!--        &lt;!&ndash; 新闻浏览排行 &ndash;&gt;-->
<!--        <el-card>-->
<!--          <div id="myChart2" :style="{width: '600px', height: '500px'}"></div>-->
<!--        </el-card>-->
<!--      </el-col>-->
    </el-row>

  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Home",
  data() {
    return {
      reverse: true,
      activities: [],
      summary:{},
    }
  },
  mounted() {
    // this.drawLine();
    // this.barGraph();
  },
  created() {
    this.load()
  },
  methods: {
    load(){
      request.get("/notice/findPage", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res => {
        this.loading = false
        this.activities = res.data.records
      })
    }
    ,
    drawLine() {
      // 基于准备好的dom，初始化echarts实例
      let myChart = this.$root.echarts.init(document.getElementById('myChart'))
      let option = {
        title: {
          text: '销售统计图',
          subtext: '实时数据',
          left: 'left'
        },
        tooltip: {
          trigger: 'item'
        },
        legend: {
          orient: 'vertical',
          trigger: 'item',
          left: 'center'
        },
        toolbox: {
          show: true,
          feature: {
            mark: {show: true},
            dataView: {show: true, readOnly: false},
            restore: {show: true},
            saveAsImage: {show: true}
          }
        },
        series: [
          {
            name: '站点比例',
            type: 'pie',
            radius: [50, 150],
            center: ['50%', '60%'],
            roseType: 'area',
            itemStyle: {
              borderRadius: 8
            },
            data: []
          }
        ]
      }

      let userStr = sessionStorage.getItem("user") || "{}"
      let user = JSON.parse(userStr)

      request.get("/recordApply/count?storeId="+user.id).then(res => {
        if (res.code === '0') {
          res.data.forEach(item => {
            option.series[0].data.push({name: item.title, value: item.count})
          })
          // 绘制图表
          myChart.setOption(option);
        }
      })

    },
    //右边横向条形图
    barGraph() {
      let catedate = {}
      request.get("/cars/summary2").then(res => {
        if (res.code === '0') {
          catedate = res.data

          //初始化图标
          var myChart = this.$root.echarts.init(document.getElementById('myChart2'));
          //Y轴的数据，和数据值位置一一对应
          var cate = catedate.places_arr;
          //数据值，顺序和Y轴的名字一一对应
          var barData = catedate.count_arr;
          var option = {

            title: {

              text:  "站点车辆排行榜top5",
            },
            tooltip: {

              trigger: "axis",
              axisPointer: {

                type: "shadow",
              },
            },
            //图表位置
            grid: {

              left: "3%",
              right: "4%",
              bottom: "3%",
              containLabel: true,
            },
            //X轴
            xAxis: {

              type: "value",
              axisLine: {

                show: false,
              },
              axisTick: {

                show: false,
              },
              //不显示X轴刻度线和数字
              splitLine: {
                show: false },
              axisLabel: {
                show: false },
            },
            yAxis: {

              type: "category",
              data: cate,
              //升序
              inverse: true,
              splitLine: {
                show: false },
              axisLine: {

                show: false,
              },
              axisTick: {

                show: false,
              },
              //key和图间距
              offset: 10,
              //动画部分
              animationDuration: 300,
              animationDurationUpdate: 300,
              //key文字大小
              nameTextStyle: {

                fontSize: 5,
              },
            },
            series: [
              {

                //柱状图自动排序，排序自动让Y轴名字跟着数据动
                realtimeSort: true,
                name: "数量",
                type: "bar",
                data: barData,
                barWidth: 14,
                barGap: 10,
                smooth: true,
                valueAnimation: true,
                //Y轴数字显示部分
                label: {

                  normal: {

                    show: true,
                    position: "right",
                    valueAnimation: true,
                    offset: [5, -2],
                    textStyle: {

                      color: "#333",
                      fontSize: 13,
                    },
                  },
                },
                itemStyle: {

                  emphasis: {

                    barBorderRadius: 7,
                  },
                  //颜色样式部分
                  normal: {

                    barBorderRadius: 7
                  },
                },
              },
            ],
            //动画部分

            animationDuration: 0,
            animationDurationUpdate: 3000,
            animationEasing: "linear",
            animationEasingUpdate: "linear",
          };
          myChart.setOption(option);
          //图表大小变动从新渲染，动态自适应
          window.addEventListener("resize", function () {

            myChart.resize();
          });
        }
      })

    }
  }
}
</script>

<style scoped>

</style>
