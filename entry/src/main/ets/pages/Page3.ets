import {Header} from '../compomets/CommonComponets'
@Entry
@Component
struct Page3 {
  @State message: string = 'page3'

  build() {
    Column({space: 8}) {
      Header({title: '数据3'})
      Row() {
        Column() {
          Text(this.message)
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
      }
      .height('80%')
    }
  }
}