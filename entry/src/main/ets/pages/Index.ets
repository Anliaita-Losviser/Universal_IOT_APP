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

import { home } from '../Views/Home';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private tabsController: TabsController = new TabsController()
  build() {
    /**
     * 底部的Tab栏组件
     */
    Tabs({ barPosition: BarPosition.End ,controller:this.tabsController}) {
      //首页
      TabContent() {
        home()
      }
      .tabBar(this.TabBuilder('首页', 0, $r('app.media.house_fill'),$r('app.media.house')))
      //我的
      TabContent() {
        Text('我的')
      }
      .tabBar(this.TabBuilder('我的', 1, $r('app.media.person_2_fill'), $r('app.media.person_2')))
    }
    .width('100%')
    .height('100%')
    .vertical(false)
    .scrollable(false)
  }

  /**
   *
   * @param title：tab的标题
   * @param targetIndex：目标页面
   * @param selectedImg：选中状态的图片
   * @param normalImg：未选中状态的图片
   */
  @Builder TabBuilder(title: ResourceStr, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      /**
       * tab组件的点击切换逻辑
       */
      this.currentIndex = targetIndex;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }
}
