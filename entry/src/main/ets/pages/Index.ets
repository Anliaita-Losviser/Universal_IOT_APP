import home from '../view/home'

@Entry
@Component
struct Index {
  build() {
      Tabs({barPosition:BarPosition.End}){
        TabContent(){
         home()
        }
        .tabBar(this.TabBuilder('首页',$r('app.media.icon'),0))
        TabContent(){
          Text('我的')
        }
        .tabBar(this.TabBuilder('我的',$r('app.media.icon'),1))
      }
    .width('100%')
    .height('100%')
    .vertical(false)
  }
  @Builder TabBuilder(title: string, image: ResourceStr, index: Number){
    Column({space: 4}){
      Image(image)
        .width(25)
        .height(25)
      Text(title)
    }
    .justifyContent(FlexAlign.Center)
  }
}