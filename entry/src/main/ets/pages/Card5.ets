
import { McGaugeChart, Options } from '@mcui/mccharts'

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
    series: [
      {
        data: [ { name: '温度', value: 27 } ]
      }
    ]
  })
  build() {
    Row() {
      McGaugeChart({
        options: this.defOption
      })
    }
    .height('50%')
  }
}
