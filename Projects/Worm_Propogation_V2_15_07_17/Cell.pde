class Cell 
{
  
  
  boolean impass = false; //Impass cells cannot be converted and displayed differently
  float state;        //-1 = infected, 0 = healthy, 1 = immune
  int X, Y;        //Position of the Cell (position on the canvas)
  int iX, iY;      //index Position of the Cell (position relative to grid) //<>// //<>// //<>//
  int size;        //Size of cell //<>// //<>//
  color col;
  String text = "H";
  float resistance; //chance for this cell to resist cell interactions half as effective against infected cells
  
  public Cell(int iX, int iY, int posX, int posY, int size, float resistance )
  {
    this.state = 0;
    this.X = posX;
    this.Y = posY;
    this.iX = iX;
    this.iY = iY;
    this.size = size;
    this.resistance = resistance;
  }
  
  
  public void setColor(int r, int g, int b)
  {
    col = color(r,g,b);
  };

  //Draw the cell, color is set on the table's display function
  public void display()
  {
    

    
    
    //set colors
    stroke(col/2);
    fill(col); //<>// //<>//
    rect(X, Y, size, size);
    
    //draw the text box
    fill(-col % 255);
    textSize(this.size * 0.41);
    text(text, X + size/2  * 0.29, this.Y + size * 0.7);
    
    
  }
  
}