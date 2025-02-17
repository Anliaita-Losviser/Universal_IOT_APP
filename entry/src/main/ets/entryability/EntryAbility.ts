import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';

import mqttClientSingleton from '../common/MqttClientManager'
import MulSensorViewModel from '../viewModels/MulSensorViewModel'

export default class EntryAbility extends UIAbility {
  /**
   * 在onCreate中进行连接服务器操作
   * @param want
   * @param launchParam
   * @returns
   */
  async onCreate(want, launchParam): Promise<void> {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    console.warn("EntryAbility--onCreate执行")
    await MulSensorViewModel.ConnectToServer(mqttClientSingleton)
  }

  /**
   * 在onDestroy中进行断开服务器操作
   * @returns
   */
  async onDestroy():promise<void> {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
    console.warn("EntryAbility--onDestroy执行")
    await MulSensorViewModel.DisConnectFromServer(mqttClientSingleton)
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
