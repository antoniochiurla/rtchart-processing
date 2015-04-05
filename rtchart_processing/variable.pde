class Variable{
  static final int TYPE_FLOAT = 1;
  static final int TYPE_INT = 2;
  static final int TYPE_BOOLEAN = 3;
  static final int TYPE_TIME = 4;
  String name;
  Source source;
  int index;
  int type;
  float min;
  float max;
  float offset;
  float factor;
  boolean adapt;
  
  //Variable(String name, Source source, int index, int type, float min, float max, boolean adapt){
  Variable(String name, int index, int type, float offset, float factor, float min, float max, boolean adapt){
    this.name = name;
    this.index = index;
    this.type = type;
    this.min = min;
    this.max = max;
    this.offset = offset;
    this.factor = factor;
    this.adapt = adapt;
  }
  
  float getRangeSize(){
    return max - min;
  }
  
  void setSource(Source source){
    this.source = source;
  }
  
  void setMin(float min){
    this.min = min;
  }
  
  void setMax(float max){
    this.max = max;
  }
}
