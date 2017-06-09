using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

/*

    This app demonstrates regular expression.
    I just happend to learn about Regex library and it seems so much fun.

    
     
*/
namespace Regular_Expression_Example
{
    class Program
    {
        static void Main(string[] args)
        {


            string input = Console.ReadLine();
            Regex r = new Regex("(?i)[b-df-hj-np-tv-xz]");//non vowels
            Console.WriteLine(r.Replace(input, new MatchEvaluator(rob)));

            Console.ReadKey();
        }

        static string rob(Match m) { return m.Value + "o" + m.Value.ToLower(); }
    }
}
