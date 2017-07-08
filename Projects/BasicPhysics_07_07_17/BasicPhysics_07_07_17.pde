//I have been busy with visa / internship stuff recently so I made something simple for today.


class PhysicsObject
{

  PVector pos, vel, acc;
  int R,G,B;
  int r;
  float bounce;
  int topSpeedX = 10, topSpeedY = 10;
  
  public PhysicsObject(int radius, float bounce, PVector po, PVector ve, PVector ac)
  {
    r = radius;
    this.bounce = bounce;
    R = 255; G = 255; B = 255;
    pos = po;
    vel = ve;
    acc = ac;
  }
  
  //Update the object
  public void update()
  {
    this.move();
    this.display();
  }
  
  //Update Motion
  private void move()
  {
    this.pos.add(vel);
    
    if(vel.x > topSpeedX) { vel.x = topSpeedX; }
    if(vel.y > topSpeedY) { vel.y = topSpeedY; }
    
    this.vel.add(acc);
    this.checkBorder();
    
  }
  
  //Display Object
  private void display()
  {
    stroke(R,G,B);
    ellipse(pos.x, pos.y, r, r);
  }
  
  //check Borders
  private void checkBorder()
  {
    //if around the right and left border, reverse horizontal speed
    if( (this.pos.x + r) > width || (this.pos.x - r) < 0 )
    {
      this.vel.x = this.vel.x * -1;
    }
    
    //check floor and bounce
    if((this.pos.y - r) <= 0)
    {
      this.vel.y = this.vel.y * -1 * bounce;
    }
    
  }
  
  //apply a force of acceleration in a given direction and magnitude
  private void applyForce(int x, int y)
  {
    this.acc.add(new PVector(x, y));
  }
  
  
  //set color of display
  private void setColor(int r, int g ,int b)
  {
    R = r; G = g; B = b;
  }
  
}


PhysicsObject p;
void setup()
{
  size(400,400);
  
  PVector po = new PVector(width/50, height/50);
  p = new PhysicsObject(5, 0.6, po, new PVector(0,0), new PVector(0,0));

}


void draw()
{
  p.update();
  background(50);
}

void mousePressed()
{
  p.applyForce( (int)(p.pos.x - mouseX), 0);
}