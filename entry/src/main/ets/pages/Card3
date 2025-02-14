import { McBarChart, Options } from '@mcui/mccharts'

@Entry
@Component
struct Card3 {
  @State defOption: Options = new Options({
    xAxis:{
      data:['周一','周二','周三','周四','周五','周六','周日']
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
      McBarChart({
        options: this.defOption
      })
    }
    .height('50%')
  }
}
