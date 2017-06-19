using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
/*This is part of a project where I attempt to code something intresting everyday*/
namespace Bitwise_Multiplication
{
    class Program
    {
        static void Main(string[] args)
        {
            int a, b, fin;

            /*Inputs*/
            a = 4;
            b = 3;
            /*      */
            fin = 0;

            while (b != 0)
            {
                if ((b & 01) == 1)  //bitwise AND
                {
                    fin += a;
                }
                a <<= 1; //left shit a by 1
                b >>= 1; //Right shift b by 1
            }

            Console.WriteLine("R: " + fin);
            Console.ReadKey();
        }
    }
}
