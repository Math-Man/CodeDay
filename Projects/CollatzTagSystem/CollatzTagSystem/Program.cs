using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



//Collatz tag system 05/06/2017
//https://en.wikipedia.org/wiki/Tag_system#Example:_Computation_of_Collatz_sequences
//Uses C# Queues and Dictionries

namespace CollatzTagSystem
{
    class Program
    {
        static void Main(string[] args)
        {
            Dictionary<char, char[]> alphabet = new Dictionary<char, char[]>
            {
                { 'a', new char[] { 'b','c' } },
                { 'b', new char[] { 'a' } },
                { 'c', new char[] { 'a', 'a', 'a' } }
            };
            Console.Write("Input should be something similar to aaa, aaaa, aaabc , aaabbc etc.\n");
            string inputLine = Console.ReadLine(); //example : aaa
            string currentLine = inputLine;
            Queue<char> seq = new Queue<char>();

            for (int i = 0; i < currentLine.Length; i++)
            {
                seq.Enqueue(currentLine[i]);
            }

            while ((currentLine.Length > 2))
            {

                char c = seq.Dequeue();
                if (seq.Count == 0) { Console.ReadKey(); return; }
                seq.Dequeue();


                foreach (char s in alphabet[c])
                {
                    seq.Enqueue(s);
                }

                Console.WriteLine(seq.ToArray<char>());

            }

        }
    }
}
