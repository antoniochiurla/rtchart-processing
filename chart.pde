class Chart
{
  String name;
  int x, y, w, h;
  int xBox, yBox, wBox, hBox;
  int xBorderLeft, xBorderRight, yBorderTop, yBorderBottom;
  int r = 10; // round rec
  int logSize = 200;
  long ts[];
  long timeSize; // in milliseconds
  ArrayList<float []> values;
  ArrayList<Variable> variables;
  Variable defaultVariable = new Variable(0,float.class,0,10,true);
  boolean menuActive = false;
  int menuItemSelected = -1;
  ArrayList<String> menu;
  ArrayList<Integer> colors = new ArrayList();
  
  int first, last;
  
  Chart(String name){
    this.name = name;
    println("Name: " + name);
    variables = new ArrayList<Variable>();
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
    ts = new long[ logSize ];
    first = 1;
    last = -1;
  }
  
  void draw(){
    stroke(#202020);
    fill(#c0c0c0);
    rect(xBox,yBox,wBox,hBox,r);
    handleMenu();
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
        fill(#c0c0c0);
        menuItemSelected = itemNum;
      } else {
        fill(#e0e0e0);
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
  
  boolean mouseInChart(){
    // return mouseX >= xBox && mouseX <= xBox + wBox && mouseY >= yBox && mouseY <= yBox + hBox;
    return mouseInRect(xBox,yBox,xBox + wBox,yBox + hBox);
  }
  
  boolean mouseInRect(int x1, int y1,int x2,int y2){
    return mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2;
  }
  
  void addInputs( long ts, float[] inputs ){
    last++;
    if(last >= logSize){
      last = 0;
    }
    if(last == first){
      first++;
      if(first >= logSize){
        first = 0;
      }
    }
    this.ts[last] = ts;
    for(int v = 0; v < variables.size(); v++){
      values.get(v)[last] = inputs[variables.get(v).index];
    }
  }
  
}

