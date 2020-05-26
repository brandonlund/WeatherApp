class MyButton
{
  float x, y, w, h;
  int screen, curr_screen;
  
  MyButton(float x, float y, float w, float h, String name, int curr_screen, int screen)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.screen = screen;
    this.curr_screen = curr_screen;
    fill(#002D5A);
    rectMode(CENTER);
    textAlign(CENTER);
    textSize(displayWidth/50);
    rect(x, y, w, h, 7);
    fill(#FFFFFF);
    text( name, x, y );
  }
  
  int check_press()
  {
    float lx = x - w/2; // left
    float rx = x + w/2; // right
    float by = y + h/2; // bottom
    float ty = y - h/2; // top
    
    if ( mouseX > lx && mouseX < rx
        && mouseY < by && mouseY > ty
        && mousePressed )
    {
      println("Pressed");
      return screen;
    }
    else
    {
      return curr_screen;
    }
  }
}
