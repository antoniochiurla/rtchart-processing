class SourceRandom extends Source {
  
  long tsNow = 0;
  
  SourceRandom() {
    super(TYPE_RANDOM);
  }

  void dummyInputs(){
    tsNow += 20;
    float[] inputs = new float[12];
    String[] values = new String[13];
    values[0] = "" + tsNow;
    for(int v = 1; v < 12; v++){
      float range = (float)(((float)tsNow/500.0)%(10.0));
      inputs[v] = random(range-0.5 * sin(tsNow/100) * 2,range+0.5 * sin(tsNow/100) * 2);
      inputs[1] += 5.0;
      values[v] = str(inputs[v]);
    }
    // charts.addInputs(ts,inputs);
    parseInputs(join(values,":"));
  }

}
