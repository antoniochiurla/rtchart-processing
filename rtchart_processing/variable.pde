class Variable{
  int index;
  Class clazz;
  float min;
  float max;
  boolean adapt;
  
  Variable(int index, Class clazz, float min, float max, boolean adapt){
    this.index = index;
    this.clazz = clazz;
    this.min = min;
    this.max = max;
    this.adapt = adapt;
  }
  
  float getRangeSize(){
    return max - min;
  }
  
  void setMin(float min){
    this.min = min;
  }
  
  void setMax(float max){
    this.max = max;
  }
}
