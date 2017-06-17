/*
*  This is part of a project where I attempt to write something intresting everyday
*
*  This one will be simple since I don't have much in my hands today
*/


class Walker
{
  int x,y;
  
  public Walker(int x , int y)
  {
    this.x = x;
    this.y = y;
  }
  
  public void moveWalker(int v, int isHorizontal)
  {
    if(isHorizontal == 1){x += v;}
    else{y += v;}
  }
  
  public void drawWalker()
  {
    stroke(floor(random(0,255)),floor(random(0,255)),floor(random(0,255)));
    point(x,y);
  }
  
}


class WalkerController
{
  ArrayList<Walker> walkers = new ArrayList<Walker>();
  
  //spawn a walker
  void addWalker()
  {
    Walker w = new Walker(mouseX, mouseY);
    walkers.add(w);
  }
  
  public WalkerController()
  {
    Walker w = new Walker(width/2,height/2);
    walkers.add(w);
  }
  
  public void drawWalkers()
  {
    for(Walker w : walkers)
    {
      w.drawWalker();
    }
  }
  
  public void moveWalkers()
  {
    for(Walker w : walkers)
    {
      w.moveWalker(floor(random(-1,2)), floor(random(0,2)));
    }
  }
  
}



WalkerController wc;

void mousePressed()
{
  wc.addWalker();
}

void setup()
{
  size(400,400);
  wc = new WalkerController();
  background(255);
}

void draw()
{
  wc.drawWalkers();
  wc.moveWalkers();
}