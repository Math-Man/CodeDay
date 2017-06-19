using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RotatedStrings
{
    class Program
    {
        static void Main(string[] args)
        {

            string input = Console.ReadLine();
            List<char> output = new List<char>();
            for (int i = 0; i < input.Length; i++)
            {
                if (i == 0) { output[input.Length] = input[0]; }
                else
                {
                    output[i + 1] = input[i];
                }
            }


            foreach ()
            {

            }


        }
    }
}
