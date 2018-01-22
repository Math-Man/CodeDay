using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace RandomPolygon
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Draw_Click(object sender, EventArgs e)
        {
            Random rnd = new Random();

            Bitmap bm = drawRandomPolyAdvanced(120, 120, rnd.Next(60), rnd.Next(55), rnd.Next(60), rnd.Next(55));
            pictureBox1.Image = bm;
        }

        public static Bitmap drawRandomPolyAdvanced(int h, int k, int rx, int ry, int rx2, int ry2)
        {
            Random rnd = new Random();
            Bitmap bmp = new Bitmap(720, 720);
            Graphics g = Graphics.FromImage(bmp);
            Pen p = new Pen(Color.Red, 2);
            List<Point> points = new List<Point>();

            double step = 2 * Math.PI / 5;

            for (double angle = 0; angle < 2 * Math.PI; angle += step)
            {
                double x;
                double y;
                if (rnd.NextDouble() > 0.5)
                {
                    x = h + rx * Math.Cos(angle);
                    y = k - ry * Math.Sin(angle);
                }
                else
                {
                    x = h + rx2 * Math.Cos(angle);
                    y = k - ry2 * Math.Sin(angle);
                }

                points.Add(new Point((int)x, (int)y));
                step = 2 * Math.PI / rnd.Next(5, 20);
                if (angle + step > 2 * Math.PI)
                {
                    angle = 2 * Math.PI;
                }
            }

            g.DrawPolygon(p, points.ToArray());

            bmp.Save("out.png", ImageFormat.Png);
            return bmp;
        }
    }
}
