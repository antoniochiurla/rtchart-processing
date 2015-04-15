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
    
    float alpha = 0.0;
    int n = variables.get(0).source.first;
    if(logSize<variables.get(0).source.logSize){
      n = variables.get(0).source.last - logSize;
      if(n < 0){
        n = variables.get(0).source.logSize + n;
      }
    }
    while( n != variables.get(0).source.last){
      alpha += 255 / logSize;
      float firstX = 0.0;
      float firstY = 0.0;
      float vInRange;
      for(int v = 0; v < variables.size(); v++){
        stroke(colors.get(v % colors.size()),alpha);
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
    //line(x,y+h,x+w,y+h);
    //line(x,y,x,y+h);
    textSize(10);
    noFill();
    arc(x + w / 2,y + h / 5 * 4, w / 2.3 * 2.0,h / 5.0 * 3.5 * 2.0, PI, TWO_PI);
    String text;
    float stepSize;
    float stepX;
    float stepY;
    float steps = 1.0;
    int startDett = 0;
    if(w > 400){
      startDett = 0;
    }
    for(int dett = startDett; dett <= 2; dett++){
      switch(dett){
        case 0: steps = 10.0; stroke(#b8b8b8); break;
        case 1: steps = 2.0; stroke(#b0b0b0); break;
        case 2: steps = 1.0; stroke(#a0a0a0); break;
      }
      stepSize = stepSize(min,max) / steps;
      for(float step = min; step <= max; step += stepSize){
        stepX = calcX(step);
        stepY = calcY(step);
        text = humanNumber(step);
        // text(text,x - textWidth(text + " "),stepY + 3);
        if(dett == 2){
          text(text,x + stepX * 1.09 + w / 2 - textWidth(text + " ") / 2.0,y + stepY * 1.09 + h / 5 * 4);
        }
        line(x + w / 2 + stepX * 0.9,y + h / 5 * 4 + stepY * 0.9,x + stepX + w / 2,y + stepY + h / 5 * 4);
       //line(x,stepY,x+3,stepY);
      }
    }
  }
  
}
