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
      int n = first;
      float prevX = 123456789.0;
      float prevY = 123456789.0;
      stroke(colors.get(variables.get(v).index % colors.size()));
      do{
        posX = calcX(ts[n],v); // x+(float)(ts[n] % timeSize) * (float)w / (float)timeSize;
        float val = values.get(v)[n];
        posY = calcY(val,v); // y + h - val * h / ( variables.get(v).getRangeSize() );
        //println("" + v + " " + ts[n] + " " + posX + "," + posY);
        if(prevX != 123456789.0 && prevX < posX){
          line(prevX,prevY,posX,posY);
        }
        if(++n >= logSize){
          n = 0;
        }
        prevX = posX;
        prevY = posY;
      }while( n != last);
    }
  }

}

