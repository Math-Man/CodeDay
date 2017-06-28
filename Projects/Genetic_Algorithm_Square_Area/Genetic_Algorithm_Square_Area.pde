/*Genetic Algorithm - Square Area*/

//Simple genetic algorithm where finesse is calculated by how close the pops are to the center of the circle

//I'll spread this project into 2 days as the 1st day went into research.

Area a;
GeneticAlgorithm g;
Unit u;
void settings()
{
  size(600,600);
  //Set the area
  a = new Area(50,50,100,255);
  g = new GeneticAlgorithm(70, 0.05, 0.05, 4, a);
  u = g.crossOver(g.current.pop.get(0), g.current.pop.get(1));
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
  println(c + "--------------------------------------------------------------------------------");
  delay(260);
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
      println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! " + areaCenterX + " " + areaCenterY);
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
  Population current;
  int popSize, selectionRange;
  Area area;
  
  public GeneticAlgorithm(int popSize, float mRate, float mStrength, int selectionRange, Area a)
  {
    if(popSize < 2){popSize = 2;}
    if(mRate > 1 || mRate < 0) {mRate = 0.05;}
    if(mStrength > 1 || mStrength < 0) {mStrength = 0.05;}
    if(selectionRange < 2){selectionRange = 2;}
    this.current = new Population(popSize);//at the beginning current population is random and next gen is empty
    this.mutationRate = mRate;
    this.mutationStrength = mStrength;
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
       println("Setting unit: " + i);
       //Select 2 Units
       Unit parent1, parent2, child;
      
       parent1 = tournySelection();
       parent2 = tournySelection();
       println("\nParents: " + parent1.posX +" "+ parent2.posX);
       //Crossover Between 2 Units
       child = crossOver(parent1, parent2);
       println("child: " + child.posX);
       //Mutate the new Unit
       child = mutate(child);
       println("Mutated Child: " + child.posX);
       //Save the unit
       child.setColor(floor(random(parent1.strokeR, parent2.strokeR)), floor(random(parent1.strokeG, parent2.strokeG)), floor(random(parent1.strokeB, parent2.strokeB)));
       next.pop.add(child);
       println("Added! " + i);
       
    }
    
    //Display this generation and replace the current generation!!!
    current = next;
    //this.current = this.next;
    for(Unit children: next.pop)
    {
      println("Child: " + children.posX);
    }
   
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
  
  
  //In this case crossover gets a random coordinate value between 2 crossed over units
  public Unit crossOver(Unit parent1, Unit parent2)
  {
    Unit child;
    int newX = floor(random(min(parent1.posX,parent2.posX), max(parent2.posX,parent1.posX)));
    int newY = floor(random(min(parent1.posY,parent2.posY), max(parent2.posY,parent1.posY)));
    
    child = new Unit(newX, newY);
    return child;
    
  }
  

  //Calculate the fitness of the unit(How far away the unit is from the area and map it to something between 0 and 100)
  public float getFitness(Unit u)
  {
    //Get distance between point and area's center
    float distance = sqrt( pow((u.posX - area.areaX),2) + pow((u.posY - area.areaY),2)  );
    float fitness = map(distance, 0, width * height, 0, 100);
    
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
    return getFittest(tourny);
    
  }


}