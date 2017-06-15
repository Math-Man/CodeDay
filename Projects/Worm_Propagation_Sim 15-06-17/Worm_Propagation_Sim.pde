/*
* This is part of a project where I attempt to code something intresting everyday.
*
* Worm propagation Model Idea from: https://www.reddit.com/r/dailyprogrammer/comments/6h9woe/20160614_challenge_319_intermediate_worm_wars_1/
*/



PropagationModel model;
void settings()
{

  //EDIT THESE PARAMETERS TO CHANGE THE BEHAVIOR
  //((POPULATION SIZE), (INFECTED CELLS AT START), (INFECTION RATE), (INFECTED TO IMMUNE HEAL RATE), (NORMAL TO IMMUNE RATE),(CELL SIZE), (TICK DELAY))
  model = new PropagationModel(10000, 10, 0.01, 0.005, 0.0015, 6, 25);

}

void draw()
{
  background(255);
  model.update();
}


//Manages cells & simulates the system
class PropagationModel
{
  int popSize;
  int infectedCells;
  float transmissionRate;
  float healRate;
  float immunityRate;
  ArrayList<Cell> population = new ArrayList<Cell>();
  int sideLength;  //Side Length of a cell
  int cWH;
  int delay;

  
  public PropagationModel(int p, int i, float tr, float hr, float imr, int blockSize, int del)
  {  
     delay = del;
     popSize = p;
     infectedCells = i;
     transmissionRate = tr;
     healRate = hr;
     immunityRate = imr;
     sideLength = blockSize;  if(sideLength < 1){sideLength = 2;} 
     cWH = sideLength * floor( sqrt(popSize) );
     size(cWH,cWH);
     setTables();    
  }
  
  //fills the cell arraylist with randomly assigned infected cells and normal cells
  private void setTables()
  {
       int infectedCounter = infectedCells;
     while(infectedCounter != 0)
     {
       for(int y = 0; y < height; y += sideLength)
       {
         for(int x = 0; x < width; x += sideLength)
         {
           if(random(0,1) > 0.2 && infectedCounter > 0)
           {
              Cell c = new Cell(this, x, y, true);  
              population.add(c);
              infectedCounter--;
           }
           else
           {
             Cell c = new Cell(this, x, y, false); 
             population.add(c);
           }
         }
       }
     }
  }
  
  //draws and updates cells
  public void update()
  {
    delay(delay);
    
    for(Cell c : population)
    {
      
      if(c.infected) //If the cell is infected
      {
        if(random(0,100) < healRate * 100) //if ok, heal the infected cell and make it resistant
        {
          c.infected = false;
          c.immune = true;
        }
      }
      else if(!c.infected && !c.immune)// if the cell is not infected and is not immune
      {
        if(random(0,100) < transmissionRate * 100 * ((infectedCells * 0.0001)+ 1))
        {
          c.infected = true;
          infectedCells++;
        }
        else if(random(0,100) < immunityRate * 100)
        {
          c.immune = true;
        }
      }
      c.drawCell();
    }
  }
}