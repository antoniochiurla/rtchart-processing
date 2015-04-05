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
      Variable var = variables.get(v);
      int n = var.source.first;
      stroke(colors.get(variables.get(v).index % colors.size()));
      while( n != var.source.last){
        posX = x+(float)(ts[n] % timeSize) * (float)w / (float)timeSize;
        float val = values.get(v)[n];
        posY = y + h - val * h / ( variables.get(v).getRangeSize() );
        //println("" + v + " " + ts[n] + " " + posX + "," + posY);
        point(posX,posY);
        if(++n >= logSize){
          n = 0;
        }
      }
    }
  }
}

