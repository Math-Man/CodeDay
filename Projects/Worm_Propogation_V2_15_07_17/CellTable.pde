class CellTable
{
  

  
    ArrayList<Cell> cells = new ArrayList<Cell>();  //all cells contained within this table
  
    int tableStartX, tableStartY;
    
    int Width, Height; // Width and height of the table
    int hR,hG,hB, iR,iG,iB, imR,imG,imB; ///base Values for cell types
    color infected, immune, healthy;
    
    int startInfectedCells = 10;
    int cellSize;
    int infectionRange = 2;
    int immuneRange = 2;
    float baseResistance = 0.8;
    
    boolean enableLines = true;
    
    //Create a new empty cellTable with given dimensions in cells and cell size in pixels
    public CellTable(int startX, int startY, int Width, int Height, int cellSize)
    {
      
      this.cellSize = cellSize;
      this.Width = Width;
      this.Height = Height;
      this.tableStartX = startX;
      this.tableStartY = startY;
      
      
      int xo = 0, yo = 0;
      
      //Create the empty cell table
      for(int y = startY; y < Height * cellSize; y += cellSize)
      {
        xo = 0;
        for(int x = startX; x < Width * cellSize ; x += cellSize)
        {
          Cell c = new Cell(xo, yo, x, y, cellSize, baseResistance);
          c.col = healthy;
          cells.add(c);
          xo++;
        }
        yo++;
      }
      
    }
    
    //Set the color bases, takes the color base for the healthy cells and derives differing colors from it
    public void setColorSet(int r, int g, int b)
    {
      
      hR = r; hG = g; hB = b;
    
      iR = ((255 + ((- g - b) % 255)) + r % 255)% 255; 
      iG = ((255 + ((- r - b) % 255)) + g % 255)% 255; 
      iB = ((255 + ((- r - g) % 255)) + b % 255)% 255; 
    
      imR = ((255 + ((- iG - iB) % 255)) + iR % 255)% 255; 
      imG = ((255 + ((- iR - iB) % 255)) + iG % 255)% 255; 
      imB = ((255 + ((- iR - iG) % 255)) + iB % 255)% 255; 
      
      this.healthy = color(hR,hG,hB);
      this.infected = color(iR,iG,iB);
      this.immune =  color(imR,imG,imB);
      
    }
    
    
    //Get a cell at the given coordinates.
    public Cell getCellAt(int x, int y)
    {
      for(Cell c : cells)
      {
        if(c.iX == x && c.iY == y)
        {          
          return c;
        }
      }
      
      return null;
      
    }
    
    
    //gets the cell by the position on the canvas
    public Cell getCellOn(int x, int y)
    {
      for(Cell c : cells)
      {  //println(cells.indexOf(c));
        if(c.X <= x && c.X + c.size > x && c.Y <= y && c.Y + c.size > y)//If the position is inside the cell
        {
          //println(cells.indexOf(c) + "!");
          return c;
        }
      }
      return null;
    }
    
    
    //returns the index of a cell within the list
    public int getIndex(int x, int y)
    {
      for(Cell c : cells)
      {  
        if(c.iX ==  x && c.iY == y)
        {
          return cells.indexOf(c);
        }
      }
      return -1;
    }
    
    
    public int getCellIndex(Cell ic)
    {
      for(Cell c : cells)
      {
        //println(c + " " + ic );
        
        if(c.equals(ic))
        {
          println("found");
          return (cells.indexOf(ic));
        }
      }
      
      return -1;
      
    }
    

    //Infect the cell at given location
    public void Infect(int x, int y)
    {

      Cell toInfect = getCellOn(x,y);
      //println(toInfect.iX + " " + toInfect.iY);
      int index = getCellIndex(toInfect);
      cells.set(index, new InfectedCell(toInfect.iX, toInfect.iY, toInfect.X, toInfect.Y, toInfect.size, infectionRange, toInfect.resistance));
      
    }
    
    
    
    //heal the cell at given location
    public void heal(int x, int y)
    {
      Cell toHeal = getCellOn(x, y);
      int index = getCellIndex(toHeal);
      cells.set(index, new Cell(toHeal.iX, toHeal.iY, toHeal.X, toHeal.Y, toHeal.size, toHeal.resistance));
    }
    
    //Heal a cell at given index coordinates
    public void healAt(int x, int y)
    {
      Cell toHeal = getCellAt(x, y);
      int index = getCellIndex(toHeal);
      cells.set(index, new Cell(toHeal.iX, toHeal.iY, toHeal.X, toHeal.Y, toHeal.size, toHeal.resistance));
    }
    
    //Give/take away immunity of a cell at given location
    public void immune(int x, int y)
    {

      Cell toImmune = getCellOn(x,y);
      int index = getCellIndex(toImmune);

      cells.set(index, new ImmuneCell(toImmune.iX, toImmune.iY, toImmune.X, toImmune.Y, toImmune.size, immuneRange, toImmune.resistance));

    }
    
    
    //Update the current table, process spreads etc.
    public void updateTable()
    {
      for(Cell c: cells)
      {  
        //fix resistance values of cells
        if(c.resistance < 0) {c.resistance = 0;}
        else if(c.resistance > 1){c.resistance = 1;}
        
        
        if(!c.impass)
        {
          //if the cell is infected
          if(c instanceof InfectedCell)
          {        
          
          //change cell states depending on health
          if( ((InfectedCell)c).infectivity <= 0)
          {
             this.healAt( ((InfectedCell)c).iX,  ((InfectedCell)c).iY);
          }
         
            //Downcasting like a b0ss
            ((InfectedCell)c).spread(this);
          
          }
          //if the cell is immune
          else if(c instanceof ImmuneCell)
          {
            ((ImmuneCell)c).spread(this);
          }
          //if the cell is healthy
          else 
          {
          
          }
        }        
      }
    }

    //attempt to display all cells within this cellTable
    public void DisplayTable()
    {
      
       for(Cell c: cells)
       { 
         if(c.state == 0)
         {
             c.col = healthy;    
         }
         else if(c.state < 0)
         {
             c.col = infected;
         }
         else if(c.state > 0)
         {
           c.col = immune;
         }
         
         if(c.impass)
         {
            c.col = color(0,0,0);
         }
         c.display();
       
       }
    }
}