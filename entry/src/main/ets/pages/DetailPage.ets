/*
 * Copyright 2024 - 2025 华南理工大学 学生研究计划(SRP)项目组-基于鸿蒙的物联网采集系统设计
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
 *
 * Disclaimer
 * This software is provided "as is" without any express or implied warranty,
 * including but not limited to the warranties of merchantability,
 * fitness for a particular purpose, and non-infringement.
 * The risk of using this software lies with the user. The developers or contributors shall not be liable for any direct,
 * indirect, incidental, special, exemplary, or consequential damages resulting from the use of this software.
 * To the maximum extent permitted by law, the developers or contributors shall not be responsible for any claims,
 * losses, liabilities, damages, costs, or expenses arising from the use or inability to use this software.
 * 免责声明
 * 本软件按“现状”提供，不附带任何形式的明示或暗示保证，包括但不限于对适销性、特定用途的适用性或非侵权性的保证。
 * 使用本软件的风险由用户自行承担。开发者或贡献者不对因使用本软件而导致的任何直接、间接、偶然、特殊、惩戒性或后果性损害承担任何责任。
 * 在法律允许的最大范围内，开发者或贡献者对于因使用或无法使用本软件而产生的任何索赔、损失、责任、损害、成本或费用均不承担责任。
 */

import { Header } from '../components/Headers'
import mqttClientSingleton from '../common/MqttClientManager'
import MulSensorViewModel from '../viewModels/MulSensorViewModel'
import { MqttSubscribeOptions } from '@ohos/mqtt'
import { MulSensor } from '../models/MulSensor'
import { McLineChart, Options } from '@mcui/mccharts'

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
  @State temperatures: string[] = ['']
  @State humidities: string[] = ['']
  @State seriesOption: Options = new Options({
    xAxis:{
      axisLabel: {  // x轴文本标签样式
        color: '#000000',
        fontWeight: '600',
        fontSize: 24,
      },
      data:['1','2','3','4','5','6','7']
    },
    yAxis:[
      {
        name: '温度/°C',
        nameTextStyle: { // 名称样式
          color: '#000000'  ,
          fontWeight: 'normal',
          fontSize: 36,
        },
        axisLabel: {  // x轴文本标签样式
          color: '#bf19ff',
          fontWeight: '600',
          fontSize: 24,
          formatter: (name: string) => { // 自定义文本标签
            return name + '°C'
          }
        },
        min:-20,
        max:100,
        splitLine: {
          show: false
        }
      },
      {
        name: '湿度/%',
        nameTextStyle: { // 名称样式
          color: '#000000'  ,
          fontWeight: 'normal',
          fontSize: 36,
        },
        axisLabel: {  // x轴文本标签样式
          color: '#bf19ff',
          fontWeight: '600',
          fontSize: 24,
          formatter: (name: string) => { // 自定义文本标签
            return name + '%'
          }
        },
        position: 'right',
        min:0,
        max:100,
        splitLine: {
          show: false
        }
      }
    ],
    series:[
      {
        name: '温度',
        color:'#ffe02626',
        data: this.temperatures
      },
      {
        name: '湿度',
        color:'#ff104ecd',
        data: this.humidities,
        yAxisIndex: 1
      }
    ]
  })
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
    MulSensorViewModel.GetMessages(mqttClientSingleton, this.sensor,
    this.temperatures,this.humidities,this.seriesOption)
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
          Column() {
            McLineChart({
              options: this.seriesOption
            }).height(384)

            Row() {
              Text("实时温度：").fontSize(24)
              Text(this.sensor.temperature).fontSize(24)
              Text("°C").fontSize(24)
            }.width(300).padding(8)

            Row() {
              Text("实时湿度：").fontSize(24)
              Text(this.sensor.humidity).fontSize(24)
              Text("%").fontSize(24)
            }.width(300).padding(8)
          }.width('100%')
      }
    }
  }
}