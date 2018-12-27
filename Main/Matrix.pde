class Matrix{
  public double[][] m;
  
  public Matrix(int r, int c){
    this.m = new double[r][c];
  }
  
  public Matrix(double[][] m){
    this.m = m;
  }
  
  void printMatrix(){
    for(int i = 0; i < m.length; i++){
      for(int j = 0; j < m[i].length; j++){
        print(m[i][j] + " ");
      }
       println();
    }
  }
  
  void fill(double x){
    for(int i = 0; i < m.length; i++){
      for(int j = 0; j < m[i].length; j++){
        m[i][j] = x;
      }
    }
  }
  
  Matrix scale(double x){
    Matrix out = new Matrix(this.m);
    for(int i = 0; i < m.length; i++){
      for(int j = 0; j < m[i].length; j++){
        out.m[i][j] *= x;
      }
    }
    return out;
  }
  
  Matrix divide(double x){
    Matrix out = new Matrix(this.m);
    for(int i = 0; i < m.length; i++){
      for(int j = 0; j < m[i].length; j++){
        out.m[i][j] /= x;
      }
    }
    return out;
  }
  
  // Multiplies each element of two nxn matrices
  Matrix elementMult(Matrix b){
    Matrix out = new Matrix(this.m);
    for(int i = 0; i < m.length; i++){
      for(int j = 0; j < m[i].length; j++){
        out.m[i][j] *= b.m[i][j]; 
      } 
    }
    return out;
  }
  
  Matrix subFromScalar(double x){
    Matrix out = new Matrix(this.m);
    for(int i = 0; i < m.length; i++){
      for(int j = 0; j < m[i].length; j++){
        out.m[i][j] = x - out.m[i][j];
      }
    }
    return out;
  }
  
  void set(int r, int c, double v){
    m[r][c] = v;
  }
  
  // need rows from m and columns from b for new matrix
  // may implement overloaded method for strassen's at some point
  Matrix mult(Matrix b){
    Matrix multiply = new Matrix(this.getNumRows(), b.getNumCols());
    double sum = 0;
    
    for (int i = 0; i < this.getNumRows(); i++) {
        for (int j = 0; j < b.getNumCols(); j++)
        {  
           for (int k = 0; k < b.getNumRows(); k++)
           {
              sum = sum + this.m[i][k]*b.m[k][j];
           }
 
           multiply.m[i][j] = sum;
           sum = 0;
        }
     }
     return multiply;
  }
  
  Matrix transpose(){
    Matrix out = new Matrix(this.getNumCols(), this.getNumRows());
    for (int i = 0; i < m.length; i++)
      for (int j = 0; j < m[0].length; j++)
        out.m[j][i] = m[i][j];
    return out;
  }
  
  int getNumRows(){
    return this.m.length;
  }
  
  int getNumCols(){
    return this.m[0].length;
  }
  
  double get(int r, int c){
    return this.m[r][c];
  }
  
}
