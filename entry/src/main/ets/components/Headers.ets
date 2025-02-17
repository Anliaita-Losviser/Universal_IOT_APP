import router from '@ohos.router'

/**
 * 自定义的头部组件
 */
@Component
export struct Header{
  title: ResourceStr =""
  build(){
    Row({space: 20}){
      Image($r('app.media.undo'))
        .width(30)
        .onClick(() =>{
          router.back()
        })
      Text(this.title)
        .fontSize(32)
        .fontWeight(FontWeight.Normal)
    }
    .width('90%')
    .height(64)
  }
}