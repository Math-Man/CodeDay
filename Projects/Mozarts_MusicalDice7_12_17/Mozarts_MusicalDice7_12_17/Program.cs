using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//https://www.reddit.com/r/dailyprogrammer/comments/7i1ib1/20171206_challenge_343_intermediate_mozarts/
//http://ufx.space/stuff/mozart-dice/  --To test


    //Kind of a mess but works
namespace Mozarts_MusicalDice7_12_17
{
    class Program
    {
        static void Main(string[] args)
        {
            /*
             96 32 69 40 148 104 152 119 98 3 54
            22 6 95 17 74 157 60 84 142 87 130
            141 128 158 113 163 27 171 114 42 165 10
            41 63 13 85 45 167 53 50 156 61 103
            105 146 153 161 80 154 99 140 75 135 28
            122 46 55 2 97 68 133 86 129 47 37
            11 134 110 159 36 118 21 169 62 147 106
            30 81 24 100 107 91 127 94 123 33 5
            70 117 66 90 25 138 16 120 65 102 35
            121 39 136 176 143 71 155 88 77 4 20
            26 126 15 7 64 150 57 48 19 31 108
            9 56 132 34 125 29 175 166 82 164 92
            112 174 73 67 76 101 43 51 137 144 12
            49 18 58 160 136 162 168 115 38 59 124
            109 116 145 52 1 23 89 72 149 173 44
            14 83 79 170 93 151 172 111 8 78 131
             */
            string measure = "96 32 69 40 148 104 152 119 98 3 54"; //Select measure from above

            List<string> ads = getBeats(measure, @"Starting_Compostion.txt");
            StreamWriter writer = new StreamWriter(@"out.txt");
            foreach (string s in ads)
            {
                Console.WriteLine(s);
                writer.WriteLine(s);
            }

            writer.Close();
            Console.ReadKey();
        }

        public static List<string> getBeats(string measure, string startingComp)
        {
            List<string> output = new List<string>();
            int beatCounter = 0;
            string[] parts = measure.Split(' '); // 96 32 69 40 148 104 152 119 98 3 54
            

            //i shows what line to read on the startingComp
            for (int i = 0; i < parts.Length; i++)
            {
                double rnum = Double.Parse(parts[i]);
                StreamReader reader = new StreamReader(startingComp);
                //Read throguh startingComp
                for (int j = 0; j < 1386; j++)
                {
                    string line = reader.ReadLine();
                    //If the line is equal to the given value at the parts, record next 4 values
                    if ( Double.Parse(parts[i]) <= Double.Parse(line.Split(' ')[1]) && Double.Parse(parts[i]) + 3 > Double.Parse(line.Split(' ')[1]))
                    {
                        //Chnage line's beat index with beat counter
                        string[] sLine = line.Split(' ');
                        
                        //Change counter if the beat index changed
                        if (rnum != Double.Parse(sLine[1]))
                        {
                            rnum = Double.Parse(sLine[1]);
                            beatCounter++;
                        }
                        sLine[1] = beatCounter.ToString();

                        string ot = "";
                        foreach (string s in sLine)
                        {
                            ot += s + " ";
                        }
                        ot = ot.TrimEnd(' ');

                        output.Add(ot);
                        
                    }
                }
            }
            return output;

        }
    }
}
