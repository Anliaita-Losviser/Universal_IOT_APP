import router from '@ohos.router'
class Item{
  name1: string
  image1: ResourceStr
  data1: number
  url1: string
  name2: string
  image2: ResourceStr
  data2: number
  url2: string

  constructor(name1: string, image1: ResourceStr, data1: number, url1: string, name2: string, image2: ResourceStr, data2: number, url2: string) {
    this.name1 = name1
    this.image1 = image1
    this.data1 = data1
    this.url1 = url1
    this.name2 = name2
    this.image2 = image2
    this.data2 = data2
    this.url2 = url2
  }
}

@Component
export  default  struct home {
  private items: Array<Item> = [
    new Item('数据1',$r('app.media.icon'),1,'pages/Page1','数据2',$r('app.media.icon'),2,'pages/Page2'),
    new Item('数据3',$r('app.media.icon'),3,'pages/Page3','数据4',$r('app.media.icon'),4,'pages/Page4'),
    new Item('数据5',$r('app.media.icon'),5,'pages/Page5','数据6',$r('app.media.icon'),6,'pages/Page6')
  ]
  build() {
Column({space: 30}){
  ForEach(
    this.items,
    (item: Item) => {
      Row({ space: 10 }){
        Column({space: 10}){
          Text(item.name1)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Image(item.image1)
            .width(100)
          Text('' + item.data1)
            .fontColor('#f36')
            .fontSize(18)
        }
        .width('45%')
        .backgroundColor('#FFF')
        .justifyContent(FlexAlign.Start)
        .borderRadius(10)
        .onClick(() => {
          router.pushUrl(
            {
              url: item.url1
            },
            router.RouterMode.Single,
            err => {
              if(err){
                console.log(`路由错误，errCode: ${err.code} errMsg: ${err.message}`)
              }
            }
          )
        })
        Column({ space: 10 }){
          Text(item.name2)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Image(item.image2)
            .width(100)
          Text('' + item.data2)
            .fontColor('#f36')
            .fontSize(18)
        }
        .width('45%')
        .backgroundColor('#FFF')
        .justifyContent(FlexAlign.Start)
        .borderRadius(10)
        .onClick(() => {
          router.pushUrl(
            {
              url: item.url2
            },
            router.RouterMode.Single,
            err => {
              if(err){
                console.log(`路由错误，errCode: ${err.code} errMsg: ${err.message}`)
              }
            }
          )
        })
      }
      .justifyContent(FlexAlign.Center)
    }
  )

}
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}