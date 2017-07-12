using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/*Challenge from /r/dailyprogrammer  2017-07-10 | pseudocode found on wikipedia */

namespace _3SUM_12_07_17
{
    class Program
    {
        static void Main(string[] args)
        {

            string input = "4 5 -1 -2 -7 2 -5 -3 -7 -3 1";


            string[] chars = input.Split(' ');
            int size = chars.Length;
            int[] nums = new int[size];


            int i = 0;
            foreach (string s in chars)
            {
                nums[i] = Int32.Parse(s);
                i++;
            }


            Array.Sort(nums);
            int solCounter = 0;
            //naive method, search from start to end
            for (int k = 0; k < size - 3; k++)
            {
                int pA = nums[k];
                int start = k + 1;
                int end = size - 1;

                //search until start & end meets in the middle
                while (start < end)
                {
                    int pB = nums[start];
                    int pC = nums[end];

                    if (pA + pB + pC == 0)
                    {
                        solCounter++;
                        Console.WriteLine("3Sum #" + solCounter + " : " + pA + " " + pB + " " + pC);
                        end--;
                    }
                    else if (pA + pB + pC > 0)
                    {
                        end--;
                    }
                    else
                    {
                        start++;
                    }
                }

            }


            Console.ReadKey();

        }
    }
}
