class ChartSpeedometer extends Chart {
  ChartSpeedometer(String name){
    super(name);
  }
  
  void draw(){
    super.draw();
    stroke(0);
    float posX, posY;
    
    float light = 255.0;
    int n = variables.get(0).source.first;
    if(logSize<variables.get(0).source.logSize){
      n = variables.get(0).source.last - logSize;
      if(n < 0){
        n = variables.get(0).source.logSize + n;
      }
    }
    while( n != variables.get(0).source.last){
      light -= 255 / logSize;
      stroke((int)light,(int)light,255);
      float firstX = 0.0;
      float firstY = 0.0;
      for(int v = 0; v < variables.size(); v++){
        Variable var = variables.get(v);
        float value = var.source.values.get(var.index)[n];
         if(value<variables.get(v).min){
           variables.get(v).setMin(value);
         }
         if(value>variables.get(v).max){
           variables.get(v).setMax(value);
         }
        float thisX = sin(-( PI / 2.0) + -1.0 * PI * value / variables.get(v).max)  * (float)w / 2.0;
        float thisY = cos(-( PI / 2.0) + -1.0 * PI * value / variables.get(v).max) * (float)h / 2.0;
        line(x + w / 2,y + h / 3 * 2,x + thisX + w / 2,y + thisY + h / 2);
      }
      if(++n >= variables.get(0).source.logSize){
        n = 0;
      }
    }
  }

}
