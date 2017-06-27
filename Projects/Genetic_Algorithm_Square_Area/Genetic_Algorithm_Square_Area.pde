/*Genetic Algorithm - Square Area*/

//Simple genetic algorithm where finesse is calculated by how close the pops are to the center of the circle

//I'll spread this project into 2 days as the 1st day went into research.

/***********************************/
//What the populations are made up of
//Position of a unit is the gene of a unit, Color is also carried over the generations.
class Unit
{
  int posX, posY;
  color strokeR,strokeG,strokeB;
  
  public Unit(int x, int y)
  {
    this.posX = x;
    this.posY = y;
  }
  
  public void setColor(int r, int g, int b)
  {
    this.strokeR = r;
    this.strokeG = g;
    this.strokeB = b;
  }
  
  public void display()
  {
    stroke(strokeR, strokeG, strokeB);
    point(posX, posY);
  }
}
/***********************************/
//Controls Units. Used to manage units within the current and the next generation
class Population
{
   private ArrayList<Unit> pop = new ArrayList<Unit>();
   public int popSize;
   
   //Create a random set of units upon constructor call
   public Population(int popSize)
   {
     this.popSize = popSize;
     for(int i = 0 ; i < popSize ; i++) 
     {
         Unit u = new Unit(floor(random(1,width)), floor(random(1,width)));
         u.setColor(floor(random(1,255)), floor(random(1,255)), floor(random(1,255)));
     }
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
/*Area where the Units attempt to fall, further away a unit from the center of this area, less the finess"*/
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


class FitnessCalc
{
  //Calculate the fitness of the unit(How far away the unit is from the area and map it to something between 0 and 100)
  public int getFitness(Unit u, Area a)
  {
    //Get distance between point and area's center
    float distance = sqrt( pow((u.posX - a.areaX),2) + pow((u.posY - a.areaY),2)  );
    float fitness = map(distance, 0, width*height, 0, 100);
    
    return 1;
  }
}


//Main controller of the genetic algorithm (Evaluation, Selection, Crossover and Mutation)
class GeneticAlgorithm 
{
  float mutationRate;
  Population current, next;
  
  public GeneticAlgorithm(int popSize)
  {
    this.current = new Population(popSize);
    this.next = new Population(popSize);
  }
  

  
}