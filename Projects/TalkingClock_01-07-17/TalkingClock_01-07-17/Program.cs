using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//Turns numerical "time" value into words
//This is an experiment, I am aware Time&Date library has a functionality similar to this
//Input format : "HH:MM"

namespace TalkingClock_01_07_17
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("TIME FORMAT : 'HOUR:MINUTE (HH:MM)'");

            while (true)
            {


                string input = Console.ReadLine();
                string[] time = input.Split(':');
                string output = "";

                if (Int32.Parse(time[1]) == 0) { time[1] = ""; }
                else if (Int32.Parse(time[1]) > 60)
                {
                    time[1] = "60";
                }

                output += numberToWord(Int32.Parse(time[1])) + " past " + numberToWord(Int32.Parse(time[0]));
                if (Int32.Parse(time[0]) >= 12 && Int32.Parse(time[0]) < 24)
                {
                    output += " pm!";
                }
                else if (Int32.Parse(time[0]) < 12 && Int32.Parse(time[0]) >= 0)
                {
                    output += " am!";
                }
                else { output = "Why you do dis :("; }

                Console.WriteLine(output);
                Console.ReadKey();
            }
        }


        //only works for numbers below 100
        public static string numberToWord(int n)
        {
            string output = "";

            if (n == 0) { return "zero"; }
            if (n < 0) { return "negative " + numberToWord(Math.Abs(n)); }

            if (n > 0)
            {
                var nums = new[] { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" };
                var tens = new[] { "zero", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety" };

                if (n < 20)
                {
                    output += nums[n];
                }
                else
                {
                    output += tens[n / 10];
                    if ((n % 10) > 0)
                    {
                        output += " " + nums[n % 10];
                    }

                }
            }

            return output;

        }


    }
}
