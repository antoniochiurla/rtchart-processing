class Charts
{
  int rows, cols;
  int row = 0, col = 0;
  int round = 5;
  ArrayList<ArrayList<Chart>> charts;
  boolean initialized = false;
  
  Charts(int rows, int cols){
    this.rows = rows;
    this.cols = cols;
    charts = new ArrayList<ArrayList<Chart>>(this.rows);
    for(int r = 0; r < nRows; r++){
      charts.add(new ArrayList<Chart>(this.cols));
    }
  }
  
  void addChart(Chart chart){
    charts.get(row).add(chart);
    col++;
    if(col >= cols){
      col = 0;
      row++;
    }
  }
  
  void draw(){
    if( ! initialized ){
      init();
    }
    background(0);
    for(int r = 0; r < nRows; r++){
      for(int c = 0; c < nCols; c++){
        try{
          charts.get(r).get(c).draw();
          charts.get(r).get(c).showOSD();
          // println("" + r + "," + c);
        }catch(IndexOutOfBoundsException ioobe){
        }
      }
    }
    
  }
  
  void addInputs(long ts, float[] inputs){
    for(int r = 0; r < nRows; r++){
      for(int c = 0; c < nCols; c++){
        try{
          charts.get(r).get(c).addInputs(ts,inputs);
        }catch(IndexOutOfBoundsException ioobe){
        }
      }
    }
  }
  
  void init(){
    int wBlock = width / nCols;
    int hBlock = height / nRows;
    for(int r = 0; r < nRows; r++){
      for(int c = 0; c < nCols; c++){
        try{
          charts.get(r).get(c).setRect(
            c * wBlock,
            r * hBlock,
            wBlock,
            hBlock
           );
        }catch(IndexOutOfBoundsException ioobe){
        }
      }
    }
  }
}
