import {MqttAsync, MqttClient } from '@ohos/mqtt';

const Url:string="ws://8.138.47.246:8083"
const ClientId: string = "harmonyOSTestAPP";

class MqttClientManager {
  //创建mqtt客户端
  private constructor() {
  }
  /**
   * 创建全局单例变量，随后在EntryAbility中进行连接操作
   */
  private static mqttAsyncClient = MqttAsync.createMqtt({
    url: Url,
    clientId: ClientId,
    persistenceType: 1,
  })
  public static getInstance():MqttClient{
		return MqttClientManager.mqttAsyncClient;
	}
}

const mqttClientSingleton = MqttClientManager.getInstance()
export default mqttClientSingleton