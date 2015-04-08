class ChartSpeedometer extends Chart {
  float min = Float.MAX_VALUE;
  float max = Float.MIN_VALUE;

  ChartSpeedometer(String name){
    super(name);
  }
  
  void addVariable(Variable variable){
    super.addVariable(variable);
    min = min(min,( variable.min + variable.offset ) * variable.factor);
    max = max(max,( variable.max + variable.offset ) * variable.factor);
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
      float vInRange;
      for(int v = 0; v < variables.size(); v++){
        Variable var = variables.get(v);
        float value = var.source.values.get(var.index)[n];
        if(adapt){
          min=min(value,min);
          max=max(value,max);
          vInRange = value;
        } else {
          vInRange = max(min,min(max,value));
        }
        float thisX = calcX(vInRange); // sin(-( PI / 2.0) + -1.0 * PI * vInRange / max)  * (float)w / 2.3;
        float thisY = calcY(vInRange); // cos(-( PI / 2.0) + -1.0 * PI * vInRange / max) * (float)h / 5.0 * 3.5;
        line(x + w / 2,y + h / 5 * 4,x + thisX + w / 2,y + thisY + h / 5 * 4);
      }
      if(++n >= variables.get(0).source.logSize){
        n = 0;
      }
    }
  }

  float calcX(float value){
      return sin(-( PI / 2.0) + -1.0 * PI * value / max)  * (float)w / 2.3;
  }

  float calcY(float value){
      return cos(-( PI / 2.0) + -1.0 * PI * value / max) * (float)h / 5.0 * 3.5;
  }

  void drawGuide(){
    stroke(#505050);
    fill(#707070);
    drawLegend();
    line(x,y+h,x+w,y+h);
    line(x,y,x,y+h);
    textSize(10);
    noFill();
    arc(x + w / 2,y + h / 5 * 4, w / 2.3 * 2.0,h / 5.0 * 3.5 * 2.0, PI, TWO_PI);
    String text;
    float stepSize = stepSize(min,max);
    float stepY;
    for(float step = min + stepSize; step <= max; step += stepSize){
      stepY = calcY(step);
      text = humanNumber(step);
      text(text,x - textWidth(text + " "),stepY + 3);
      line(x,stepY,x+3,stepY);
    }
  }
  
}
