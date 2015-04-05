class SourceFile extends Source {
  File file;

  SourceFile(File file) {
    super(TYPE_FILE);
    this.file = file;
  }

}
