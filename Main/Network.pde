class Network{
  ArrayList<Data> inputs;
  ArrayList<Data> testData;
  int numInputs = 12;
  int numHidden = 8;
  int numOutputs = 4;
  double learningRate = .1;
  Matrix weights;
  Matrix outputs;
  Matrix outputWeights;
  
  public Network(){
    this.weights = new Matrix(numHidden, numInputs);
    this.outputWeights = new Matrix(numOutputs, numHidden);
    this.outputs = new Matrix(numOutputs, 1);
    
    // need to initialize weights to random values 0-1

    for(int i = 0; i < this.weights.getNumRows(); i++) {
      for(int j = 0; j < this.weights.getNumCols(); j++) {
        this.weights.set(i, j, random(-1, 1));
      }
    }
    
    for(int i = 0; i < this.outputWeights.getNumRows(); i++) {
      for(int j = 0; j < this.outputWeights.getNumCols(); j++) {
        this.outputWeights.set(i, j, random(-1, 1));
      }
    }
  }
  
  public void setWeights(Matrix weights){
    this.weights = weights;
  }
  
  public void setOutputWeights(Matrix outputWeights){
    this.outputWeights = outputWeights;
  }
  
  public void printWeights(){
    this.weights.printMatrix();
  }
  public double sigmoid(double x) {
    return 1.0 / (double)(1 + Math.pow(Math.E, -x));
  }
  
  public double relu(double x){
    if(x > 0){
      return x;
    } else {
      return 0;
    }
  }
  
  public Matrix calcDelta(Matrix E, Matrix O, Matrix hy) {
    Matrix negO = O;
    negO = negO.scale(-1);
    Matrix output = O;
    
    
    output = output.elementMult(O.subFromScalar(1));
    output = output.elementMult(E);
    output = output.scale(learningRate);
    output = output.mult(hy.transpose());

    return output;
  }
  
  public int feedforward(Data input) {
    // Step 1: Calculate hidden X:
    Matrix hx = weights.mult(input.getInputs());
    // hx.printMatrix();
    
    // Step 2: Calculate sigmoids
    Matrix hy = new Matrix(this.numHidden, 1);
    for(int j = 0; j < hy.getNumRows(); j++) {
      hy.set(j, 0, sigmoid(hx.get(j, 0)));
    }
    
    // Step 3: Calculate output x:
    Matrix ox = outputWeights.mult(hy);
    
    // Step 4: Calculate output sigmoids:
    Matrix oy = new Matrix(numOutputs, 1);
    for(int j = 0; j < oy.getNumRows(); j++) {
      oy.set(j, 0, sigmoid(ox.get(j, 0)));
    }

    return determineOutput(oy);
  }
  
  // hardcoding this for now
  public int determineOutput(Matrix oy) {
    int maxIndex = 0;
    double max = -100000000;
    for(int i = 0; i < oy.getNumRows(); i++) {
      if(oy.get(i, 0) > max) {
        max = oy.get(i, 0);
        maxIndex = i;
      }
    }
    
    return maxIndex;
  }
}
