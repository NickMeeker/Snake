public int HEIGHT = 700;
public int WIDTH = 1400;
public int NUMX = 30;
public int NUMY = 30;
public double maxDist = dist(0, 0, NUMX, NUMY);
Play p;
Train t;
Game g;

// 0 --> menu
// 1 --> train
// 2 --> test
// 3 --> play
public int mode = 0;

public int direction = -1;
void setup(){
  size(1400, 700);
  background(150);
  stroke(0);
  noFill();
  println(height);
  p = new Play();
  t = new Train();
}

void keyPressed(){
  if(mode != 3)
    return;
  if(keyCode == LEFT){
        direction = 0;
      } else if(keyCode == UP){
        direction = 1;
      } else if(keyCode == RIGHT){
        direction = 2;
      } else if(keyCode == DOWN){
        direction = 3;
      }
}

void draw(){
    background(150);
    Button trainingButton = new Button(150, HEIGHT/4 - 50, 350, 100, "Train");
    Button testingButton = new Button(150, HEIGHT/2 - 50, 350, 100, "Test");
    Button playButton = new Button(150, 3*HEIGHT/4 - 50, 350, 100, "Play");
    Button backButton = new Button(150, HEIGHT/8 - 50, 250, 100, "Back");
    Button killButton = new Button(150, 7*HEIGHT/8 - 50, 125, 100, "Kill"); 
  if(mode == 0){
    trainingButton.draw();
    testingButton.draw();
    playButton.draw();
  }
   else {
     backButton.draw();
   }
   
   if(mode == 1){
     killButton.draw();
   }
    
  if(mousePressed){
    if(trainingButton.isPressed()){
      println("You want to train.");
      mode = 1;
    }
    
    if(testingButton.isPressed()){
      println("You want to test.");
      mode = 2;
    }
    
    if(playButton.isPressed()){
      println("You want to play.");
      mode = 3;
    }
    
    if(backButton.isPressed()){
      mode = 0;
    }
    
    if(killButton.isPressed()){
      t.kill();
    }
  }
  
  if(mode == 1){
    // training
    t.go();
    
  }
  
  if(mode == 2){
    // testing
    
  }
  
  if(mode == 3){
    p.draw();
    p.updateDirection(direction);
  }
}
