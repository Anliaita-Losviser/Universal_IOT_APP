export class dataQueue{
  private data:string[]=['']

  public pop(){
    if(this.data.length==8){
      for(let i=0;i<this.data.length-1;i++){
        this.data[i]=this.data[i+1]
      }
      this.data.pop()
    }
  }

  public push(item:string){
    this.data.push(item)
  }

  public getData():string[]{
    return this.data
  }
}