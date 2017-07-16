class CellTable
{
  
    ArrayList<Cell> cells = new ArrayList<Cell>();  //all cells contained within this table
  
    int tableStartX, tableStartY;
    
    int Width, Height; // Width and height of the table
    color healthy, infected, immune; 
    
    int startInfectedCells = 10;
    int cellSize;
    int infectionRange = 3;
    
    //Create a new empty cellTable with given dimensions in cells and cell size in pixels
    public CellTable(int startX, int startY, int Width, int Height, int cellSize)
    {
      for(int y = startY; y < Height; y += cellSize)
      {
        for(int x = startX; x < Width ; x += cellSize)
        {
          Cell c = new Cell(x, y, cellSize);
          cells.add(c);
        }
      }
    }
    
    //Infect the cell at given location
    public void Infect(int x, int y)
    {
      
      Cell toInfect = null;
      int i = -1;  //program will implode if there is an error 
      
      //Find the cell we are atempting to change
      for(Cell c : cells)
      {
        if(c.X == x && c.Y == y)
        {
          toInfect = c;
          i = cells.indexOf(c);
        }
      }
      
      //remove the cell and add it as an infectedCell
      cells.remove(i);
      cells.add(new InfectedCell(toInfect.X, toInfect.Y, toInfect.size, infectionRange));
      
      
    }
    
    //heal the cell at given location
    public void heal(int x, int y)
    {
      
    }
    
    //Give/take away immunity of a cell at given location
    public void immune(int x, int y)
    {
      
    }
    
    
    //Update the current table, process spreads etc.
    public void updateTable()
    {
      for(Cell c: cells)
      {
        //if the cell is infected
        if(c instanceof InfectedCell)
        {
          
        }
        //if the cell is immune
        else if(c instanceof ImmuneCell)
        {
          
        }
        //if the cell is healthy
        else 
        {
          
        }
      }
    }
    
    //attempt to display all cells within this cellTable
    public void DisplayTable()
    {
      //G through all cells, change color depending on cell's state
      for(Cell c : cells)
      {
        if(c.state == -1){stroke(healthy); fill(healthy);}
        else if(c.state == 0){stroke(infected); fill(infected);}
        else{stroke(immune); fill(immune);}
        
        c.display();
      }
      
    }
    
    
    
    

}
/*for(int y = 0; y < Height; y++)
      {
        for(int x = 0 ; x < Width; x++)
        {
          for(Cell c : cells)
          {
            if(c.X == x && c.Y == y)
            {
              
            }
          }
        }
      }*/