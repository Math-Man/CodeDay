class Maze
{
  
  /*Weighing parameters*/
  float downW = 0.3;
  float upW = 0.1;
  float leftW = 0.2;
  float rightW = 0.2;
  int colo = 5;
  
  
  public ArrayList<Tile> tiles = new ArrayList<Tile>();
  int blockCount;
  int wid, hei;
  int blockSize;
  
  public Maze(int wid, int hei, int blockSize)
  {
    this.wid = wid;
    this.hei = hei;
    this.blockSize = blockSize;
  }
  
 
  public void genMaze()
  {
    
    Tile lastSolutionTile = null;
    
    for(int y = 0; y < hei * blockSize ; y += blockSize)
    {
      for(int x = 0; x < wid * blockSize; x += blockSize)
      {

        //Get random enum
        Direction d;
        switch(floor(random(0,4)))
        {
          case 0:
            d = Direction.NORTH;
          break;
          
          case 1:
            d = Direction.SOUTH;
          break;
          
          case 2:
            d = Direction.WEST;
          break;
          
          case 3:
            d = Direction.EAST;
          break;
          
          default:
            d = null;
          break;
        }
        
        Tile t = new Tile(x, y, blockSize, d);
        
        
        tiles.add(t);
        //println("TileAdded: " + t + " " + t.dir + " " + t.posX + " " + t.posY);
      }
    }
  }
  
  
  void displayAll()
  {
    for(Tile t : tiles)
    {
      
      
      t.G = 120;
      t.B = 80;
      t.tex = t.dir.toString().toCharArray()[0];
      t.display();
    }
  }
  
  
  
  void createSolution() 
  {
    
    Tile exit = null;
    Tile currentTile = null;
    ArrayList<Tile> solutionTiles = new ArrayList<Tile>();
    
    //Select Exit tile 
    if(exit == null)
    {
      
      ArrayList<Tile> firstTiles = new ArrayList<Tile>();
      
      println("Setting starting Tile!");
      for(Tile t : tiles)
      {
        if(t.posY == 0)
        {
          firstTiles.add(t);
        }
      }
      
      
      exit = firstTiles.get(floor(random(0, firstTiles.size())));
      exit.R = 255;
      exit.dir = Direction.PENT;
      solutionTiles.add(exit);
      currentTile = exit;

    }
    while(currentTile.posY < 380) {
    //If the exit cell is selected
    if(exit != null) 
    {
      
       ArrayList<Tile> Actualneighbours = new ArrayList<Tile>();
      
      //Go through the neighbours of the current Tile
      for(Tile t : getNeighbours(currentTile))
      {
        //Make sure the selected neighbour tile was not selected before! also make sure not select itself for some reason
        for(Tile s : solutionTiles)
        {
          //If the tile was not picked before add it to true Neighbours also make sure the current and random's symbols are not opposite
          if((!t.equals(s) || t.equals(currentTile)) )
          {
            if( !((currentTile.dir.equals(Direction.NORTH) && t.tag.equals(Direction.SOUTH) ) ||  ((currentTile.dir.equals(Direction.SOUTH) && t.tag.equals(Direction.NORTH))) || (currentTile.dir.equals(Direction.EAST) && t.tag.equals(Direction.WEST)) || ((currentTile.dir.equals(Direction.WEST) && t.tag.equals(Direction.EAST)))))
            {
              //Prevent it from going south (literally )
              if(t.tag.equals(Direction.NORTH) || t.tag.equals(Direction.WEST) || t.tag.equals(Direction.EAST))
              {
                 Actualneighbours.add(t);
              }
                 
             
              
            }
          }
        }
      }
      
      //Select a tile from true neighbours
      
      Tile  selectedTile = Actualneighbours.get(floor(random(0, Actualneighbours.size())));
      boolean selected = false;
      
      //weigh going south more than going anywhere else
      int t1 = floor(random(0, Actualneighbours.size()));
      selectedTile = Actualneighbours.get(t1);
      
      selectedTile.dir = Actualneighbours.get(t1).tag;
      
      //Indicate
      selectedTile.R = 255;
      
      
      //add the selected tile to the list
      solutionTiles.add(selectedTile);
      
      //change the currentTile with the selected Tile
      currentTile = selectedTile;
      println(currentTile + " " + currentTile.posY + " " + currentTile.posX);
    }
    }
    currentTile.R = 255;
    
    
    
  }
  
  
  private ArrayList<Tile> getNeighbours(Tile t)
  {
    ArrayList<Tile> nTiles = new ArrayList<Tile>();
    
    for(Tile d : this.tiles)
    {
      if(nTiles.size()  == 4) {return nTiles;}
      
      //Left of the Tile
      if( (d.posX < (t.posX - wid/2)) && (d.posX + wid) > (t.posX - wid/2) && (d.posY == t.posY) )
      {
        d.tag = Direction.EAST;
        nTiles.add(d);
      }
      //right
      else if((d.posX  < (t.posX + wid + wid/2)) && (d.posX + wid) > (t.posX + wid + wid/2) && (d.posY == t.posY))
      {
        d.tag = Direction.WEST;
        nTiles.add(d); 
      }
      //below
      else if((d.posY < (t.posY + hei + hei/2)) && (d.posY + hei) > (t.posY + hei + hei/2) && (d.posX == t.posX))
      {
        d.tag = Direction.NORTH;
        nTiles.add(d);
      }
      //above
      else if((d.posY < (t.posY - hei/2)) && (d.posY + hei) > (t.posY - hei/2) && (d.posX == t.posX))
      {
        d.tag = Direction.SOUTH;
        nTiles.add(d);
      }
    }
    
    return nTiles;
  }
  
  
  
  
}