/*
*  This app is a part of my "CodeDay" Project where I attempt to write something everyday
*  
*  This app is supposed to "simulate" tron like particle behaviour, it is kind of patchy since my knowledge on processing is limited. Also its really badly optimized
*  I might comeback to finish this later on.
*  08/06/2017
*/

//Parameters:
int maxParticleAmount = 16;




//Particles can only move in 1 direction
class Particle 
{
   int x,y; //Position x,y
   int vx,vy; //speed X & Y
   ArrayList<Particle> tail = new ArrayList<Particle>();
   int tailLength = 0;
   public color strokeColor = color(255,0,0);
   
   public Particle(int x, int y, int vx, int vy)
   {
     this.x = x;
     this.y = y;
     this.vx = vx;
     this.vy = vy;
     
   }
   
   //Constructor for a particle at a random position
   public Particle()
   {

     this.x = (int)random(0, width);
     this.y = (int)random(0, height);
     if(random(0,1) > 0.5)
     {
       this.vx = 1;
     }
     else
     {
       this.vy = 1;
     }
   }

   //puts the particle on the canvas
   void place()
   {
     stroke(strokeColor);
     ellipse(x, y, 1, 1);
   }
   
   //move the particle , add to the tail
   void move()
   {
     //println(x+" "+y);

     
     x += vx;
     y += vy;
     
     //patch-work
     if(x < 0){x = 0;}
     else if(x > width){x = width;}
     if(y < 0){y = 0;}
     else if(y > height){y = height;}

      
      
     //add a stagnent particle to the tail
     Particle d = null;//dead Particle
     Particle t = new Particle(x,y,0,0);
     tail.add(t);
     
     for(Particle p : tail)
     {
       p.strokeColor = (p.strokeColor - color(1,254,254));  //decay the color
       if(p.strokeColor < color(255,0,0))
       {
          d = p;
       }
     }
     
     tail.remove(d);
   }
   
   void drawTail()
   {
     for(Particle t : tail)
     {
       t.place();
     }
   }
   
   //This is extremely patchy, I might attempt to fix this later on
   //Checks infront of the particle for obstacles
   void checkFront() 
   {
     if(vx != 0)//If going horizontal
     {
       if(vx > 0)//if going to the right
       {
         if(get(x + 1, y) != color(255) || x + 1 == width) //if something is found to the right of this particle, change direction randomly either to the top or bottom
         {
           int direction = (int)Math.ceil(random(-2, 1));
           
           if(get(x,y  + direction) != color(255))//if the random case isn't viable do the other
           {
              this.applyForce(false, -direction);
           }
           else
           {
              this.applyForce(false, direction);
           }

         }
       }
       else//if going to the left
       {
         if(get(x - 2, y) != color(255) || x - 1 == 0)//change the direction to top or bottom
         {
           int direction = (int)Math.ceil(random(-2, 1));
           
           if(get(x,y  + direction) != color(255))//if the random case isn't viable do the other
           {
              this.applyForce(false, -direction);
           }
           else
           {
              this.applyForce(false, direction);
           }
           
         }
       }
     }
     else//If going vertical
     {
       if(vy > 0)//If going below
       {
         if(get(x, y + 1) != color(255) || y + 1 == height)//change the direction to left or right
         {
           int direction = (int)Math.ceil(random(-2, 1));

           if(get(x + direction,y) != color(255))//if the random case isn't viable do the other
           {
              this.applyForce(true, -direction);
           }
           else
           {
              this.applyForce(true, direction);
           }
         }
       }
       else//If going above
       {
         if(get(x, y - 1) != color(255) ||y - 1 == 0)//change the direction to left or right
         {
           int direction = (int)Math.ceil(random(-2, 1));
           
           if(get(x + direction,y) != color(255))//if the random case isn't viable do the other
           {
              this.applyForce(true, -direction);
           }
           else
           {
              this.applyForce(true, direction);
           }

         }
       }
     }
   }
   
   //Changes movement of a particle
   void applyForce(boolean isHorizontal, int speed) 
   {
     if(isHorizontal)
     {
       vx += speed;
       vy = 0;
     }
     else
     {
        vy += speed;
        vx = 0;
     }
   }
    
}



//Controls Particles within an array
class Particle_Controller
{
  
  public Particle_Controller(int particleCount)
  {
    
    if(particleCount > maxParticleAmount) particleCount = maxParticleAmount;
    for(int i = 0; i < particleCount; i++)
    {
      Particle p = new Particle();
      particles.add(p);
    }
  }
  
  
  public ArrayList<Particle> particles = new ArrayList<Particle>();
   
  void createParticle(int x, int y, int vx, int vy) 
  {
    if(vx != 0){vy = 0;}
    if(particles.size() > maxParticleAmount){return;}
    Particle p = new Particle(x, y, vx, vy);
    particles.add(p);
  }
  
  void placeAll()
  {
    for(Particle p : particles)
    {
      p.place();
    }
  }
   
  void moveAll()
  {
    for(Particle p : particles)
    {
      p.move();
    }
  }
  
  void drawAllTails()
  {
    for(Particle p: particles)
    {
      p.drawTail();
    }
  }
  
  void checkFrontAll() 
  {
    for(Particle p : particles)
    {
      p.checkFront();
    }
  }
  
  void randomizeColors()
  {
    for(Particle p: particles)
    {
      p.strokeColor = color((int)Math.ceil(random(0,254)) , (int)Math.ceil(random(0,254)) , (int)Math.ceil(random(0,254)));
    }
  }
  
}


Particle_Controller pc;
void setup()
{
  size(400,400);
  pc = new Particle_Controller(6);
  pc.randomizeColors();
}

void draw() 
{
  background(255);
  
  
  pc.placeAll();
  pc.drawAllTails();
  pc.moveAll();
  pc.checkFrontAll();
}


void mousePressed()
{
  pc.createParticle(mouseX,mouseY, (int)Math.ceil(random(-1,1)), (int)Math.ceil(random(-1,1)));
}