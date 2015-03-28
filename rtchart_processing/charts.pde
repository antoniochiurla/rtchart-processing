class Charts
{
  int rows, cols;
  int round = 5;
  ArrayList<Chart> charts = new ArrayList<Chart>();
  ArrayList<Source> sources = new ArrayList<Source>();
  boolean initialized = false;
  
  Charts(int rows, int cols){
    this.rows = rows;
    this.cols = cols;
  }
  
  void addChart(Chart chart){
    charts.add(chart);
  }
  
  void draw(){
    if( ! initialized ){
      init();
    }
    background(0);
    for(int r = 0; r < nRows; r++){
      for(int c = 0; c < nCols; c++){
        int n = r * cols + c;
        if( n < charts.size()){
          charts.get(n).draw();
          charts.get(n).showOSD();
        }
      }
    }
    
  }
  
  void addInputs(long ts, float[] inputs){
    for(int r = 0; r < nRows; r++){
      for(int c = 0; c < nCols; c++){
        int n = r * cols + c;
        if( n < charts.size()){
          charts.get(n).addInputs(ts,inputs);
        }
      }
    }
  }
  
  void init(){
    int wBlock = width / nCols;
    int hBlock = height / nRows;
    for(int r = 0; r < nRows; r++){
      for(int c = 0; c < nCols; c++){
        int n = r * cols + c;
        if( n < charts.size()){
          charts.get(n).setRect(
            c * wBlock,
            r * hBlock,
            wBlock,
            hBlock
           );
        }
      }
    }
  }
}
