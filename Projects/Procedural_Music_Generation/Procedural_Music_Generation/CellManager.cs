using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


//Generates a Bitmap with given parameters
//Different colours give different midi notes
namespace Procedural_Music_Generation
{
    class CellManager
    {

        public int BoardWidth { get; set; }
        public int BoardHeight { get; set; }
        public List<Cell> Cells { get; set; }
        private List<Cell> BoardCells { get; set; }  //Cells that can be placed on this board

        public CellManager(int w, int h)
        {
            BoardWidth = w;
            BoardHeight = h;
            
            BoardCells = new List<Cell>();
            Cells = new List<Cell>();

            GenerateNoteCells(127);    //Generates cells with randomized rules to be used
            PopulateBoard();    //Populate the board with random cells
            Cells = Cells.OrderBy(x => x.X).ToList<Cell>();
        }

        //Starts a simulation for spreading for the given number of turns
        public void Start(int TurnCount)
        {
            for (int i = 0; i < TurnCount; i++)
            {
                for (int c = 0; c < Cells.Count; c++)
                {
                    Cells[c].Spread(this);
                }
            }
            Console.WriteLine("Simulation Complete...");
            Console.ReadKey();
            Console.WriteLine("Saving as: out.png. Total Pixels: " + Cells.Count);
            GenerateBoardImage("out.png");
            

        }

        //Populate every pixel of the board with a new cell with random spread rules and color
        private void PopulateBoard()
        {

            //Console.WriteLine("Populating Board...");
            

            for (int y = 0; y < BoardHeight; y++)
            {
                for (int x = 0; x < BoardWidth; x++)
                {
                    
                    //Cell c = BoardCells[rnd.Next(0, BoardCells.Count)];
                    Cell c = new Cell(120,120,120);
                    c.Red = BoardCells[Program.rng.Next(0, BoardCells.Count)].Red;
                    c.Green = BoardCells[Program.rng.Next(0, BoardCells.Count)].Green;
                    c.Blue = BoardCells[Program.rng.Next(0, BoardCells.Count)].Blue;
                    c.SpreadRules = BoardCells[Program.rng.Next(0, BoardCells.Count)].SpreadRules;
                    c.Midi_Note = BoardCells[Program.rng.Next(0, BoardCells.Count)].Midi_Note;
                    c.setRules(BoardCells[Program.rng.Next(0, BoardCells.Count)].SJumpDistance, BoardCells[Program.rng.Next(0, BoardCells.Count)].SHorizontalWeight, BoardCells[Program.rng.Next(0, BoardCells.Count)].SVerticalWeight, BoardCells[Program.rng.Next(0, BoardCells.Count)].SMaxPositiveSpreadRule);
                    c.setPos(x,y);
                    Cells.Add(c);
                }
            }


            
        }

        //Generates 128 different cells 1 for each midi note, set the note as well
        private void GenerateNoteCells(int Amount_To_Generate)
        {
            if (Amount_To_Generate > 127) Amount_To_Generate = 127;
            if (Amount_To_Generate < 2) Amount_To_Generate = 2;

            int MidiCounter = 0;
            for (int i = 0; i < Amount_To_Generate; i++)
            {
                Cell c = new Cell(Program.rng.Next(120, 255), Program.rng.Next(120, 255), Program.rng.Next(120, 255));
                c.setRules(Program.rng.Next(0, 2), Program.rng.NextDouble(), Program.rng.NextDouble(), Program.rng.Next(0, 4)); //Give random set of rules
                c.Midi_Note = MidiCounter;
                c.setPos(0,0);
                BoardCells.Add(c);
                MidiCounter++;
            }
        }

        //Create a bitmap and save it to the given directory
        private void GenerateBoardImage(string OutputName)
        {
            Bitmap bmp = new Bitmap(BoardWidth, BoardHeight);
            //Set pixels of the boardImage
            foreach (Cell c in Cells)
            {
                bmp.SetPixel(c.X, c.Y, Color.FromArgb(c.Red, c.Green, c.Blue));
            }
            
            bmp.Save(OutputName);
            


        }



    }
}
