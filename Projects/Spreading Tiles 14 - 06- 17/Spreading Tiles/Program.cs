using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/*
 * This is part of a project where I attempt to write something little everyday
 * 
 * This program is kind of buggy but I have been going through a rough patch recently (also the reason why I didn't upload anything on 13th) so I left it as is.
 */
namespace Spreading_Tiles
{
    class Program
    {

        static string[] map =
        {
            "###############",
            "#....#..#.....#",
            "#..#.#..#.#...#",
            "#..#....#.#...#",
            "#..#....#.#...#",
            "#..######.#...#",
            "#.........#...#",
            "############.##",
            "#.............#",
            "###.####.######",
            "#......#.....*#",
            "###############"
        };


        static int width = 15;
        static int height = 12;

        static void Main(string[] args)
        {

            createTileList();
            int c = 0;
            while (true)
            {
                drawTiles();
                spread();
                Console.ReadKey();
                if (c == width * height) { break; }
                c++;
                Console.Clear();
            }

        }
        static List<Tile> tiles = new List<Tile>();

        static public void createTileList()
        {
            for (int y = 0; y < height; y++)
            {
                for (int x = 0; x < width; x++)
                {
                    tiles.Add(new Tile(x, y, map[y][x]));
                }
            }
        }

        static public void drawTiles()
        {
            for (int y = 0; y < height; y++)
            {
                for (int x = 0; x < width; x++)
                {
                    foreach (Tile ts in tiles)
                    {
                        if (ts.X == x && ts.Y == y)
                        {
                            Console.Write(ts.character);
                        }
                    }
                }
                Console.Write("\n");
            }
        }

        static public void spread()
        {
            foreach (Tile t in tiles)
            {
                bool updated = false;
                if (t.character.Equals('*') && !updated)
                {
                    for (int conv = 0; conv < 4; conv++)
                    {
                        foreach (Tile neighnour in tiles)
                        {
                            if (!neighnour.character.Equals('#'))
                            {
                                if ((neighnour.X == t.X - 1 && neighnour.Y == t.Y) || (neighnour.X == t.X + 1 && neighnour.Y == t.Y) || (neighnour.Y == t.Y - 1 && neighnour.X == t.X) || (neighnour.Y == t.Y + 1 && neighnour.X == t.X))
                                {
                                    neighnour.character = '*';


                                }
                            }
                        }
                    }
                    updated = true;
                }
            }
        }

    }

    class Tile
    {

        public Tile(int x, int y, char ch)
        {
            this.X = x;
            this.Y = y;
            this.character = ch;
        }
        public int X { get; set; }
        public int Y { get; set; }
        public ConsoleColor Color { get; set; }
        public char character { get; set; }
    }


}
