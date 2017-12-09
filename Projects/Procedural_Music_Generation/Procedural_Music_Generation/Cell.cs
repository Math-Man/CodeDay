using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Procedural_Music_Generation
{
    class Cell
    {

        /*Spread Parameters, Effects the spread rules*/
        public int SJumpDistance { get; set; }  //Allows cell to spread to further distances, value indicates the amount of pixels that can be jumped
        public double SHorizontalWeight { get; set; }   // How likely it is for this cell to spread horizontally, 1 indifferent, lower value lower chance
        public double SVerticalWeight { get; set; } //How likely it is for this cell to spread Vertically 1 indifferent, lower value lower chance
        public int SMaxPositiveSpreadRule { get; set; } //Max amount of cells this cell can spread to in 1 turn
        

        public int Red { get; set; }
        public int Green { get; set; }
        public int Blue { get; set; }

        public int X { get; set; }
        public int Y { get; set; }

        public int[] SpreadRules { get; set; }
        private bool SpawnSickness { get; set; }

        //Note that will be played for this cell
        public int Midi_Note { get; set; }

        public Cell(int R, int G, int B)
        {
            SpawnSickness = true;
            Red = R;
            Green = G;
            Blue = B;
        }

        public void setPos(int x, int y)
        {
            X = x;
            Y = y;
        }

        //SEts the rule parameters
        public void setRules(int SJumpDistance, double SHorizontalWeight, double SVerticalWeight, int SMaxPositiveSpreadRule)
        {
            this.SJumpDistance = SJumpDistance; //Done
            this.SHorizontalWeight = SHorizontalWeight;
            this.SVerticalWeight = SVerticalWeight;
            this.SMaxPositiveSpreadRule = SMaxPositiveSpreadRule;   //Done
            GenerateRules();
        }

        //Generates a random set of rules for this cell to copy itself, uses rule parameters
        private void GenerateRules()
        {
            SpreadRules = new int[(int)Math.Pow(3+ 2*SJumpDistance, 2)];
            int positiveRuleCounter = 0;

            for (int i = 0; i < SpreadRules.Length; i++)
            {
                if (positiveRuleCounter > SMaxPositiveSpreadRule) break;
               
                int r = Program.rng.Next(0, 2);
                SpreadRules[i] = r;

                if (r == 1) positiveRuleCounter++;
            }
        }

        //Spread the cell on the given board depending on the rules
        public void Spread(CellManager manager)
        {
            //If the creep spawned this turn, dont spread
            if (SpawnSickness == true) { SpawnSickness = false; return; }

            int ruleCounter = 0; //Checks the rules array for resepctive position 
            for (int i = -1* SJumpDistance; i <= 1* SJumpDistance; i++)
            {
                for (int j = -1* SJumpDistance; j <= 1* SJumpDistance; j++)
                {
                    try
                    {
                        foreach (Cell c in manager.Cells)
                        {
                            //Random check is the Chance to be replaced
                            if (c.Y == this.Y + i && c.X == this.X + j && SpreadRules[ruleCounter] == 1)
                            {
                                //Set rule and color of the cell being spread same as this cell
                                c.SpreadRules = this.SpreadRules;
                                c.Red = Red;
                                c.Green = Green;
                                c.Blue = Blue;
                                c.SpawnSickness = true;
                            }
                        }
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine("Something went wrong" + e.Data);
                    }
                    ruleCounter++;
                }
            }
        }


    }
}
