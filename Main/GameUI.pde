class GameUI{
  // want to make an nxn game board
  int buffer = 50;
  int n = 30;
  int cellSize = 20;
  int girdLines = 4;
  // only using half the window
  int zeroX = width/2;
  
  public GameUI(){
    
  }
  
  void drawGridLines(){
    for(int i = 0; i < n; i++){
      for(int j = 0; j < n; j++){
        fill(0);
        stroke(0);
        int x = i*cellSize + (zeroX + buffer);
        int y = j*cellSize + buffer;
        
        rect(x, y, cellSize, cellSize);
      }
    }
  }
  
  void drawTrainingInfo(int currentSnake, int currentGeneration, double fitness){
    fill(0);
    textSize(32);
    text(("Generation: " + currentGeneration), 100, 200);
    text(("Snake: " + currentSnake), 100, 230);
    text(("Fitness: " + fitness), 100, 260);
  }
  void draw(Snake snake, Apple apple){
    fill(150);
    rect(zeroX, 0, width/2 - 2, height - 2, 7);
    //fill(0);
    //println(height - 2*buffer);
    //rect(zeroX + buffer, 0 + buffer, width/2 - 2*buffer, height - 2*buffer);
    drawGridLines();
    snake.drawSnake();
    apple.drawApple();
    fill(0);
    textSize(32);
    text(("Score: " + snake.score), width/2 + 75, 20);
    
  }
}
