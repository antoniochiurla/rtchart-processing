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
  chart.setLogSize(10);
  charts.addChart( chart );
  
  chart = new ChartSpeedometer("Speed");
  chart.addVariable(varV);
  chart.setLogSize(5);
  charts.addChart( chart );
  
  ChartLines chartLines = new ChartLines("XYZ");
  chartLines.setAbscissa(varTime);
  chartLines.addVariable(varX);
  chartLines.addVariable(varY);
  chartLines.addVariable(varZ);
  charts.addChart( chartLines );

  source = new SourceTrigonometry();
  charts.addSource(source);
  varTime = new Variable("Time",0,Variable.TYPE_TIME,0,1,0,10,false);
  source.addVariable(varTime);
  Variable varSin = new Variable("Sin",1,Variable.TYPE_FLOAT,0,1,0,10,false);
  source.addVariable(varSin);
  Variable varCos = new Variable("Cos",2,Variable.TYPE_FLOAT,0,1,0,10,false);
  source.addVariable(varCos);
  Variable varTan = new Variable("Tan",3,Variable.TYPE_FLOAT,0,1,0,10,false);
  source.addVariable(varTan);
  Variable varATan = new Variable("ATan",4,Variable.TYPE_FLOAT,0,1,0,10,false);
  source.addVariable(varATan);
  chartLines = new ChartLines("Trig");
  chartLines.setAdapt(false);
  chartLines.setAbscissa(varTime);
  chartLines.addVariable(varSin);
  chartLines.addVariable(varCos);
  chartLines.addVariable(varTan);
  chartLines.addVariable(varATan);
  chartLines.min = -2;
  chartLines.max = 2;
  charts.addChart( chartLines );

  // serial = new Serial(this, "/dev/ttyUSB0", 57600);

}

void draw(){
  charts.dummyInputs();
  charts.draw();
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

void mouseWheel(MouseEvent event) {
  charts.mouseWheel(event);
}

