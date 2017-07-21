//Worm Propogation V2
//Updated, multilevel version of worm propogation, this probably wont be done in a single upload, this is also written from scratch

/*
  This version contains mutliple systems or "tables" and spread happens between certain cells that are randomly picked
  Infection also works differently as the infected cells heal differently, infected cels will only be able to infect cells within range same for immune cells
*/


//TODO: 
/*
  this code is bad and I feel bad
  Rework the index thing, it doesnt work

*/



class PModel
{
  
}


CellTable t;

void setup()
{
  size(600,600);
  t = new CellTable(0,0, 30, 30, 20);
  t.setColorSet(100,200,70);
  print(t.getCellAt(1,1));
  
}

void draw()
{
  t.DisplayTable();
  t.updateTable();
  delay(20);
}

void mousePressed()
{
  
  println(t.getCellOn(mouseX, mouseY).impass);
  if(mouseButton == LEFT)
  {
    if(t.getCellOn(mouseX, mouseY) instanceof InfectedCell) 
    {
      t.heal(mouseX, mouseY);
    }
    else if( !t.getCellOn(mouseX, mouseY).impass )
    {
       t.heal(mouseX, mouseY);
       t.getCellOn(mouseX, mouseY).impass = true;
    }
    else 
    {
       //t.getCellOn(mouseX, mouseY).impass = false;
       t.Infect(mouseX, mouseY);
    }
    
  }
  if(mouseButton == RIGHT)
  {
    if(t.getCellOn(mouseX, mouseY) instanceof ImmuneCell) 
    {
      t.heal(mouseX, mouseY);
    }
    else 
    {
      t.immune(mouseX, mouseY);
    }
  }
  

 
}