class Chart
{
  boolean guide = true;
  boolean grid = true;
  String name;
  int x, y, w, h;
  int xBox, yBox, wBox, hBox;
  int xBorderLeft, xBorderRight, yBorderTop, yBorderBottom;
  int r = 10; // round rec
  int logSize = 200;
  long timeSize; // in milliseconds
  ArrayList<float []> values;
  ArrayList<Variable> variables;
  ArrayList<Source> sources;
  boolean adapt = false;
  // Variable defaultVariable = new Variable("",null,0,Variable.TYPE_FLOAT,0,10,true);
  boolean menuActive = false;
  int menuItemSelected = -1;
  ArrayList<String> menu;
  ArrayList<Integer> colors = new ArrayList();
  
  int first, last;
  
  Chart(String name){
    this.name = name;
    println("Name: " + name);
    variables = new ArrayList<Variable>();
    sources = new ArrayList<Source>();
    initLog();
    menu = new ArrayList<String>();
    initVariables();
    timeSize = 10000;
    xBorderLeft = 30;
    xBorderRight = 10;
    yBorderTop = 10;
    yBorderBottom = 15;
    initColors();
  }

  void initColors(){
    colors.add(#ff0000);
    colors.add(#008800);
    colors.add(#0000ff);
    colors.add(#ffff00);
    colors.add(#00ffff);
    colors.add(#ff00ff);
    colors.add(#880000);
    colors.add(#00ff00);
    colors.add(#000088);
    colors.add(#888800);
    colors.add(#008888);
    colors.add(#880088);
  }  
  void initVariables(){
    variables.clear();
    initLog();
  }
  
  void addVariable(Variable variable){
    variables.add(variable);
    initLog();
  }
  
  void setGuide(boolean guide){
    this.guide = guide;
    calcBox();
  }
  
  void setAdapt(boolean adapt){
    this.adapt = adapt;
  }
  
  void setRect( int x, int y, int w, int h){
    this.xBox = x;
    this.yBox = y;
    this.wBox = w;
    this.hBox = h;
    calcBox();
  }
  
  void calcBox(){
    this.x = this.xBox;
    this.y = this.yBox;
    this.w = this.wBox;
    this.h = this.hBox;
  }
  
  void setRound(int r){
    this.r = r;
  }
  
  void setLogSize(int logSize){
    this.logSize = logSize;
    initLog();
  }
  
  void setTimeSize(long timeSize){
    this.timeSize = timeSize;
  }

  void initLog(){
    values = new ArrayList<float []>();
    for(int v = 0; v < variables.size(); v++){
      values.add(new float[ logSize ]);
    }
    first = 1;
    last = -1;
  }
  
  void draw(){
    stroke(#202020);
    fill(#c0c0c0);
    rect(xBox,yBox,wBox,hBox,r);
    showName();
    handleMenu();
    if(guide){
      drawGuide();
    }
    if(grid){
      drawGrid();
    }
  }
  
  void drawGrid(){
  }
  
  void drawGuide(){
  }
  
  void drawLegend(){
    textSize(15);
    for(int v = 0; v < variables.size(); v++){
      fill(colors.get(v % colors.size()));
      text(variables.get(v).name,xBox,yBox+15*(v+1));
    }
  }
  
  void showName(){
    textSize(20);
    stroke(#505050);
    fill(#707070);
    text(name,xBox + wBox - textWidth(name + " " ),yBox + 20);
  }
  
  void handleMenu(){
    if(mousePressed && mouseButton == LEFT && mouseInChart()){
      menuActive = true;
    } else if(menuActive) {
      if( ! mousePressed && menuItemSelected != -1){
        menuItemSelected(menuItemSelected);
      }
      if( ! mousePressed || ! mouseInChart()){
        menuActive = false;
        menuItemSelected = -1;
      }
    }
  }
  
  void showOSD(){
    if(menuActive){
      showMenu();
    }
  }
  
  void showMenu(){
    int itemCount = menu.size();
    int textSize = 10;
    int boxItemHeight = textSize * 15 / 10;
    int yPos = yBox + 5;
    int boxItemWidth = wBox / 10;

    stroke(#505050);
    textSize(textSize);
    for(String item: menu){
      boxItemWidth = int(max(boxItemWidth, textWidth(item + "    ")));
    }
    menuItemSelected = -1;
    int itemNum = 0;
    for(String item: menu){
      int x1 = xBox + wBox / 2 - boxItemWidth / 2;
      int y1 = yPos;
      int x2 = xBox + wBox / 2 + boxItemWidth / 2;
      int y2 = yPos + textSize;
      if(mouseInRect(x1,y1,x2,y2)){
        fill(#e0e0e0);
        menuItemSelected = itemNum;
      } else {
        if(menuItemIsSelected(itemNum)){
          fill(#c0c0c0);
        } else {
          fill(#909090);
        }
      }
      rect(xBox + wBox / 2 - boxItemWidth / 2, yPos, boxItemWidth,boxItemHeight);
      fill(#a04040);
      text(item, xBox + wBox / 2 - textWidth(item) / 2, yPos + textSize);
      yPos += boxItemHeight;
      itemNum++;
    }
  }
  
  void addMenuItem(String item){
    menu.add(item);
  }
  
  void menuItemSelected(int menuItemSelected){
    println(menu.get(menuItemSelected));
  }
  
  boolean menuItemIsSelected(int menuItemSelected){
    return false;
  }
  
  boolean mouseInChart(){
    // return mouseX >= xBox && mouseX <= xBox + wBox && mouseY >= yBox && mouseY <= yBox + hBox;
    return mouseInRect(xBox,yBox,xBox + wBox,yBox + hBox);
  }
  
  boolean mouseInRect(int x1, int y1,int x2,int y2){
    return mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2;
  }
  
  void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    println(e);
  }

  float log10(float x) {
    return (log(x) / log(10));
  }
  
  float stepSize(float min, float max) {
    return ( max - min ) / 10.0;
  }

  String humanNumber(float value){
    String text;
    float stepShow = value;
    float log10 = log10(stepShow);
    String unit = "";
    if(log10 >= 6){
      stepShow /= 1000000;
      unit = "M";
    } else if(log10 >= 3){
      stepShow /= 1000;
      unit = "K";
    } else if(log10 == 0){
    } else if(log10 <= -6){
      stepShow *= 1000000.0;
      unit = "u";
    } else if(log10 <= -3){
      stepShow *= 1000.0;
      unit = "m";
    }
    text = str(round(stepShow * 10.0) / 10.0 ) + unit;
    return text;
  }
  
}


