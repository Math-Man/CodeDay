class Cell 
{
  
  int state;        //-1 = healthy, 0 = infected, 1 = immune
  int X, Y;        //Position of the Cell 
  int size;        //Size of cell //<>// //<>//
  
  public Cell(int posX, int posY, int size)
  {
    this.state = -1;
    this.X = posX;
    this.Y = posY;
    this.size = size;
  }
  
  
  //Draw the cell, color is set on the table's display function
  public void display()
  {
    rect(X, Y, size, size);
  }
  
}
 //<>//

class InfectedCell extends Cell 
{ 
  int range;
  float infectivity = 0.1;  //How infectous this cell is, higher value will result in faster spread, this value incrises over time and decrases when immune cells are trying to spread their immunity
  
  public InfectedCell(int posX, int posY, int size, int r)
  {
    super(posX, posY, size);  //call the parent constructor
    this.state = 0;
    this.range = r;
  }
  
  //Attempt to spread within the current table
  //Cell can only spread within its range, every cell that is infected starts with minimal infectivity.
  //Cell attempts to spread 1 cell at a time
  public void spread(CellTable t)
  {
    
    float success = 0.04;    //How successfull the spread was, infectivity will change dependng on this number
    int area = ((range + 1) * (range + 1)); //How many cells are within range
    int infect = (int)Math.floor(random(0,area)); //pick the cell index to infect
    
    
    if(infectivity > random(0,1))
    {
      //go through the cells within the table and do the border check for spread
      for(Cell c : t.cells)
      {
      
        //find the cell to infect
        if( ((c.X) == (this.X - range + infect)) && ((c.Y) == (this.Y - range + (((infect % range))-1)))) //I doubt this will work
        {
          InfectedCell newInfected = new InfectedCell(c.X, c.Y, c.size, this.range);  //set the new cell properties
          c = newInfected;
          success += 0.05 + range / t.cells.size();
        }
      }
    }
    
    
    this.infectivity += success;//up the infectivity by the given amount
    
  }
  
}

//TODO: Write the interactions between immune cells andinfected cells (if immune attempts to spread onto infected, infected will be less infectious etc.)

class ImmuneCell extends Cell 
{ 
  int range;
  float potency = 0.1;  //same with infectedCel's infectivity this value does not go down however.
  
  public ImmuneCell(int posX, int posY, int size, int r)
  {
    super(posX, posY, size);  //call the parent constructor
    this.state = 1;
    this.range = r;
  }
  
   //TODO: complete spread of immune cells
  
}