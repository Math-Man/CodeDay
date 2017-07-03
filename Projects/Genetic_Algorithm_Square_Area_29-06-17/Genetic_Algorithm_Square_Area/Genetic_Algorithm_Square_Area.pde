/*Genetic Algorithm - Square Area*/

//Simple genetic algorithm where finesse is calculated by how close the pops are to the center of the circle

//This "program" took way longer than it should have becouse of the hiatus and its way more messy than it should have been but still.
//This thing still has way too many flaws but its still a working concept.


/*Parameters*/

int popSize = 100;                //Number of individual units in the population
int sampleSize = 5;               //Sample size when selecting parents
float selectionBias = 0.85;       //How likely it is for fittest unit within a sample to be selected
float naturalDrag = 0.2;          //Strength of natural movement. (similar to mutation but weaker)
float mutationRate = 0.08;        //Chance of getting x and y position replaced with a new random number.
float mutationStrength = 0.15;     //How strong the mutation is





Area a;
GeneticAlgorithm g;
void settings()
{
  size(600,600);
  
  //Set the area
  a = new Area();
  g = new GeneticAlgorithm(popSize, selectionBias, naturalDrag, mutationRate, mutationStrength, sampleSize, a); 
}

int c = 0;
void draw()
{
  println("Generation : " + c);
  background(120);
  a.drawArea();  //Draw current Area
  g.current.displayPop();
  //println("p1: " + g.current.pop.get(0).posX + " " + g.current.pop.get(0).posY + "\np2: " +g.current.pop.get(1).posX +" "+ g.current.pop.get(1).posY+ "\nnew: " + u.posX + " " + u.posY);
  g.nextGeneration();
  delay(1000);
  c++;
  

}



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
    fill(strokeR, strokeG, strokeB);
    stroke(strokeR, strokeG, strokeB);
    ellipse(posX, posY,2,2);
  }
}
/***********************************/
//Controls Units. Used to manage units within the current and the next generation
class Population
{
   public ArrayList<Unit> pop = new ArrayList<Unit>();
   public int popSize;
   
   //Create a random set of units upon constructor call
   public Population(int popSize)
   {
     this.popSize = popSize;
     for(int i = 0 ; i < popSize ; i++) 
     {
         Unit u = new Unit(floor(random(1,width)), floor(random(1,width)));
         u.setColor(floor(random(1,255)), floor(random(1,255)), floor(random(1,255)));
         pop.add(u);
     }
   }
   
   //Create an empty pop
   public Population()
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
    
    public Area(int x, int y, int w, int h)
    {
      this.areaX = x;
      this.areaY = y;
      this.areaWidth = w;
      this.areaHeight = h;
      
      areaCenterX = areaX + areaWidth/2;
      areaCenterY = areaY + areaHeight/2;
     
    }
    
     //Draws the rectangle area
    public void drawArea()
    {
      fill(230,230,255,10);
      rect(areaX, areaY, areaWidth, areaHeight);
    }
    
}



//Main controller of the genetic algorithm (Evaluation, Selection, Crossover and Mutation)
class GeneticAlgorithm 
{
  float mutationRate, mutationStrength;  //number between 0 and 1
  float naturalDrag; // number between 0 and 1 (Strength of random natural drag)
  float bias; // How likely it is for fittest to be chosen (between 0 and 1)
  Population current;
  int popSize, selectionRange;  //Selection range decides the amount of units that will be grouped in tourney selection
  Area area;
  
  public GeneticAlgorithm(int popSize, float bias, float naturalDrag, float mRate, float mStrength, int selectionRange, Area a)
  {
    if(popSize < 2){popSize = 2;}
    if(mRate > 1 || mRate < 0) {mRate = 0.05;}
    if(mStrength > 1 || mStrength < 0) {mStrength = 0.05;}
    if(selectionRange < 2){selectionRange = 2;}
    this.current = new Population(popSize);//at the beginning current population is random and next gen is empty
    this.mutationRate = mRate;
    this.mutationStrength = mStrength;
    this.bias = bias;
    this.naturalDrag = naturalDrag;
    this.popSize = popSize;
    this.selectionRange = selectionRange;
    this.area = a;
  }
  
