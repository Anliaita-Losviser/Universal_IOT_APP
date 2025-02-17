import { McPieChart, Options } from '@mcui/mccharts'

@Entry
@Component
struct Card1 {
  @State defOption: Options = new Options({
    series:[
      {
        data:[
          {value:22, name:'周一'},
          {value:24, name:'周二'},
          {value:27, name:'周三'},
          {value:23, name:'周四'},
          {value:23, name:'周五'},
          {value:20, name:'周六'},
          {value:21, name:'周天'},
        ]
      }
    ]
  })
  build() {
    Row() {
      McPieChart({
        options: this.defOption
      })
    }
    .height('50%')
  }
}
