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

import { MqttClient, MqttConnectOptions, MqttMessage, MqttResponse, MqttSubscribeOptions } from '@ohos/mqtt';
import { JSON} from '@kit.ArkTS';
import { MulSensor } from '../models/MulSensor';
import {Options}from '@mcui/mccharts'
import { dataQueue } from '../common/dataQueue';

const UserName: string = "shmqtt";
const Password: string = "12345678";

class MulSensorViewModel{
  /**
   * mqtt连接配置，包括：
   * 用户名
   * 密码
   * 超时
   */
  private connectOptions: MqttConnectOptions = {
  userName: UserName,
  password: Password,
  connectTimeout: 30,
  };

  private  temperatureQueue = new dataQueue()
  private humidityQueue = new dataQueue()
  /**
   * 连接服务器
   * @param mqttAsyncClient
   */
  async ConnectToServer(mqttAsyncClient:MqttClient){
    await mqttAsyncClient.connect(this.connectOptions).then((data: MqttResponse) => {
      console.warn("连接成功" + JSON.stringify(data));
    }).catch((err: MqttResponse) => {
      console.warn("连接失败"+JSON.stringify(err))
    })
  }
  /**
   * 订阅主题
   * @param mqttAsyncClient
   * @param subscribeOptions
   */
  async SubscribeTopic(mqttAsyncClient:MqttClient, subscribeOptions:MqttSubscribeOptions){
    if(await mqttAsyncClient.isConnected()){
      mqttAsyncClient.subscribe(subscribeOptions).then((data: MqttResponse) => {
        console.warn("订阅成功"+ JSON.stringify(data));
      }).catch((err: MqttResponse) => {
        console.warn("订阅失败"+ JSON.stringify(err));
      })
    }
  }
  /**
   * 取消订阅
   * @param mqttAsyncClient
   * @param subscribeOptions
   */
  async UnsubscribeTopic(mqttAsyncClient:MqttClient, subscribeOptions:MqttSubscribeOptions){
    if(await mqttAsyncClient.isConnected()){
      mqttAsyncClient.unsubscribe(subscribeOptions).then((data:MqttResponse)=>{
        console.warn("取消订阅成功"+ JSON.stringify(data));
      }).catch((err:MqttResponse)=>{
        console.warn("取消订阅失败"+ JSON.stringify(err));
      })
    }
  }
  /**
   * 接收消息回调
   * @param mqttAsyncClient
   * @returns
   */
  GetMessages(mqttAsyncClient:MqttClient,sensor: MulSensor,
    temperatures: string[],humidities: string[],seriesOption: Options){
    mqttAsyncClient.messageArrived((err: Error, data: MqttMessage) => {
      let msg = JSON.parse(data.payload)
      console.warn("收到数据"+JSON.stringify(data.payload));
      sensor.temperature = (msg as object)?.["Temperature"]
      sensor.humidity = (msg as object)?.["Humidity"]

      this.temperatureQueue.push(sensor.temperature)
      this.temperatureQueue.pop()
      temperatures = this.temperatureQueue.getData()

      this.humidityQueue.push(sensor.humidity)
      this.humidityQueue.pop()
      humidities = this.humidityQueue.getData()

      seriesOption.setVal({
        series: [
          {
            name:'温度',
            data:temperatures
          },
          {
            name:'湿度',
            data:humidities
          }
        ]
      })
    });
  }
  /**
   * 断开连接
   * @param mqttAsyncClient
   */
  async DisConnectFromServer(mqttAsyncClient:MqttClient){
    mqttAsyncClient.disconnect().then((data: MqttResponse) => {
      console.warn("断开成功"+ JSON.stringify(data));;
    }).catch((err: MqttResponse) => {
      console.warn("断开失败"+ JSON.stringify(err));
    })
  }
}

const mulSensorViewModel = new MulSensorViewModel()
export default mulSensorViewModel as MulSensorViewModel