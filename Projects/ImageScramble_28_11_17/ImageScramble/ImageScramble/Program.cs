using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


//https://www.reddit.com/r/dailyprogrammer/comments/78twyd/20171026_challenge_337_intermediate_scrambled/
//No Bonus.


namespace ImageScramble
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Select image! (1 - 4)");
            string t = Console.ReadLine();

            Image img = Bitmap.FromFile(@"C:\Users\MathMan\Documents\Visual Studio 2015\Projects\CodeEveryday\CodeDayNew\CodeDay\Projects\ImageScramble_28_11_17\ImageScramble\ImageScramble\Images\" + Int32.Parse(t) + @".png");
            Bitmap bm = new Bitmap(img, img.Width, img.Height);
            Bitmap rt = fixAll(bm, 0.5);
            rt.Save(@"C:\Users\MathMan\Documents\Visual Studio 2015\Projects\CodeEveryday\CodeDayNew\CodeDay\Projects\ImageScramble_28_11_17\ImageScramble\ImageScramble\Images\DONE" + Int32.Parse(t) + @".png");

            Console.WriteLine("Done!");
            Console.ReadKey();

        }


        //Fixes one line with given index
        public static void fixLine(Bitmap im, Bitmap ou, int index)
        {

            for (int j = 0; j < im.Width; j++)
            {
                for (int i = 0; i < im.Height; i++)
                {
                    // Console.WriteLine("Color: " + im.GetPixel(i,j));
                    //If the color is red
                    if (im.GetPixel(i, j).R == 255 && im.GetPixel(i, j).G == 0 && im.GetPixel(i, j).B == 0)
                    {
                        //Console.WriteLine("RED");
                        Color[] pixels = new Color[im.Width];

                        //Shift every other pixel until the right most red pixel is rightmost on the image
                        //Read pixels
                        for (int k = 0; k < im.Width; k++)
                        {
                            //Spooky math
                            pixels[k] = im.GetPixel((k + i) % im.Width, j);
                        }

                        //Draw pixels
                        for (int k = 0; k < im.Width; k++)
                        {
                            ou.SetPixel(k, j, pixels[k]);
                        }

                        break;
                    }




                }

            }
        }

        public static Bitmap fixAll(Image img, double compression)
        {
            if (compression < 0.5) { compression = 0.5; }
            int cX = (int)Math.Floor(img.Width * compression);
            int cY = (int)Math.Floor(img.Height * compression);

            Bitmap ou = new Bitmap(cX, cY);
            Bitmap im = new Bitmap(img, cX, cY);

            for (int i = 0; i < im.Height; i++)
            {
                Console.WriteLine(im.Width * i + " / " + im.Width * im.Height);

                fixLine(im, ou, i);
            }

            return ou;
        }



    }
}
