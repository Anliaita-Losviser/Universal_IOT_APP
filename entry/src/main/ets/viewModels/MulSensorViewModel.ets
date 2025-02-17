import { MqttClient, MqttConnectOptions, MqttMessage, MqttResponse, MqttSubscribeOptions } from '@ohos/mqtt';
import { JSON } from '@kit.ArkTS';
import { MulSensor } from '../models/MulSensor';

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
  GetMessages(mqttAsyncClient:MqttClient,sensor: MulSensor){
    mqttAsyncClient.messageArrived((err: Error, data: MqttMessage) => {
      let msg = JSON.parse(data.payload)
      console.warn("收到数据"+JSON.stringify(data.payload));
      sensor.temperature = (msg as object)?.["Temperature"]
      sensor.humidity = (msg as object)?.["Humidity"]
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