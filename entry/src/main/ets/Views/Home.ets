/*
 * Copyright [yyyy] [owner of project]
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 *
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * Neither the name of the developer nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 * 重新分发和使用源代码和二进制形式的代码，无论是否进行修改，都是允许的，只要满足以下条件：
 * 重新分发源代码时，必须保留上述版权通知、本条件列表以及以下免责声明。
 * 以二进制形式重新分发时，必须在分发时提供的文档或其他材料中复制上述版权通知、本条件列表以及以下免责声明。
 * 未经事先书面许可，不得使用开发者或贡献者的名称来认可或推广从本软件派生出来的产品。
 */


//这是包含在TabContent中的首页组件
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