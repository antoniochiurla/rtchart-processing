class Cartesian extends Chart {
  boolean guide = true;
  boolean grid = true;

  Cartesian(String name){
    super(name);
  }
  
  void setGuide(boolean guide){
    this.guide = guide;
    calcBox();
  }
  
  void draw() {
    super.draw();
    if(guide){
      drawGuide();
    }
    if(grid){
      drawGrid();
    }
  }
  
  void calcBox(){
    if(guide){
      this.x = this.xBox + xBorderLeft;
      this.y = this.yBox + yBorderTop;
      this.w = this.wBox - ( xBorderLeft + xBorderRight );
      this.h = this.hBox - ( yBorderTop + yBorderBottom );
    } else {
      this.x = this.xBox;
      this.y = this.yBox;
      this.w = this.wBox;
      this.h = this.hBox;
    }
  }


  void drawGrid(){
    stroke(#b0b0b0);
    line(x,y+h,x+w,y+h);
    line(x,y,x,y+h);
    float stepSize = ( variables.get(0).max - variables.get(0).min ) / 10.0;
    float stepY;
    for(float step = variables.get(0).min + stepSize; step <= variables.get(0).max; step += stepSize){
      stepY = calcY(step,0);
      line(x,stepY,x+w,stepY);
    }
    stepSize = timeSize / 10.0;
    float stepX;
    for(float step = 0; step <= timeSize; step += stepSize){
      stepX = calcX(step,0);
      line(stepX,y,stepX,y + h);
    }
  }

  void drawGuide(){
    textSize(20);
    stroke(#505050);
    fill(#707070);
    text(name,xBox + wBox - textWidth(name + " " ),yBox + 20);
    line(x,y+h,x+w,y+h);
    line(x,y,x,y+h);
    textSize(10);
    String text;
    float stepSize = ( variables.get(0).max - variables.get(0).min ) / 10.0;
    float stepY;
    for(float step = variables.get(0).min + stepSize; step <= variables.get(0).max; step += stepSize){
      stepY = calcY(step,0);
      text = humanNumber(step);
      text(text,x - textWidth(text + " "),stepY + 3);
      line(x,stepY,x+3,stepY);
    }
    stepSize = timeSize / 10.0;
    float stepX;
    for(float step = 0; step <= timeSize; step += stepSize){
      stepX = calcX(step,0);
      text = str(int(step));
      text = humanNumber(step);
      text(text,stepX - textWidth(text + " ") / 2,y + h + 10);
      line(stepX,y + h,stepX,y + h -3);
    }
  }
  
  String humanNumber(float value){
    String text;
    float stepShow = value;
    String unit = "";
    if(stepShow > 9000000){
      stepShow /= 1000000;
      unit = "M";
    } else if(stepShow > 1000){
      stepShow /= 1000;
      unit = "K";
    }
    text = str(round(stepShow)) + unit;
    return text;
  }
  
  float calcX(float value, int v){
    float calcX;
    calcX = (float)x+(float)(value % timeSize) * (float)w / (float)timeSize;
    return calcX;
  }
  
  float calcY(float value, int v){
    float vInRange;
    if(variables.get(v).adapt){
       if(value<variables.get(v).min){
         variables.get(v).setMin(value);
       }
       if(value>variables.get(v).max){
         variables.get(v).setMax(value);
       }
       vInRange = value;
    } else {
      vInRange = max(variables.get(v).min,min(variables.get(v).max,value));
    }
    return (float)y + (float)h - ( vInRange - variables.get(v).min ) * (float)h / ( variables.get(v).getRangeSize() );
  }

}
