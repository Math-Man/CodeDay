using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace OilPaintEffect
{
    class OilEffect
    {

        private Bitmap baseMap { get; set; }
        public Image baseImage { get; set; }
        public Bitmap finalMap { get; set; }
        public int Range { get; set; }
        public double Intensity { get; set; }
        private int Width { get; set; }
        private int Height { get; set; }


        public OilEffect(Image img, int range, double Intesity)
        {

            this.Range = range;
            this.Intensity = Intensity;
            baseImage = img;
            this.Width = baseImage.Width;
            this.Height = baseImage.Height;
            baseMap = (Bitmap)baseImage;

            finalMap = new Bitmap(baseMap); //this is done to copy dimensions to the finalMap

        }



        public void genEffect()
        {
            //Go through each pixel
            for (int y = 0; y < Height; y++)
            {
                for (int x = 0; x < Width; x++)
                {
                    //Save the base color of the pixel in question
                    Color baseColor = baseMap.GetPixel(x, y);
                    int rAvg = 0, gAvg = 0, bAvg = 0;

                    //find the pixels "in range" of our pixel
                    //scans the pixels in range  and calculate the avarage colour and intesnity of these pixels
                    //Intensity is the forced distance of the avarage colour to the base color (its a % value, %50 would cause colors to be in the middle)
                    for (int yRange = y - Range; yRange < y + Range; yRange++)
                    {
                        for (int xRange = x - Range; xRange < x + Range; xRange++)
                        {



                            if (xRange > Width - 1 || xRange < 0 || yRange > Height - 1 || yRange < 0) //|| (xRange == Width && yRange == Height)
                            {
                                
                            }
                            else
                            {
                                //count up the sum of all colours in the range
                                Color c = baseMap.GetPixel(xRange, yRange);
                                rAvg += c.R;
                                gAvg += c.G;
                                bAvg += c.B;

                            }
                        }
                    }

                    //Calculate the avarage sum of the colors within the range. (This is done for each pixel)
                    rAvg = rAvg / (Range * Range);
                    gAvg = gAvg / (Range * Range);
                    bAvg = bAvg / (Range * Range);

                    /*
                    //Calculate intensity (difference in colour)
                    Color avarageColor = Color.FromArgb(rAvg, gAvg, bAvg);

                    int redDistance = (int)(Math.Sqrt((rAvg - baseColor.R) * (rAvg - baseColor.R)));
                    int greenDistance = (int)(Math.Sqrt((gAvg - baseColor.G) * (gAvg - baseColor.G)));
                    int blueDistance = (int)(Math.Sqrt((bAvg - baseColor.B) * (bAvg - baseColor.B)));
                    */


                    //Simple lerp:
                    //Calculates the intesity for each color then turns it into a color
                    //TODO: add a way to choose different intesities for every color
                    int intesityR = (int)(baseColor.R * Intensity + rAvg * (1 - Intensity)) / 255;
                    int intesityG = (int)(baseColor.G * Intensity + rAvg * (1 - Intensity)) / 255;
                    int intesityB = (int)(baseColor.B * Intensity + rAvg * (1 - Intensity)) / 255;

                    Color iColor = Color.FromArgb(intesityR, intesityG, intesityB);
                    
                    //Set the color on the final map
                    finalMap.SetPixel(x, y, iColor);

                }
            }
        }
    }
}
