class SourceSerial extends Source {
  Serial port;

  SourceSerial(Serial port) {
    super(TYPE_SERIAL);
    this.port = port;
  }

  void serialEvent(Serial port) {
    while (port.available() > 0) {
      int ch = port.read();
      serialBuffer += (char)ch;
      if (ch == '\n') {
        parseInputs(serialBuffer);
        serialBuffer="";
      }
    }
  }
  
}
