class Apple{
  int x;
  int y;
  Unit apple;
  public Apple(){
    this.x = (int)random(0, NUMX);
    this.y = (int)random(0, NUMY);
    apple = new Unit(x, y);
  }
  
  void generateLocation(){
    this.x = (int)random(0, NUMX);
    this.y = (int)random(0, NUMY);
    apple = new Unit(x, y);
  }
  
  void drawApple(){
    apple.drawApple();
  }
}
