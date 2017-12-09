using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//Whole code is atrocious to read just dont bother

//https://www.reddit.com/r/dailyprogrammer/comments/7ifbd5/20171208_challenge_343_hard_procedural_music/
//Generates procedural music with my variation of cellular automata
//Reference:
//http://tones.wolfram.com/generate/Gt4Ufwdq4Q6d9YCovPBZkqZByzZOthJGHYqCEGUnGQucsC

namespace Procedural_Music_Generation
{
    class Program
    {
        public static Random rng = new Random();

        static void Main(string[] args)
        {

            CellManager c = new CellManager(100,4);
            c.Start(50);

            Process.Start("out.png");


            MidiManager man = new MidiManager(c,true,0.4,1.1,0);
            man.Start();

            Console.ReadKey();
        }
    }
}
