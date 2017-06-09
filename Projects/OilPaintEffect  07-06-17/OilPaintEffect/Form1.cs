using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace OilPaintEffect
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        Bitmap img = null;

        private void bLoadImage_Click(object sender, EventArgs e)
        {
            
            using (OpenFileDialog dlg = new OpenFileDialog())
            {
                dlg.Filter = "png files (*.png)|*.png";

                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    img = new Bitmap(dlg.FileName);
                    imageBox.Image = img;
                    bSave.Enabled = true;
                }
            }
        }

        private void bSave_Click(object sender, EventArgs e)
        {
            using (SaveFileDialog dlg = new SaveFileDialog())
            {
                dlg.Filter = "Images|*.png,*.bmp,*jpg";

                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    img.Save(dlg.FileName);
                }
            }
        }

        private void bAbout_Click(object sender, EventArgs e)
        {


            Form fAbout = new About();

            fAbout.Show();
            

        }

        private void tbRange_Scroll(object sender, EventArgs e)
        {
            nRange.Value = tbRange.Value;
        }

        private void nRange_ValueChanged(object sender, EventArgs e)
        {
            if (nRange.Value > tbRange.Maximum) nRange.Value = tbRange.Maximum;
            if (nRange.Value < tbRange.Minimum) nRange.Value = tbRange.Minimum;
            tbRange.Value = (int)nRange.Value;
        }

        private void tbIntensity_Scroll(object sender, EventArgs e)
        {
            nIntensity.Value = tbIntensity.Value;
        }

        private void nIntensity_ValueChanged(object sender, EventArgs e)
        {
            if (nIntensity.Value > tbIntensity.Maximum) nIntensity.Value = tbIntensity.Maximum;
            if (nIntensity.Value < tbIntensity.Minimum) nIntensity.Value = tbIntensity.Minimum;
            tbIntensity.Value = (int)nIntensity.Value;
        }

        private void bApply_Click(object sender, EventArgs e)
        {
            OilEffect oi = new OilPaintEffect.OilEffect(img, tbRange.Value, tbIntensity.Value/100);
            oi.genEffect();
            imageBox.Image = oi.finalMap;
        }


        //Shows Console
        [DllImport("kernel32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        static extern bool AllocConsole();

        private void Form1_Load_1(object sender, EventArgs e)
        {
            
        }

      
    }
}
