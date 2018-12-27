class Game{
  GameUI gui;
  Snake snake;
  Apple apple;
  // 0 left, 1 up, 2 right, 3 down
  int direction;
  // empty parameters for play mode
  int score = 0;
  double df = 0;
  double distFromApple = 0;
  double distFromWall = 0;
  int numFrames = 0;
  public Game(){
    initGame();
  }
  
  void initGame(){
    gui = new GameUI();
    snake = new Snake();
    apple = new Apple();
    direction = -1;
    frameCount = 0;
  }
  void setDirection(int d){
    if(this.direction == 0 && d == 2){
      return;
    }
    
    if(this.direction == 1 && d == 3){
      return;
    }
    
    if(this.direction == 2 && d == 0){
      return;
    }
    
    if(this.direction == 3 && d == 1){
      return;
    }
    this.direction = d; 
  }
  
  void draw(){
    gui.draw(snake, apple);
    distFromApple = getDistFromApple();
    distFromWall = getDistFromWall();
    snake.updateSnake(direction, apple);
    snake.updateInputs(apple);
    numFrames++;
  }
  
  double getDistFromApple(){
    return dist(snake.getHeadX(), snake.getHeadY(), apple.x, apple.y);
  }
  
  double getDistFromWall(){
    switch(direction){
      case 0:
        return snake.getDistLeftWall();
      
      case 1:
        return snake.getDistUpWall();
        
      case 2:
        return snake.getDistRightWall();
        
      case 3:
        return snake.getDistDownWall();
        
       default:
         return 0;
    }
  }
  
  public double getChangeInFitness(){
    //if(snake.score > score){
    //  score = snake.score;
    //  df += score*100;
    //}
    
    
    if(snake.score > score){
      score = snake.score;
      df += 30;
    }
    
    if(snake.dead && snake.score == 0){
      df -= 30;
    }
    
    double newDistFromApple = getDistFromApple();
    if(newDistFromApple < distFromApple){
      df++;
    } else {
      df--;
    }
      
    
    return df;
  }
  void drawTrainingInfo(int currentSnake, int currentGeneration, double fitness){
    gui.drawTrainingInfo(currentSnake, currentGeneration, fitness);
    
    
    df = 0;
  }
  
  void checkSnakeLifespan(){
    if(frameCount > 1000){
      snake.dead = true;
    }
  }
  
  Snake getSnake(){
    return this.snake;
  }
  
  Apple getApple(){
    return this.apple;
  }
  
  
}
