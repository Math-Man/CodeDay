

class InfectedCell extends Cell 
{ 
  int range;
  float infectivity;  //How infectous this cell is, higher value will result in faster spread, this value goes up over time and decrases when immune cells are trying to spread/cure
  float supportEfficency;
  float infectivityTickPercent;  //ups the infectivity by a percantage value of the infectivity
  int maxInfectionsPerTurn = 2;
  float maxInfectivity = 0.8;
  float maxBolsters = 1;
  int maxAttacks = 3;
  float damageImmuneCells = 0.005;  //amount of FLAT damage done to immune cells, value changed by the ratio of current infectivity to max infectivity, has to go through resistance check, immuneCells cannot be turned back into healthy cells
  
  public InfectedCell(int iX, int iY, int posX, int posY, int size, int r)
  {
    super(iX, iY, posX, posY, size);  //call the parent constructor
    this.state = -1;
    this.range = r;
    this.infectivity = 0.01;
    this.supportEfficency = 0.01;
    this.infectivityTickPercent = 0.01; // percantage value
  }
  
  
  //This version of spread works but it can be more spohisticated, its pretty lame atm
  public void spread(CellTable t)
  {
    
 
    //println("Starting to infect : " + this);
    int infections = 0;
    int bolsters = 0;
    int attacks = 0;
    
    //Go through cells on the table
    for(Cell c : t.cells)
    {
      //make sure to ignore self and impass
      if(!c.equals(this) || c.impass)
      {
        
        //check if cap is reached, if so stop the loop
        if(infections >= maxInfectionsPerTurn )
        {
          break;
        }
        
        //Support the nearby infected cells if they are weaker than this cell 
        if((c.iX > this.iX - range) && (c.iX < this.iX + range) && (c.iY > this.iY - range) && (c.iY < this.iY + range) && c instanceof InfectedCell && ((InfectedCell)c).infectivity < this.infectivity && (maxBolsters >= bolsters))
        {
           ((InfectedCell)c).infectivity += this.infectivity * supportEfficency;
          
           if(t.enableLines) {  stroke(255,120,120,40); line(this.X + size/2, this.Y+ size/2, c.X+ size/2, c.Y+ size/2); }
           maxBolsters++;
        }
        
        //check if the cell is in range, uses index values and the random infection chance passes
        if((c.iX > this.iX - range) && (c.iX < this.iX + range) && (c.iY > this.iY - range) && (c.iY < this.iY + range) && (infectivity > random(0,1)) && !(c instanceof InfectedCell) && !(c instanceof ImmuneCell) && (infectivity - infectivity * c.resistance/2 > random(0,1)) && !c.impass)
        {
          
          //Infect the current cell
          t.cells.set(t.getIndex(c.iX, c.iY), new InfectedCell(c.iX, c.iY, c.X, c.Y, c.size, this.range));  
          infections++;
        }
        
        //Attempt to damage a nearby immune cell
        if((c.iX > this.iX - range) && (c.iX < this.iX + range) && (c.iY > this.iY - range) && (c.iY < this.iY + range) && (c instanceof ImmuneCell) && (c.resistance > random(0,1)) && attacks >= maxAttacks)
        {
          
          if(t.enableLines) {stroke(t.infected,160); line(this.X + size/2, this.Y+ size/2, c.X+ size/2, c.Y+ size/2);}
          ((ImmuneCell)c).potency -= damageImmuneCells * (1/(maxInfectivity - infectivity));
          if(((ImmuneCell)c).potency < 0.01) {((ImmuneCell)c).potency = 0.01;}
          attacks++;
        }
        
        
        
      }
    } 
    
   
    this.infectivity += (this.infectivity * infectivityTickPercent);
    if(infectivity > maxInfectivity) {infectivity = maxInfectivity;}
    
    String tInf = round( infectivity * 100.0f ) / 100.0f + "";  //hacky af
    text = "" + tInf;

    
    
  } 
}