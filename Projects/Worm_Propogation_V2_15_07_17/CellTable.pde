class CellTable
{
  
    ArrayList<Cell> cells = new ArrayList<Cell>();  //all cells contained within this table
  
    int tableStartX, tableStartY;
    
    int Width, Height; // Width and height of the table
    color healthy, infected, immune; 
    
    int startInfectedCells = 10;
    int cellSize;
    int infectionRange = 3;
    int immuneRange = 2;
    
    //Create a new empty cellTable with given dimensions in cells and cell size in pixels
    public CellTable(int startX, int startY, int Width, int Height, int cellSize)
    {
      
      this.cellSize = cellSize;
      this.Width = Width;
      this.Height = Height;
      this.tableStartX = startX;
      this.tableStartY = startY;
      
      //Create the empty cell table
      for(int y = startY; y < Height; y += cellSize)
      {
        for(int x = startX; x < Width ; x += cellSize)
        {
          Cell c = new Cell(x, y, cellSize);
          cells.add(c);
        }
      }
      
    }
    
    //Get a cell at the given coordinates.
    public Cell getCellAt(int x, int y)
    {
      for(Cell c : cells)
      {
        if(c.X == x && c.Y == y)
        {
          return c;
        }
      }
      
      return null;
      
    }
    
    /*
    *    TODO: fix the following methods with getcellat method. (Similar to immune)
    */
    

    //Infect the cell at given location
    public void Infect(int x, int y)
    {
      //program will implode if there is an error 
      Cell toInfect = null;
      int i = -1;    
      
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
      Cell toHeal = null;
      int i = -1;
      
      
      //Find the cell we are atempting to change
      for(Cell c : cells)
      {
        if(c.X == x && c.Y == y)
        {
          toHeal = c;
          i = cells.indexOf(c);
        }
      }
      
      //remove the cell and add it as an infectedCell
      cells.remove(i);
      cells.add(new Cell(toHeal.X, toHeal.Y, toHeal.size));
    }
    
    
    
    //Give/take away immunity of a cell at given location
    public void immune(int x, int y)
    {
      Cell toImmune = null;
      int i = -1;
      
      toImmune = getCellAt(x,y);
      i = cells.indexOf(toImmune);
      
      cells.remove(i);
      cells.add(new ImmuneCell(toImmune.X, toImmune.Y, toImmune.size, immuneRange));
      
    }
    
    
    //Update the current table, process spreads etc.
    public void updateTable()
    {
      for(Cell c: cells)
      {
        //if the cell is infected
        if(c instanceof InfectedCell)
        {
          //TODO: Fix the spread part and complete rest of the function
          //Downcasting like a b0ss
          ((InfectedCell)c).spread(this);
          
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
      //Go through all cells, change color depending on cell's state
      for(Cell c : cells)
      {
        if(c.state == -1){stroke(healthy); fill(healthy);}
        else if(c.state == 0){stroke(infected); fill(infected);}
        else{stroke(immune); fill(immune);}
        
        c.display();
      }
      
    }

    
    
    

}