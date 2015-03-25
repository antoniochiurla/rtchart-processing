class ChartPoints extends Cartesian
{
  
  ChartPoints(String name){
    super(name);
  }
  
  void draw(){
    super.draw();
    stroke(0);
    float posX, posY;
    for(int v = 0; v < variables.size(); v++){
      int n = first;
      stroke(colors.get(variables.get(v).index % colors.size()));
      do{
        posX = x+(float)(ts[n] % timeSize) * (float)w / (float)timeSize;
        float val = values.get(v)[n];
        posY = y + h - val * h / ( variables.get(v).getRangeSize() );
        //println("" + v + " " + ts[n] + " " + posX + "," + posY);
        point(posX,posY);
        if(++n >= logSize){
          n = 0;
        }
      }while( n != last);
    }
  }
}

