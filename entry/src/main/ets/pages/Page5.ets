import {Header} from '../compomets/CommonComponets'
@Entry
@Component
struct Page5 {
  @State message: string = 'page5'

  build() {
    Column({space: 8}) {
      Header({title: '数据5'})
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