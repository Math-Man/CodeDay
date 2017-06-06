using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace De_Brujin_sequences
{

    //De Bruijn Sequences
    /* https://www.reddit.com/r/dailyprogrammer/comments/4riubi/20160706_challenge_274_intermediate_calculating/ */

    class Program
    {

        static void Main()
        {
            Console.WriteLine(String.Concat(DeBruijnSequence(5, 3)));
            Console.WriteLine(String.Concat(DeBruijnSequence(2, 4)));
            Console.WriteLine(String.Concat(DeBruijnSequence("abcde", 4)));
        }

        List<int> DeBruijnSequence(int k, int n)
        {
            var seq = DeBruijnSequence(String.Concat(Enumerable.Range(0, k)), n);
            return seq.Select(s => (int)s - 48).ToList();
        }

        List<char> DeBruijnSequence(string s, int n)
        {
            var k = s.Length;
            var seq = new List<char>();
            var tmp = new List<int>() { -1 };

            while (tmp.Count > 0)
            {
                tmp[tmp.Count - 1]++;
                if (n % tmp.Count == 0) tmp.ForEach(x => seq.Add(s[x]));
                int c = tmp.Count;
                while (tmp.Count < n) tmp.Add(tmp[tmp.Count - c]);
                while (tmp.Count > 0 && tmp.Last() == k - 1) tmp.RemoveAt(tmp.Count - 1);
            }
            return seq;
        }
    }
}
