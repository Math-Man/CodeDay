using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
/*This app is a part of a project where I attempt to write something intresting everyday
 
  A very basic "Brain Fuck" Interpreter, I am planning on improving this later on
  and maybe use this within a bigger fun project.
*/
namespace BrainF_Interpreter_21_06_17
{
    class Interpreter
    {

        private int Pointer { get; set; }
        private bool e { get; set; }
        private int[] Buffer { get; set; }
        public const int BUFFERSIZE = 65535;

        public Interpreter()
        {
            Pointer = 0;
            Buffer = new int[BUFFERSIZE];//cuz binary
        }

        public void Interpret(string s)
        {
            int counter = 0;
            int leng = s.Length;

            while (counter < leng)
            {
                //Go thorught the "Code"
                switch (s[counter])
                {
                    case '>':
                        Pointer++;
                        if (Pointer >= BUFFERSIZE)
                            Pointer = 0;
                        break;

                    case '<':
                        Pointer--;
                        if (Pointer < 0)
                            Pointer = BUFFERSIZE - 1;
                        break;

                    case '-':
                        Buffer[Pointer]--;
                        break;

                    case '+':
                        Buffer[Pointer]++;
                        break;

                    case '[':
                        if (Buffer[Pointer] == 0)
                        {
                            int lp = 1;
                            while (lp > 0)
                            {
                                counter++;
                                char current = s[counter];
                                if (current == '[')
                                {
                                    lp++;
                                }
                                else if (current == ']')
                                {
                                    lp--;
                                }
                            }
                        }
                        break;

                    case ']':

                        int l = 1;
                        while (l > 0)
                        {
                            counter--;
                            char current = s[counter];
                            if (current == '[')
                            {
                                l--;
                            }
                            else if (current == ']')
                            {
                                l++;
                            }
                        }
                        counter--;
                        break;


                    case '.':
                        Console.Write((char)Buffer[Pointer]);
                        break;

                    case ',':
                        ConsoleKeyInfo k = Console.ReadKey(e);
                        Buffer[Pointer] = (int)k.KeyChar;
                        break;
                }

                counter++;
            }

        }

        public void reset()
        {
            Array.Clear(Buffer, 0, Buffer.Length);
        }

        public void start()
        {
            Console.WriteLine("Enter Code to Interpret");
            string input = Console.ReadLine();

            this.Interpret(input);
        }



    }
}
