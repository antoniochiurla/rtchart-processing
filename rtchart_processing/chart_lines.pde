class ChartLines extends Cartesian
{
  
  ChartLines(String name){
    super(name);
  }
  
  void draw(){
    super.draw();
    stroke(0);
    float posX, posY;
    for(int v = 0; v < variables.size(); v++){
      Variable var = variables.get(v);
      int n = var.source.first;
      float prevX = 123456789.0;
      float prevY = 123456789.0;
      stroke(colors.get(v % colors.size()));
      while( n != var.source.last){
        posX = calcX(var.source.ts[n],v); // x+(float)(ts[n] % timeSize) * (float)w / (float)timeSize;
        float val = var.source.values.get(var.index)[n];
        posY = calcY(val,v); // y + h - val * h / ( variables.get(v).getRangeSize() );
        //println("" + v + " " + ts[n] + " " + posX + "," + posY);
        if(prevX != 123456789.0 && prevX < posX){
          line(prevX,prevY,posX,posY);
        }
        if(++n >= var.source.logSize){
          n = 0;
        }
        prevX = posX;
        prevY = posY;
      }
    }
  }

}

