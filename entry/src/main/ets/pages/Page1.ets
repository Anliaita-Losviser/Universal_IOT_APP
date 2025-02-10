import {Header} from '../compomets/CommonComponets'
@Entry
@Component
struct Page1 {
  @State message: string = 'page1'

  build() {
    Column({space: 8}) {
     Header({title: '数据1'})
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