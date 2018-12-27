class Play{
  Game g;
  public Play(){
    g = new Game();
  }
  
  void draw(){
    g.draw();
  }
  
  void updateDirection(int d){
    g.setDirection(d);
    
     if(g.getSnake().dead){
      g = new Game();
      g.setDirection(-1);
    }
  }
}
