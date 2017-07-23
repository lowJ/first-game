class Timer{
  float t;
  
  Timer(float time){
   this.t = time; 
  }
  void runTimer(){
    t += 0.01666666666;
  }
  
  void showTime(){
    textSize(12);
    fill(0, 102, 153);
    text(t, width - 40, 10);
    
  }
  float getTime(){
    return t;
  }
  
}