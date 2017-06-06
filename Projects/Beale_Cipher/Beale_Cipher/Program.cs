using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Console;
using static System.Int32;
using static System.IO.File;


namespace Beale_Cipher
{
    class Program
    {

        static void Main(string[] args)
        {
            List<int> l = new List<int>();
            l = ReadAllText("Cipher.txt").Split(',').Select(Parse).ToList();

            l.ForEach(c => Write($"{ReadAllText("DOI.txt").Split(' ')[c - 1][0]}"));

            Console.ReadKey();


        }
    }
}
