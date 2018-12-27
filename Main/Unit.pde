class Unit{
  int x, y;
  int unit = 20;
  int zeroX = width/2;
  int buffer = 50;
  Unit(int x, int y){
    this.x = x;
    this.y = y;
  }
  void drawSnakePiece(boolean head){
    fill(0, 255, 0);
    if(head){
      fill(0, 255, 255);
    }
    rect(x*unit + (zeroX + buffer), y*unit + buffer, unit, unit);
  }
  
  void drawApple(){
    fill(255, 0, 0);
    rect(x*unit + (zeroX + buffer), y*unit + buffer, unit, unit);
  }

  public int getX(){ 
    return this.x; 
  }
  public int getY(){ 
    return this.y; 
  }
  public void setX(int X){
    this.x = X;
  }
  
  public void setY(int y){
    this.y = y;
  }
}
