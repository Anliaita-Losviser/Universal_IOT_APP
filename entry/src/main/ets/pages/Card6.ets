import { McHorBarChart, Options } from '@mcui/mccharts'

@Entry
@Component
struct Index {
  @State defOption: Options = new Options({
    title: {
      show: true,
      text: '℃',
      right: 20,
      top: 30
    },
    xAxis:{
      data:['周日','周六','周五','周四','周三','周二','周一']
    },
    yAxis:{
      name:'温度'
    },
    series:[
      {
        name:'最高气温',
        data:[22, 24, 27, 24, 22, 20, 21]
      }
    ]
  })
  build() {
    Row() {
      McHorBarChart({
        options: this.defOption
      })
    }
    .height('50%')
  }
}
