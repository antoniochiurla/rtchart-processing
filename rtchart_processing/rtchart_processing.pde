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
  for(int n=0; n < 3; n++){
    Chart chart = new ChartLines("" + n + "P");
    chart.addVariable(new Variable(n,float.class,0,10,true));
    charts.addChart( chart );
  }
  for(int n=0; n < 3; n++){
    Chart chart = new ChartLines("" + n + "L");
    chart.addMenuItem("First");
    chart.addMenuItem("Second");
    chart.addMenuItem("Third");
    chart.addVariable(new Variable(n+3,float.class,0,10,true));
    chart.addVariable(new Variable(n+4,float.class,0,10,true));
    charts.addChart( chart );
  }
  serial = new Serial(this, "/dev/ttyUSB0", 57600);

}

void draw(){
  // dummyInputs();
  charts.draw();
}

void dummyInputs(){
  ts+= 20;
  float[] inputs = new float[12];
  String[] values = new String[13];
  values[0] = "" + ts;
  for(int v = 0; v < 12; v++){
    float range = (float)(((float)ts/500.0)%(10.0));
    inputs[v] = random(range-0.5 * sin(ts/100) * 3,range+0.5 * sin(ts/100) * 3);
    values[v+1] = str(inputs[v]);
  }
  //charts.addInputs(ts,inputs);
  parseInputs(join(values,":"));
}

void serialEvent(Serial port) {
  while (serial.available() > 0) {
    int ch = serial.read();
    serialBuffer += (char)ch;
    if (ch == '\n') {
      parseInputs(serialBuffer);
      serialBuffer="";
    }
  }
}
void parseInputs(String values){
  String[] tokens= splitTokens(values, ",=: ");
  float[] inputs = new float[tokens.length - 1];

  long ts = Long.parseLong( trim(tokens[0]) ); // primo valore
  for(int n=1; n<tokens.length; n++){
    inputs[n-1] = float( trim(tokens[n]) );
  }
  charts.addInputs(ts,inputs);
}
