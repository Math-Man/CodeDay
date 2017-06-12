using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
/*This is part of a project I am working on where I attempt to write something little everyday
  Idea for this app is taken from: 
  https://www.reddit.com/r/dailyprogrammer/comments/67dxts/20170424_challenge_312_easy_l33tspeak_translator/
  The code demonstrates use of C# dictionary with value/key pair
*/
namespace l33t_Speak_Translator
{
    class Program
    {
        static void Main(string[] args)
        {
            Dictionary<char, string> l33t = new Dictionary<char, string>
            {
                {'A', "4" },
                {'B', "6" },
                {'E', "3" },
                {'I', "|" },
                {'L', "1" },
                {'M', "(V)" },
                {'N', "(\\)" },
                {'O', "0" },
                {'S', "5" },
                {'T', "7" },
                {'V', "\\/" },
                {'W', "'//" },

            };


            Console.Write("Input: ");
            string input = Console.ReadLine().ToUpper();
            string output = "";
            Random upperRand = new Random();
            //Convert
            foreach (char c in input)
            {

                bool m = false;

                foreach (KeyValuePair<char, string> pair in l33t)
                {
                    if (pair.Key.Equals(c))
                    {
                            output += pair.Value;
                            m = true;  
                    } 
                }

                if (!m)
                {
                    if (upperRand.Next(0, 1) == 0)
                    {
                        output += c.ToString().ToLower();
                    }
                    else
                    {
                        output += c;
                    }
                }
            }


            Console.WriteLine(output);
            Console.ReadKey();
            
        }
    }
}
