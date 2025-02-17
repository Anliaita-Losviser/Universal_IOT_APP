import {Header} from '../compomets/CommonComponets'
@Entry
@Component
struct Page4 {
  @State message: string = 'page4'

  build() {
    Column({space: 8}) {
      Header({title: '数据4'})
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