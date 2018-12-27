class Data{
  private Matrix inputs;
  private double maxInput;
  
  public Data(Matrix inputs, double maxInput) {
    this.inputs = inputs;
    this.maxInput = maxInput;
  }
  
  public void cleanData() {
    inputs = inputs.divide(maxInput);
  }
  
  public Matrix getInputs() {
    return this.inputs;
  }
  
  void printInputs(){
    inputs.printMatrix();
  }
}
