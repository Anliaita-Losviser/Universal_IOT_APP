import router from '@ohos.router'
@Component
export struct Header{
  private title: ResourceStr
  build(){
    Row({space: 20}){
      Image($r('app.media.undo'))
        .width(30)
        .onClick(() =>{
          router.back()
        })
      Text(this.title)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
    }
    .width('90%')
    .height(60)
  }
}