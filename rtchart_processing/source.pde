class Source {
  static final int TYPE_SERIAL = 1;
  static final int TYPE_FILE = 2;
  static final int TYPE_RANDOM = 3;
  static final int TYPE_TRIGONOMETRY = 4;

  static final int FORMAT_CSV = 1;
  static final int FORMAT_SCSV = 2;
  static final int FORMAT_COLONSV = 3;
  
  int type;
  int format;
  int logSize = 200;
  long[] ts;
  ArrayList<float []> values;
  int first, last;
  
  ArrayList<Variable> variables = new ArrayList<Variable>();
  
  Source(int type) {
    this.type = type;
    initLog();
  }
  
  void addVariable(Variable variable){
    variables.add(variable);
    variable.setSource(this);
    initLog();
  }

  void initLog(){
    values = new ArrayList<float []>();
    for(int v = 0; v < variables.size(); v++){
      values.add(new float[ logSize ]);
    }
    ts = new long[ logSize ];
    first = 1;
    last = -1;
  }
  
  void addInputs( long ts, float[] inputs ){
    last++;
    if(last >= logSize){
      last = 0;
    }
    if(last == first){
      first++;
      if(first >= logSize){
        first = 0;
      }
    }
    this.ts[last] = ts;
    for(int v = 0; v < variables.size(); v++){
      values.get(v)[last] = inputs[variables.get(v).index];
    }
  }

  void parseInputs(String values){
    println(values);
    String[] tokens= splitTokens(values, ",=: ");
    float[] inputs = new float[tokens.length - 1];
  
    long ts = Long.parseLong( trim(tokens[0]) ); // primo valore
    for(int n=1; n<tokens.length; n++){
      inputs[n-1] = float( trim(tokens[n]) );
    }
   addInputs(ts,inputs);
  }
}
