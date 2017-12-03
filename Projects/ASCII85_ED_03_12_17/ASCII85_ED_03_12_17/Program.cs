using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//https://www.reddit.com/r/dailyprogrammer/comments/7gdsy4/20171129_challenge_342_intermediate_ascii85/

namespace ASCII85_ED_03_12_17
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Decode: 0, Encode: 1, Test: 2");
            string s = Console.ReadLine();
            if (s.Equals("0"))
            {
                Console.WriteLine("Message?");
                string tr = Console.ReadLine();
                Console.WriteLine("DECODED85: " + decode85(tr));
            }
            else if (s.Equals("1"))
            {
                Console.WriteLine("Message?");
                string tr = Console.ReadLine();
                Console.WriteLine("ENCODED85: " + encode85(tr));
            }
            else if (s.Equals("2"))
            {
                Console.WriteLine("DECODE85: '87cURD_*#TDfTZ)+T'  " + decode85("87cURD_*#TDfTZ)+T"));
                Console.WriteLine("DECODE85: '06/^V@;0P'E,ol0Ea`g%AT@'  " + decode85("06/^V@;0P'E,ol0Ea`g%AT@"));
                Console.WriteLine("DECODE85: '7W3Ei+EM%2Eb-A%DIal2AThX&+F.O,EcW@3B5\\nF/hR'  " + decode85("7W3Ei+EM%2Eb-A%DIal2AThX&+F.O,EcW@3B5\\nF/hR"));
                Console.WriteLine("DECODE85: '6#:?H$@-Q4EX`@b@<5ud@V'@oDJ'8tD[CQ-+T'  " + decode85("6#:?H$@-Q4EX`@b@<5ud@V'@oDJ'8tD[CQ-+T"));
                Console.WriteLine("ENCODED85: 'Mom, send dollars!'  " + encode85("Mom, send dollars!"));
                Console.WriteLine("ENCODED85: 'Attack at dawn'  " + encode85("Attack at dawn"));
            }

            Console.ReadKey();
        }
        public static string decode85(string msg)
        {
            var padding = 5 - (msg.Length % 5);
            if (padding != 0)
            {
                var pd = new char[padding];
                for (int i = 0; i < padding; i++)
                {
                    pd[i] = (char)117;
                }
                msg = String.Concat(msg, new string(pd));
            }
            char[] Valr = new char[((msg.Length / 5) * 4)];
            for (int i = 0; i < msg.Length; i += 5)
            {
                long val = 0;
                for (int j = 4; j >= 0; j--)
                {
                    val += (long)Math.Pow(85, 4 - j) * (msg[(i + j)] - 33);
                }
                for (int j = 0; j <= 3; j++)
                {
                    Valr[((i / 5) * 4) + (3 - j)] = (char)(val % 256);
                    val /= 256;
                }
            }
            return new String(Valr).Substring(0, Valr.Length - padding);
        }
        public static string encode85(string msg)
        {
            int padding = 4 - msg.Length % 4;
            if (padding != 0)
            {
                var pd = new char[padding];
                for (int i = 0; i < padding; i++)
                {
                    pd[i] = (char)0;
                }
                msg = String.Concat(msg, new string(pd));
            }
            char[] Valr = new char[((msg.Length / 4) * 5)];
            for (int i = 0; i < msg.Length; i += 4)
            {
                var val = 0;
                for (int j = 0; j < 4; j++)
                {
                    val *= 256;
                    val = val | msg[i + j];
                }
                for (int j = 0; j <= 4; j++)
                {
                    Valr[((i / 4) * 5) + (4 - j)] = (char)(val % 85 + 33);
                    val /= 85;
                }
            }
            return new string(Valr).Substring(0, Valr.Length - padding);
        }
    }
}



