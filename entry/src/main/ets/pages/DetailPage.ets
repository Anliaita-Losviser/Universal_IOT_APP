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

import { Header } from '../components/Headers'
import mqttClientSingleton from '../common/MqttClientManager'
import MulSensorViewModel from '../viewModels/MulSensorViewModel'
import { MqttSubscribeOptions } from '@ohos/mqtt'
import { MulSensor } from '../models/MulSensor'

const UpLoadsubscribeOption: MqttSubscribeOptions = {
  topic: "SH2846_UpLoad",
  qos: 1
}
const DownLoadsubscribeOption: MqttSubscribeOptions = {
  topic: "SH2846_DownLoad",
  qos: 1
}

@Entry
@Component
struct DetailPage {
  @State message: string = 'Hello World'
  @State sensor: MulSensor = new MulSensor()
  /**
   * 进入DetailPage时执行订阅操作
   * @returns
   */
  async onPageShow(): Promise<void> {
    console.warn("onPageShow执行")
    //订阅主题
    await MulSensorViewModel.SubscribeTopic(mqttClientSingleton, DownLoadsubscribeOption)
    await MulSensorViewModel.SubscribeTopic(mqttClientSingleton, UpLoadsubscribeOption)
    //设置回调
    MulSensorViewModel.GetMessages(mqttClientSingleton, this.sensor)
  }
  /**
   * 退出详细页时取消订阅
   * @returns
   */
  async onPageHide(): Promise<void> {
    console.warn("onPageHide执行")
    await MulSensorViewModel.UnsubscribeTopic(mqttClientSingleton,DownLoadsubscribeOption)
    await MulSensorViewModel.UnsubscribeTopic(mqttClientSingleton,UpLoadsubscribeOption)
  }
  //这是数据指标的详情页，展示温度、湿度等数据
  build() {
    Scroll() {
      Column() {
        Header({ title: '详细信息' })

        Row() {
          Column() {
            Text(this.message)
              .fontSize(50)
              .fontWeight(FontWeight.Bold)

            Row() {
              Text("温度：").fontSize(24)
              Text(this.sensor.temperature).fontSize(24)
              Text("℃").fontSize(24)
            }.width(300).padding(8)

            Row() {
              Text("湿度：").fontSize(24)
              Text(this.sensor.humidity).fontSize(24)
              Text("%").fontSize(24)
            }.width(300).padding(8)
          }
        }.width('100%')
      }
    }
  }
}