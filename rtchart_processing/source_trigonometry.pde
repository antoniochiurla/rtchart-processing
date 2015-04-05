class SourceTrigonometry extends Source {

  long tsNow = 0;

  SourceTrigonometry() {
    super(TYPE_TRIGONOMETRY);
  }

  void inputs(){
    tsNow += 20;
    String[] values = new String[13];
    values[0] = "" + tsNow;
    values[1] = "" + (sin(tsNow / 1000.0));
    values[2] = "" + (cos(tsNow / 1000.0));
    values[3] = "" + (tan(tsNow / 1000.0));
    values[4] = "" + (atan((tsNow / 1000.0) % 5));
    // charts.addInputs(ts,inputs);
    parseInputs(join(values,":"));
  }

}
