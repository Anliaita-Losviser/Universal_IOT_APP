import {Header} from '../compomets/CommonComponets'
@Entry
@Component
struct Page6 {
  @State message: string = 'page6'

  build() {
    Column({space: 8}) {
      Header({title: '数据6'})
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