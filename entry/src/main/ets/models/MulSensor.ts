export class MulSensor{
  private _temperature: string = '';

  public set temperature(value: string) {
    this._temperature = value;
  }

  public get temperature(): string {
    return this._temperature;
  }

  private _humidity: string = '';

  public set humidity(value: string) {
    this._humidity = value;
  }

  public get humidity(): string {
    return this._humidity;
  }
}