class ImmuneCell extends Cell 
{ 
  int range;
  float potency;  //same with infectedCel's infectivity this value does not go down however.
  float supportEfficency = 0.001;
  float potencyTick = 0.01;
  float maxPotency = 0.5;
  int maxBolsters = 2;
  int maxCuresPerTurn = 2;
  float infectedCureModifier = 0.2;  //percanrtage value of potency that damages the infecte cell, higher number means stronger attacks against infected cell
  
  //Decay causes older immune cells to turn back into normal cells with higher resistance
  boolean decay = true;
  float decayModifier = 0.01;  //percantage value reduced from potency
  float decayTime = 80;
  float flatDecay = 0.006;  //flat decay amount
  float resistanceBuff = 0.8;  //up resistance by a flat amount
  
    
  public ImmuneCell(int iX, int iY, int posX, int posY, int size, int r, float res)
  {
    super(iX, iY, posX, posY, size, res);  //call the parent constructor
    this.state = 1;
    this.range = r;
    this.potency = 0.1;
  }
  
  int turn = 0;
  //attempts to spread to everything in its range at once
   public void spread(CellTable t)
   {
     
        int cures = 0;
        int bolsters = 0;
        turn++;
        println(turn);

                
          //Manage self Decay
          if(this.decay)
          {
            decayTime--;
            
            //If cell lived long enough
            if(decayTime <= 0)
            {
              decayTime = 0;
              
              //decay the cell by the modifier amount and a very small flat value
              this.potency -= this.potency * decayModifier;
              this.potency -= flatDecay;
              
              //check if the potency is below or equal to 0
              if(this.potency <= 0)
              {
                t.cells.set(t.getIndex(this.iX, this.iY), new Cell(this.iX, this.iY, this.X, this.Y, this.size, this.resistance));
                this.resistance += resistanceBuff;
              }
              
            }
          }


      //Go through cells on the table
      for(Cell c : t.cells)
      {
        //make sure to ignore self and impass
        if(!c.equals(this) || c.impass)
        {
    
          
          //Support the nearby immune cells if they are weaker than this cell, can't bolster if the immune cell is decaying
          if((c.iX > this.iX - range) && (c.iX < this.iX + range) && (c.iY > this.iY - range) && (c.iY < this.iY + range) && (c instanceof ImmuneCell) && ((ImmuneCell)c).potency < this.potency && (maxBolsters >= bolsters) && (((ImmuneCell)c).decayTime <= 0))
          {
             ((ImmuneCell)c).potency += this.potency * supportEfficency;
             
             if(t.enableLines) {stroke(255,255,255,40); line(this.X + size/2, this.Y+ size/2, c.X+ size/2, c.Y+ size/2);}
             
             maxBolsters++;
          }
        
          //Immunize healthy cell
          if((c.iX > this.iX - range) && (c.iX < this.iX + range) && (c.iY > this.iY - range) && (c.iY < this.iY + range) && !(c instanceof ImmuneCell) && !(c instanceof InfectedCell) && (potency - potency * c.resistance > random(0,1)) && !c.impass && !(cures >= maxCuresPerTurn))
          {  
            
            if(t.enableLines) {stroke(0,150,0,120); line(this.X + size/2, this.Y+ size/2, c.X+ size/2, c.Y+ size/2);}
            t.cells.set(t.getIndex(c.iX, c.iY), new ImmuneCell(c.iX, c.iY, c.X, c.Y, c.size, this.range, c.resistance));  
            cures++;
            
          }
     
          
          
          //Attempt to cure InfectedCell, depends on the strength of immune cell and the infected cell
          if((c.iX > this.iX - range) && (c.iX < this.iX + range) && (c.iY > this.iY - range) && (c.iY < this.iY + range) && (c instanceof InfectedCell) && !c.impass && !(cures >= maxCuresPerTurn))
          {
            ((InfectedCell)c).infectivity -= potency * infectedCureModifier;
            if(t.enableLines) {stroke(t.healthy,160); line(this.X + size/2, this.Y+ size/2, c.X+ size/2, c.Y+ size/2);}
            cures++;
          }
        
        
        }
      } 
      
     //incrise potency by a precentage amount
     text = "" + potency;
     this.potency += potencyTick * potency;
     
     if(potency > maxPotency) {potency = maxPotency;}
    
     String tInf = round( potency * 100.0f ) / 100.0f + "";  //hacky af
     text = "" + tInf;
   }
  
}


 