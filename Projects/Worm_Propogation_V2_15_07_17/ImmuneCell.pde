class ImmuneCell extends Cell 
{ 
  int range;
  float potency;  //same with infectedCel's infectivity this value does not go down however.
  float supportEfficency = 0.001;
  float potencyTick = 0.01;
  float maxPotency = 0.5;
  int maxBolsters = 1;
  int maxCuresPerTurn = 1;
  float infectedCureModifier = 0.2;

  
    
  public ImmuneCell(int iX, int iY, int posX, int posY, int size, int r)
  {
    super(iX, iY, posX, posY, size);  //call the parent constructor
    this.state = 1;
    this.range = r;
    this.potency = 0.1;
  }
  
  
  //attempts to spread to everything in its range at once
   public void spread(CellTable t)
   {
     
        int cures = 0;
        int bolsters = 0;
        

      //Go through cells on the table
      for(Cell c : t.cells)
      {
        //make sure to ignore self and impass
        if(!c.equals(this) || c.impass)
        {
          

          
          //check if cap is reached, if so stop the loop
          if(cures >= maxCuresPerTurn )
          {
            break;
          }
          
          //Support the nearby immune cells if they are weaker than this cell 
          if((c.iX > this.iX - range) && (c.iX < this.iX + range) && (c.iY > this.iY - range) && (c.iY < this.iY + range) && (c instanceof ImmuneCell) && ((ImmuneCell)c).potency < this.potency && (maxBolsters >= bolsters))
          {
             ((ImmuneCell)c).potency += this.potency * supportEfficency;
             
             if(t.enableLines) {stroke(255,255,255,40); line(this.X + size/2, this.Y+ size/2, c.X+ size/2, c.Y+ size/2);}
             
             maxBolsters++;
          }
        
          //Immunize healthy cell
          if((c.iX > this.iX - range) && (c.iX < this.iX + range) && (c.iY > this.iY - range) && (c.iY < this.iY + range) && !(c instanceof ImmuneCell) && !(c instanceof InfectedCell) && (potency - potency * c.resistance > random(0,1)) && !c.impass)
          {  
            
            if(t.enableLines) {stroke(0,150,0,120); line(this.X + size/2, this.Y+ size/2, c.X+ size/2, c.Y+ size/2);}
            t.cells.set(t.getIndex(c.iX, c.iY), new ImmuneCell(c.iX, c.iY, c.X, c.Y, c.size, this.range));  
            cures++;
            
          }
     
          
          
          //Attempt to cure InfectedCell, depends on the strength of immune cell and the infected cell
          if((c.iX > this.iX - range) && (c.iX < this.iX + range) && (c.iY > this.iY - range) && (c.iY < this.iY + range) && (c instanceof InfectedCell))
          {
            ((InfectedCell)c).infectivity -= potency * infectedCureModifier;
            if(t.enableLines) {stroke(t.healthy,160); line(this.X + size/2, this.Y+ size/2, c.X+ size/2, c.Y+ size/2);}
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


 