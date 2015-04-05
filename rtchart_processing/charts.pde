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
  
  void addSource(Source source){
    sources.add(source);
  }
  
  void draw(){
    if( ! initialized ){
      init();
    }
    background(0);
    for(int n = 0; n < charts.size();n++){
      charts.get(n).draw();
      charts.get(n).showOSD();
    }
    
  }
  
  void XXaddInputs(long ts, float[] inputs){
    for(int n = 0; n < charts.size();n++){
      charts.get(n).XXaddInputs(ts,inputs);
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
  
  void mouseWheel(MouseEvent event) {
    for(int n = 0; n < charts.size();n++){
      if(charts.get(n).mouseInChart()){
        charts.get(n).mouseWheel(event);
      }
    }
  }

  void serialEvent(Serial port) {
    for(int s = 0; s < sources.size(); s++){
      if(sources.get(s) instanceof SourceSerial){
        SourceSerial sourceSerial = (SourceSerial)sources.get(s);
        if(sourceSerial.port == port){
          sourceSerial.serialEvent(port);
        }
      }
    }
  }
  
  void dummyInputs() {
    for(int s = 0; s < sources.size(); s++){
      if(sources.get(s) instanceof SourceRandom){
        SourceRandom sourceRandom = (SourceRandom)sources.get(s);
        sourceRandom.dummyInputs();
      }
    }
  }

}
