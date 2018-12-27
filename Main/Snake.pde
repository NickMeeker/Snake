class Snake{
  ArrayList unitList;
  public boolean dead;
  public int score;
  public Snake(){
    unitList = new ArrayList();
    unitList.add(new Unit(4, 3));
    unitList.add(new Unit(4, 4));
    unitList.add(new Unit(4, 5));
    unitList.add(new Unit(4, 6));
    unitList.add(new Unit(4, 7));
    unitList.add(new Unit(4, 8));
    dead = false;
    score = 0;
  }
  
  void drawSnake(){
    for (int i = 0; i < unitList.size (); i++)
    {
      Unit snakePiece = (Unit) unitList.get(i);
      boolean head = false;
      if(i == unitList.size() - 1){
        head = true;
      }
      snakePiece.drawSnakePiece(head);
    }
  }
  
  void detectCollision(){
    Unit head = (Unit)unitList.get(unitList.size() - 1);
    if(head.x < 0 || head.x > NUMX-1 || head.y < 0 || head.y > NUMY-1){
      dead = true;
    }
    
    for(int i = unitList.size()-2; i >= 0; i--){
      Unit piece = (Unit)unitList.get(i);
      if(piece.x == head.x && piece.y == head.y){
        dead = true;
      }
    }
   
  }
  
  boolean detectApple(Apple apple){    
    Unit head = (Unit)unitList.get(unitList.size() - 1);
 
    if(head.x == apple.x && head.y == apple.y){
      apple.generateLocation();
      score++;
      return true;
    }
    
    return false;
  }
  
  void updateSnake(int direction, Apple apple){
    int oldHeadIndex = unitList.size() - 1;
    Unit oldHead = (Unit)unitList.get(oldHeadIndex);
    Unit newHead;
    switch(direction){
      // left
      case 0:
        newHead = new Unit(oldHead.getX() - 1, oldHead.getY());
        unitList.add(newHead);
        detectCollision();
        if(detectApple(apple)){
          break;
        }
        unitList.remove(0);
        break;
      // up
      case 1:
        newHead = new Unit(oldHead.getX(), oldHead.getY()-1);
        unitList.add(newHead);
        detectCollision();
        if(detectApple(apple)){
          break;
        }
        unitList.remove(0);
        break;
      // right
      case 2:
        newHead = new Unit(oldHead.getX() + 1, oldHead.getY());
        unitList.add(newHead);
        detectCollision();
        if(detectApple(apple)){
          break;
        }
        unitList.remove(0);
        break;
      // down
      case 3:
        newHead = new Unit(oldHead.getX(), oldHead.getY()+1);
        unitList.add(newHead);
        detectCollision();
        if(detectApple(apple)){
          break;
        }
        unitList.remove(0);
        break;
    }
  }
  
  // inputs are a 6x1 matrix:
    // 0, 1 --> evaluate left wall/body, left apple
    // 2, 3 --> evaluate up wall/body up apple
    // 4, 5 --> evaluate right
    // 6, 7 --> evaluate down
  Matrix updateInputs(Apple apple){
    Matrix inputs = new Matrix(12, 1);
    Unit head = (Unit)unitList.get(unitList.size() - 1);
    
    double distLeftWall = getDistLeftWall();
    double distLeftBody = distLeftBody();
    inputs.set(0, 0, distLeftWall);
    inputs.set(1, 0, distLeftBody);
    inputs.set(2, 0, dist(head.getX() - 1, head.getY(), apple.x, apple.y));
    
    double distUpWall = getDistUpWall();
    double distUpBody = distUpBody();
    inputs.set(3, 0, distUpWall);
    inputs.set(4, 0, distUpBody);
    inputs.set(5, 0, dist(head.getX(), head.getY() - 1, apple.x, apple.y));
    
    double distRightWall = getDistRightWall();
    double distRightBody = distRightBody();
    inputs.set(6, 0, distRightWall);
    inputs.set(7, 0, distRightBody);
    inputs.set(8, 0, dist(head.getX() + 1, head.getY(), apple.x, apple.y));
    
    double distDownWall = getDistDownWall();
    double distDownBody = distDownBody();
    inputs.set(9, 0, distDownWall);
    inputs.set(10, 0, distDownBody);
    inputs.set(11, 0, dist(head.getX(), head.getY() + 1, apple.x, apple.y));
    
    return inputs;
    
  }
  public ArrayList getUnitList() {
    return this.unitList;
  }
  
  public int getHeadX(){
    Unit head = (Unit)unitList.get(unitList.size() - 1);
    return head.x;
  }
  
  public int getHeadY(){
    Unit head = (Unit)unitList.get(unitList.size() - 1);
    return head.y;
  }
  
  public double getDistLeftWall(){
    Unit head = (Unit)unitList.get(unitList.size() - 1);
    
    // now test for wall
    double distanceLeftWall = dist(head.getX() - 1, head.getY(), -1, head.getY());

    
    return distanceLeftWall;
  }
  
  public double distLeftBody(){
    Unit head = (Unit)unitList.get(unitList.size() - 1);
    double minDistLeft = 1000000;
    // left, test for snake hitting itself
    for(int i = unitList.size() - 2; i >= 0; i--){
      Unit testPiece = (Unit)unitList.get(i);
      if(testPiece.getX() == head.getX()){
        double distance = dist(head.getX() - 1, head.getY(), testPiece.getX(), testPiece.getY());
        if(distance < minDistLeft){
          minDistLeft = distance;
        }
      }
    }
    
    if(minDistLeft == 1000000){
      minDistLeft = maxDist;
    }
    return minDistLeft;
  }
  public double getDistUpWall(){
    Unit head = (Unit)unitList.get(unitList.size() - 1);
    
    // now test for wall
    double distanceUpWall = dist(head.getX(), head.getY() - 1, head.getX(), -1);
    
    
    return distanceUpWall;
  }
  
  public double distUpBody(){
    Unit head = (Unit)unitList.get(unitList.size() - 1);
    double minDistUp = 1000000;
    // up, test for snake hitting itself
    for(int i = unitList.size() - 2; i >= 0; i--){
      Unit testPiece = (Unit)unitList.get(i);
      if(testPiece.getY() == head.getY()){
        double distance = dist(head.getX(), head.getY() - 1, testPiece.getX(), testPiece.getY());
        if(distance < minDistUp){
          minDistUp = distance;
        }
      }
    }
    if(minDistUp == 1000000){
      minDistUp = maxDist;
    }
    return minDistUp;
  }
  
  public double getDistRightWall(){
    Unit head = (Unit)unitList.get(unitList.size() - 1);
    
    // now test for wall
    double distanceRightWall = dist(head.getX() + 1, head.getY(), NUMX, head.getY());
    
    return distanceRightWall;
  }
  
  public double distRightBody(){
    Unit head = (Unit)unitList.get(unitList.size() - 1);
    double minDistRight = 1000000;
    // right, test for snake hitting itself
    for(int i = unitList.size() - 2; i >= 0; i--){
      Unit testPiece = (Unit)unitList.get(i);
      if(testPiece.getY() == head.getY()){
        double distance = dist(head.getX() + 1, head.getY(), testPiece.getX(), -1);
        if(distance < minDistRight){
          minDistRight = distance;
        }
      }
    }
    if(minDistRight == 1000000){
      minDistRight = maxDist;
    }
    return minDistRight;
  }
  
  public double getDistDownWall(){
    
    Unit head = (Unit)unitList.get(unitList.size() - 1);
    
    // now test for wall
    double distanceDownWall = dist(head.getX(), head.getY() + 1, head.getX(), NUMY);
    
    return distanceDownWall;
  }
  
  public double distDownBody(){
    Unit head = (Unit)unitList.get(unitList.size() - 1);
    double minDistDown = 1000000;
     // down, test for snake hitting itself
    for(int i = unitList.size() - 2; i >= 0; i--){
      Unit testPiece = (Unit)unitList.get(i);
      if(testPiece.getY() == head.getY()){
        double distance = dist(head.getX(), head.getY() + 1, testPiece.getX(), testPiece.getY());
        if(distance < minDistDown){
          minDistDown = distance;
        }
      }
    }
    if(minDistDown == 1000000){
      minDistDown = maxDist;
    }
    return minDistDown;  
  }
}
