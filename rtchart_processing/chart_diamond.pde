class ChartDiamond extends Chart {
  float min = Float.MAX_VALUE;
  float max = Float.MIN_VALUE;

  ChartDiamond(String name){
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
      float prevX = 0.0;
      float prevY = 0.0;
      float firstX = 0.0;
      float firstY = 0.0;
      for(int v = 0; v < variables.size(); v++){
        Variable var = variables.get(v);
        float value = var.source.values.get(var.index)[n];
        float vInRange;
        vInRange = ( value + var.offset ) * var.factor;
        if(adapt){
          min=min(value,min);
          max=max(value,max);
          vInRange = value;
        } else {
          vInRange = max(min,min(max,vInRange));
        }
        float thisX = calcX(vInRange,v); // sin(2.0 * PI / (float)variables.size() * v) * vInRange / max * (float)w / 2.0;
        float thisY = calcY(vInRange,v); // cos(2.0 * PI / (float)variables.size() * v) * vInRange / max * (float)h / 2.0;
        if(v != 0){
          line(x + prevX + w / 2,y + prevY + h / 2,x + thisX + w / 2,y + thisY + h / 2);
        } else {
          firstX = thisX;
          firstY = thisY;
        }
        if(v == variables.size() - 1){
          line(x + thisX + w / 2,y + thisY + h / 2,x + firstX + w / 2,y + firstY + h / 2);
        }
        prevX = thisX;
        prevY = thisY;
      }
      if(++n >= variables.get(0).source.logSize){
        n = 0;
      }
    }
  }
  
  float calcX(float value, int v){
      return sin(2.0 * PI / (float)variables.size() * v) * value / max * (float)min(w,h) / 2.0;
  }

  float calcY(float value, int v){
      return cos(2.0 * PI / (float)variables.size() * v) * value / max * (float)min(w,h) / 2.0;
  }

  void drawGuide(){
    drawLegend();
    for(int v = 0; v < variables.size(); v++){
      stroke(colors.get(v % colors.size()));
      Variable var = variables.get(v);
      float thisX = calcX(max,v); // sin(2.0 * PI / (float)variables.size() * v) * vInRange / max * (float)w / 2.0;
      float thisY = calcY(max,v); // cos(2.0 * PI / (float)variables.size() * v) * vInRange / max * (float)h / 2.0;
      line(x + w / 2,y + h / 2,x + thisX + w / 2,y + thisY + h / 2);
    }



    float stepSize = stepSize(min,max);

    stroke(#b0b0b0);
    for(float step = min + stepSize; step <= max; step += stepSize){
      float prevX = 0.0;
      float prevY = 0.0;
      float firstX = 0.0;
      float firstY = 0.0;
      for(int v = 0; v < variables.size(); v++){
        Variable var = variables.get(v);
        float value = step;
        float vInRange = step;
        float thisX = calcX(vInRange,v); // sin(2.0 * PI / (float)variables.size() * v) * vInRange / max * (float)w / 2.0;
        float thisY = calcY(vInRange,v); // cos(2.0 * PI / (float)variables.size() * v) * vInRange / max * (float)h / 2.0;
        if(v != 0){
          line(x + prevX + w / 2,y + prevY + h / 2,x + thisX + w / 2,y + thisY + h / 2);
        } else {
          firstX = thisX;
          firstY = thisY;
        }
        if(v == variables.size() - 1){
          line(x + thisX + w / 2,y + thisY + h / 2,x + firstX + w / 2,y + firstY + h / 2);
        }
        prevX = thisX;
        prevY = thisY;
      }
    }


  }
}
