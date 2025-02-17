import {Header} from '../compomets/CommonComponets'
@Entry
@Component
struct Page2 {
  @State message: string = 'page2'

  build() {
    Column({space: 8}) {
      Header({title: '数据2'})
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