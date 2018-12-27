class Button{
  int x;
  int y;
  int w;
  int h;
  String label;
  
  public Button(int x, int y, int w, int h, String label){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }
  
  public boolean isPressed(){
   return (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h); 
  }
  
  void draw() {
    fill(218);
    rect(x, y, w, h, 7);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x + w/2, y + h/2);
  }
}
