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
import {Cards} from '../Views/Cards'
/**
 * 自定义的Item类
 */
class Item{
  constructor(name: string, connentionState: boolean, onClickFunc: () => void) {
    this.name = name
    this.connentionState = connentionState
    this.onClickFunc = onClickFunc
  }
  name: string = ""
  connentionState: boolean = false
  onClickFunc: ()=>void = () =>{}
}

@Component
export struct home {
  pushToDetail = ()=>{
    router.pushUrl(
      {
        url: 'pages/DetailPage'
      },
      router.RouterMode.Single,
      err => {
        if(err){
          console.log(`路由错误，errCode: ${err.code} errMsg: ${err.message}`)
        }
      }
    )
  }
  private items: Array<Item> = [new Item("1", true, this.pushToDetail),
    new Item("2", true, this.pushToDetail),
    new Item("3", true, this.pushToDetail),
    new Item("4", true, this.pushToDetail),
    new Item("5", true, this.pushToDetail),
    new Item("6", true, this.pushToDetail),
    new Item("7", true, this.pushToDetail),
    new Item("8", true, this.pushToDetail),
  ]
  build() {
    Scroll(){
      Flex({ wrap: FlexWrap.Wrap,
        direction: FlexDirection.Row,
        justifyContent: FlexAlign.Center,
        alignItems: ItemAlign.Start }){
        ForEach(this.items,(item: Item) =>{
          Cards({name:item.name,
            connentionState:item.connentionState,
            onClickFunc:item.onClickFunc})
<<<<<<< HEAD
        })
=======
        },)
>>>>>>> main
      }
      .width('100%')
      .backgroundColor('#F5F5F5')
    }.scrollBar(BarState.Off)
  }
}