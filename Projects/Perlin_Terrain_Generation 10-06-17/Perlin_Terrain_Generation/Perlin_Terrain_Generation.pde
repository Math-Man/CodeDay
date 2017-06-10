/*
* This is part of a project where I attempt to write something intresting everyday.
*
*/

float frequencyMult = 12;  //Makes the map cover more area (between 1 - 25)
float octaves = 6;    //# of different octaves on the map(different elevation lines)(between 1 - 8)(single octave usually gives islands)
float redist = 1; //Generic Elevation of the map (between 0.01 - 10)
float waterLine = 0.95; //Where the water begins. (between 0.1 - 1.5)
float beachLine = 1.05; // where the beach/sandy area is (between 0.1 - 1.5)
float rockyLine = 1.15; //How high the rocky mountains start (between 0.1 - 1.5)
float snowLine = 1.35; // How low the snow is (between 0.1 - 1.5)
void setup()
{
  size(600,600);
}

void draw()
{
  
  float[][] value = new float[width][height];  //Elevation value
  
  for(int y = 0; y < height; y++)
  {
    for(int x = 0; x < width; x++)
    {
      float sume = 0; // base value of elevation
      float nx = x / (width - 0.5);
      float ny = y / (height - 0.5);
       
      sume = noise(frequencyMult * nx, frequencyMult * ny); 
      
      for(int octave = 1; octave < octaves; octave++)
      {
        sume += (1/octave) * (noise(frequencyMult * octave * 2 * nx, frequencyMult * octave * 2 * ny)); 
      }
      
      
      value[y][x] = (float)Math.pow(sume, redist);
      
      //R G B
      //Changing the final map ranges changes the theme of the ma
      /*
      float r = map(value[y][x], 0, 1.5, 100, 125);
      float g = map(value[y][x], 0, 1.5, 100, 255);
      float b = map(value[y][x], 0, 1.5, 100, 125);
      */
      
      float r = 0,g = 0,b = 0;
      //water setup
      if(sume < waterLine)
      {
         r = map(value[y][x], 0, 1.5, 50, 75);
         g = map(value[y][x], 0, 1.5, 50, 75);
         b = map(value[y][x], 0, 1.5, 200, 250);
      }
      //Beach/sand
      else if(sume > waterLine && sume < beachLine)
      {
         r = map(value[y][x], 0, 1.5, 170, 240);
         g = map(value[y][x], 0, 1.5, 170, 240);
         b = map(value[y][x], 0, 1.5, 110, 130);
      }
      //Land
      else if(sume < rockyLine && sume > beachLine)
      {
         r = map(value[y][x], 0, 1.5, 80, 125);
         g = map(value[y][x], 0, 1.5, 100, 210);
         b = map(value[y][x], 0, 1.5, 80, 125);
      }
      //Where the mountains start
      else if(sume > rockyLine && sume < snowLine)
      {
         r = map(value[y][x], 0, 1.5, 120, 160);
         g = map(value[y][x], 0, 1.5, 120, 160);
         b = map(value[y][x], 0, 1.5, 100, 140);
      }
      //Snow(mountain top)
      else if(sume > snowLine)
      {
         r = map(value[y][x], 0, 1.5, 150, 255);
         g = map(value[y][x], 0, 1.5, 150, 255);
         b = map(value[y][x], 0, 1.5, 150, 255);
      }
      stroke(r,g,b);
      point(x,y);

    }
  }
}