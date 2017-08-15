/*This is a mess :( atleast it works*/

//Tile t;
Maze m;
void setup()
{
  size(600,600);
  
  m = new Maze(20, 20, 20);
  m.genMaze();
  m.createSolution();
 /* t = new Tile(50,50,50);
  t.R = 100;
  t.G = 120;
  t.B = 80;
  t.tex = "YO";*/
}

void draw()
{
  m.displayAll();
}