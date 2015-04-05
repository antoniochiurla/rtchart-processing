import processing.serial.*;
int nRows = 3;
int nCols = 2;
Charts charts;
long ts;
String serialBuffer = "";
Serial serial;

void setup(){
  size(800,600);
  charts = new Charts(nRows, nCols);
  
  Source source;
  source = new SourceRandom();
  charts.addSource(source);
  Variable varTime = new Variable("Time",0,Variable.TYPE_TIME,0,1,0,10,false);
  source.addVariable(varTime);
  Variable varX = new Variable("X",1,Variable.TYPE_FLOAT,0,1,0,10,false);
  source.addVariable(varX);
  Variable varY = new Variable("Y",2,Variable.TYPE_FLOAT,0,1,0,10,false);
  source.addVariable(varY);
  Variable varZ = new Variable("Z",3,Variable.TYPE_FLOAT,0,1,0,10,false);
  source.addVariable(varZ);
  Variable varV = new Variable("V",4,Variable.TYPE_FLOAT,0,1,0,10,false);
  source.addVariable(varV);
  
  Chart chart;
 
  chart = new ChartDiamond("Diam");
  chart.addVariable(varX);
  chart.addVariable(varY);
  chart.addVariable(varZ);
  chart.logSize = 10;
  charts.addChart( chart );
  
  chart = new ChartSpeedometer("Speed");
  chart.addVariable(varV);
  chart.logSize = 5;
  charts.addChart( chart );
  
  chart = new ChartLines("XYZ");
  chart.addVariable(varX);
  chart.addVariable(varY);
  chart.addVariable(varZ);
  charts.addChart( chart );

  // serial = new Serial(this, "/dev/ttyUSB0", 57600);

}

void draw(){
  charts.dummyInputs();
  charts.draw();
}

void dummyInputs(){
  ts+= 20;
  float[] inputs = new float[12];
  String[] values = new String[13];
  values[0] = "" + ts;
  for(int v = 1; v < 12; v++){
    float range = (float)(((float)ts/500.0)%(10.0));
    inputs[v] = random(range-0.5 * sin(ts/100) * 3,range+0.5 * sin(ts/100) * 3);
    inputs[1] += 5.0;
    values[v+1] = str(inputs[v]);
  }
  // charts.addInputs(ts,inputs);
  XXparseInputs(join(values,":"));
}

void serialEvent(Serial port) {
  charts.serialEvent(port);
  /*
  while (serial.available() > 0) {
    int ch = serial.read();
    serialBuffer += (char)ch;
    if (ch == '\n') {
      parseInputs(serialBuffer);
      serialBuffer="";
    }
  }
  */
}
void XXparseInputs(String values){
  String[] tokens= splitTokens(values, ",=: ");
  float[] inputs = new float[tokens.length - 1];

  long ts = Long.parseLong( trim(tokens[0]) ); // primo valore
  for(int n=1; n<tokens.length; n++){
    inputs[n-1] = float( trim(tokens[n]) );
  }
  charts.XXaddInputs(ts,inputs);
}

void mouseWheel(MouseEvent event) {
  charts.mouseWheel(event);
}

