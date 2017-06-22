/*Genetic Algorithm - Square Area*/

//Simple genetic algorithm where finesse is calculated by how close the pops are to the center of the circle

//I'll spread this project into 2 days as the 1st day went into research.

/***********************************/
//What the populations are made up of
class Unit
{
  int posX, posY;
  color strokeColor;
  
  public Unit(int x, int y)
  {
    this.posX = x;
    this.posY = y;
  }
  
  public void setColor(color col)
  {
    this.strokeColor = col;
  }
  
  public void display()
  {
    stroke(strokeColor);
    point(posX, posY);
  }
}
/***********************************/
//Controls Units. Used to manage units within the current and the next generation
class Population
{
   private ArrayList<Unit> pop = new ArrayList<Unit>();
   int popSize;
   
   public Population(int popSize)
   {
     this.popSize = popSize;
   }
   
   public ArrayList<Unit> getPop()
   {
     return pop;
   }
   
   public void displayPop()
   {
     for(Unit u : pop)
     {
       u.display();
     }
   }
}

/*************************************/
/*Area where the Units attempt to fall, further away a unit from the center of this area, less the finesse*/
class Area
{
    int areaX, areaY, areaWidth, areaHeight;
    int areaCenterX, areaCenterY;
    
    
    public Area()
    {
      this.areaX = floor(random(0, width));
      this.areaY = floor(random(0,height));
      this.areaWidth = floor(random(10, width - areaX));
      this.areaHeight = floor(random(10, height - areaY));
      
      areaCenterX = areaX + areaWidth/2;
      areaCenterY = areaY + areaHeight/2;
      
    }
    
     //Draws the rectangle area
    public void drawArea()
    {
      fill(230,230,255);
      rect(areaX, areaY, areaWidth, areaHeight);
    }
    
}

//Main controller of the genetic algorithm (Evaluation, Selection, Crossover and Mutation)
class GeneticAlgorithm 
{
  

  Population current, next;
  
  public GeneticAlgorithm(int popSize)
  {
    this.current = new Population(popSize);
    this.next = new Population(popSize);
  }
  

  
}