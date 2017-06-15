class Cell
{
  int x;
  int y;
  PropagationModel model;
  Boolean infected;
  Boolean immune;
  
  public Cell(PropagationModel model, int x, int y, Boolean infected)
  {
    this.model = model;
    this.x = x;
    this.y = y;
    this.infected = infected;
    this.immune = false;
  }

  void drawCell()
  {
    //Set colours

    if(infected){fill(200,50,50); stroke(200,100,100);}
    else if(immune){fill(30,30,120); stroke(100,100,255);}
    else{fill(175); stroke(220);}
    rect(x, y, model.sideLength, model.sideLength);
  }
}