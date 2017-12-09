using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


//Turns generated image file into a list of midi notes that can be played using this:

namespace Procedural_Music_Generation
{
    class MidiManager
    {
        public bool ReadHorizontal { get; set; }    //Read the image horizontally?
        public double TimeModifier { get; set; }    //Time between pixels in the read direction (additive)
        public double TimeDurationModifier { get; set; }    //How long every pixel's note plays (multiplicative)
        public double RespectiveDelay { get; set; } //Delay between different readLines (from left to rifgr or top to bottom)
        private CellManager Manager { get; }

        public MidiManager(CellManager c, bool ReadHorizontal, double TimeModifier, double TimeDurationModifier, double RespectiveDelay)
        {
            Manager = c;
            this.ReadHorizontal = ReadHorizontal;
            this.TimeModifier = TimeModifier;
            this.TimeDurationModifier = TimeDurationModifier;
            this.RespectiveDelay = RespectiveDelay;
        }

        public void Start()
        {
            List<string> notes = GenLines();
            Console.WriteLine(notes);

            StreamWriter st = new StreamWriter("out.txt");

            foreach (string line in notes)
            {
                st.WriteLine(line);
            }

            st.Close();
        }

        //Generates Note lines (split the loops into to becouse of the respective delay)
        public List<string> GenLines()
        {
            List<string> output = new List<string>();
            double timer = 0;
            if (ReadHorizontal)
            {
                for (int j = 0; j < Manager.BoardHeight; j++)
                {
                    timer = 0 + RespectiveDelay;
                    for (int i = 0; i < Manager.BoardWidth; i++)
                    {
                        foreach (Cell c in Manager.Cells)
                        {
                            if (c.X == i && c.Y == j)
                            {
                                output.Add(c.Midi_Note + " " + timer + " " + 0.5 * TimeDurationModifier);
                                Console.WriteLine(c.Midi_Note + " " + timer + " " + 0.5 * TimeDurationModifier);
                                timer += 0.5 + TimeModifier;
                                
                            }
                        }
                    }
                    //Reset the timer for the next line
                   

                }
            }
            else//Read from Left to Right
            {
                for (int i = 0; i < Manager.BoardWidth; i++)
                {
                    for (int j = 0; j < Manager.BoardHeight; j++)
                    {
                        foreach (Cell c in Manager.Cells)
                        {
                            if (c.X == i && c.Y == j)
                            {
                                output.Add(c.Midi_Note + " " + timer + " " + 0.5 * TimeDurationModifier);
                                Console.WriteLine(c.Midi_Note + " " + timer + " " + 0.5 * TimeDurationModifier);
                                timer += 0.5 + TimeModifier;
                                
                            }
                        }
                    }
                    timer = 0 + RespectiveDelay;
                }
            }
            return output;
        }


    }
}
        
