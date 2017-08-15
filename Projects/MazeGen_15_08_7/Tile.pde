class Tile
{
  
  public int posX, posY, W, H;
  public char tex;
  public int R,G,B;
  public Direction dir;
  public Direction tag;
  
  
  public Tile(int x, int y, int size, Direction direction)
  {
    this.posX = x;
    this.posY = y;
    this.W = size;
    this.H = size;
    this.dir = direction;
  }
  
  
  public void display()
  {
    //stroke(R/2, G/2, B/2);
    fill(R,G,B);
    rect(posX, posY, W, H);
    
    fill(255,255,255);
    text(tex, posX + W/3, posY + H/1.8);
    
  }
  
  
}


public enum Direction
{
  
  NORTH, SOUTH, EAST, WEST, PENT
  
}