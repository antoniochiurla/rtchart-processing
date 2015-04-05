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
      if(logSize<variables.get(0).source.logSize){
        n = variables.get(0).source.last - logSize;
        if(n < 0){
          n = variables.get(0).source.logSize + n;
        }
      }
      stroke(colors.get(variables.get(v).index % colors.size()));
      while( n != var.source.last){
        posX = calcX(abscissa.source.values.get(abscissa.index)[n],v);
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