  //Picks from the parents pool depending on their fitness and generates a new population,
  //Unit selection is done by selecting x number of random units and picking the fittest of them all
  public void nextGeneration()
  {

    Population next = new Population();
    
    for(int i = 0; i < popSize; i++)
    {
       //Select 2 Units
       Unit parent1, parent2, child;
      
       parent1 = tournySelection();
       parent2 = tournySelection();
       //println("\nParents: " + parent1.posX +" "+ parent2.posX);
       //Crossover Between 2 Units
       child = crossOver(parent1, parent2);
       //println("child: " + child.posX);
       //Mutate the new Unit
       child = mutate(child);
       //println("Mutated Child: " + child.posX);
       //Save the unit
       child.setColor(floor(random(parent1.strokeR, parent2.strokeR)), floor(random(parent1.strokeG, parent2.strokeG)), floor(random(parent1.strokeB, parent2.strokeB)));
       next.pop.add(child);
       //println("Added! " + i);
       
    }
    
    //Display this generation and replace the current generation!!!
    current = next;

   
  }
  
  
  //Mutation effects the position of the unit, mutation chance is given by mutationRate properity, higher mutationStrength results in more wild mutations(position changes)
  public Unit mutate(Unit u)
  {
    if(random(0,1) < mutationRate)
    {
      u.posX += (random(-1,1)) * mutationStrength * width;
      u.posY += (random(-1,1)) * mutationStrength * height;
    }
    
    return u;
  }
  
  //Random drag that always occurs at varying magnitude and direction, adds a more "natural" feeling to movement. Strength is decided with naturalDrag property
  //Strength of drag is decided on the pop size, higher pop size means less space to move
  public Unit drag(Unit u)
  {
    u.posX = u.posX + floor(((random(-1,1)) * naturalDrag * random(0, 3.33 * width / popSize)));
    u.posY = u.posX + floor(((random(-1,1)) * naturalDrag * random(0, 3.33 * height / popSize)));
      
    return u;
  }
  
  //In this case crossover gets a random coordinate value between 2 crossed over units
  public Unit crossOver(Unit parent1, Unit parent2)
  {
    Unit child;
    int newX = floor(random( (min(parent1.posX,parent2.posX)), ( max(parent2.posX,parent1.posX))));
    int newY = floor(random( (min(parent1.posY,parent2.posY)), ( max(parent2.posY,parent1.posY))));
    child = new Unit(newX, newY);
    return child;
    
  }
  

  //Calculate the fitness of the unit(How far away the unit is from the area and map it to something between 0 and 100)
  public float getFitness(Unit u)
  {
    //Get distance between point and area's center
    float distance = sqrt( pow((u.posX - area.areaCenterX),2) + pow((u.posY - area.areaCenterY),2)  );
    float fitness = map(-distance, 0, width * height, 0, 100);
    
    return fitness;
  }
  
  //Gets the fittest unit in a group
  public Unit getFittest(Unit[] units)
  {
    Unit fittest = null;
    float fittestValue = -1;
    
    for(Unit u : units)
    {
      if(getFitness(u) > fittestValue )
      {
        fittest = u;
        fittestValue = getFitness(u);
      }
    }
    
    return fittest;
  }
  
  
  public Unit tournySelection()
  {
    Unit[] tourny = new Unit[selectionRange];
    for(int j = 0; j < selectionRange; j++)
    {
      tourny[j] = current.pop.get( floor( random(0, popSize) ) );//Get a random unit from current pop
    }
    //If the bias check passes, return the fittest, otherwise return a random unit
    if(random(0,1) < bias)
    {
      return getFittest(tourny);
    }
    else
    {
      return tourny[floor( random(0, selectionRange) )];
    }
    
  }


}