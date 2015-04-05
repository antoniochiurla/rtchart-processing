class Cartesian extends Chart {
  boolean guide = true;
  boolean grid = true;
  boolean adapt = true;
  float min = Float.MAX_VALUE;
  float max = Float.MIN_VALUE;
  Variable abscissa;

  Cartesian(String name){
    super(name);
    addMenuItem("Grid");
    addMenuItem("Guide");
  }
  
  void setAbscissa(Variable abscissa){
    this.abscissa = abscissa;
  }
  
  void addVariable(Variable variable){
    super.addVariable(variable);
    min = min(min,( variable.min + variable.offset ) * variable.factor);
    max = max(max,( variable.max + variable.offset ) * variable.factor);
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
    float stepSize = ( max - min ) / 10.0;
    float stepY;
    for(float step = min + stepSize; step <= max; step += stepSize){
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
    stroke(#505050);
    fill(#707070);
    drawLegend();
    line(x,y+h,x+w,y+h);
    line(x,y,x,y+h);
    textSize(10);
    String text;
    float stepSize = ( max - min ) / 10.0;
    float stepY;
    for(float step = min + stepSize; step <= max; step += stepSize){
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
  
  void drawLegend(){
    textSize(15);
    for(int v = 0; v < variables.size(); v++){
      fill(colors.get(v % colors.size()));
      text(variables.get(v).name,xBox,yBox+15*(v+1));
    }
  }
  
  String humanNumber(float value){
    String text;
    float stepShow = value;
    String unit = "";
    if(stepShow > 1000000){
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
    Variable var = variables.get(v);
    vInRange = ( value + var.offset ) * var.factor;
    if(adapt){
      min=min(value,min);
      max=max(value,max);
      vInRange = value;
    } else {
      vInRange = max(var.min,min(var.max,value));
    }
    return (float)y + (float)h - ( vInRange - min ) * (float)h / ( getRangeSize() );
  }

  float getRangeSize(){
    return max - min;
  }

  boolean menuItemIsSelected(int menuItemSelected){
    if(menu.get(menuItemSelected).equals("Grid")){
      return grid;
    } else if(menu.get(menuItemSelected).equals("Guide")){
      return guide;
    }
    return false;
  }
  
  void menuItemSelected(int menuItemSelected){
    if(menu.get(menuItemSelected).equals("Grid")){
      grid = ! grid;
    } else if(menu.get(menuItemSelected).equals("Guide")){
      guide = ! guide;
    }
  }
}
