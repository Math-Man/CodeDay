// Generates random names from a dictionary I found online ( http://www.ashley-bovan.co.uk/words/partsofspeech.html ), creates affixes prefixes, etc. 
// I know this is pretty basic stuff but this is something I wanted to make for a while just never got a round to it
//Program usually regurgitates random things. sometimes they are crazy enough to be funny 


class nameGen 
{
  
  String Adj, noun1, noun2, adverb, verb, word = "";
  
  public String generate()
  {
    word = 
    getRandomLine("adjectives.txt") + " " + getRandomLine("nouns.txt") + " the " + getRandomLine("adverbs.txt") + " " + getRandomLine("verbs.txt") + " of " + getRandomLine("nouns.txt") ;
    return word;
  }
  
  public String getRandomLine(String fileName)
  {
      BufferedReader reader = createReader(fileName);
      String line = "";
      ArrayList<String> lines = new ArrayList<String>();
      
      //get file length / put lines into a list
      try 
      {
        while(line != null)
        {
           line = reader.readLine();
           lines.add(line); 
         }
      }
      catch(IOException e)
      {
        e.printStackTrace();
      }
      
      //pick a random line
      return lines.get(floor(random(0, lines.size())));
  }
}

nameGen n;
PFont font;

void setup()
{
  size(550,100);
  n = new nameGen();
  //println(n.generate());
  font = createFont("Pristina", 12);
}

void draw()
{
  delay(5000);
  background(floor(random(0,100)), floor(random(0,100)), floor(random(0,100)));
  textFont(font);
  textSize(24);
  fill(floor(random(150,255)), floor(random(150,255)), floor(random(150,255)));
  String gen = n.generate();
  text(gen, 24, height/2);
  println(gen);
}