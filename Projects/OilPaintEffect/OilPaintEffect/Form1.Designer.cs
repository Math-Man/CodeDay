namespace OilPaintEffect
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.imageBox = new System.Windows.Forms.PictureBox();
            this.gbControls = new System.Windows.Forms.GroupBox();
            this.tbRange = new System.Windows.Forms.TrackBar();
            this.tbIntensity = new System.Windows.Forms.TrackBar();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.nIntensity = new System.Windows.Forms.NumericUpDown();
            this.nRange = new System.Windows.Forms.NumericUpDown();
            this.bLoadImage = new System.Windows.Forms.Button();
            this.bSave = new System.Windows.Forms.Button();
            this.bAbout = new System.Windows.Forms.Button();
            this.cbShowEffect = new System.Windows.Forms.CheckBox();
            this.bApply = new System.Windows.Forms.Button();
            this.ripBox = new System.Windows.Forms.RichTextBox();
            ((System.ComponentModel.ISupportInitialize)(this.imageBox)).BeginInit();
            this.gbControls.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tbRange)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tbIntensity)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nIntensity)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nRange)).BeginInit();
            this.SuspendLayout();
            // 
            // imageBox
            // 
            this.imageBox.BackColor = System.Drawing.SystemColors.ActiveBorder;
            this.imageBox.Location = new System.Drawing.Point(12, 12);
            this.imageBox.Name = "imageBox";
            this.imageBox.Size = new System.Drawing.Size(347, 324);
            this.imageBox.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.imageBox.TabIndex = 0;
            this.imageBox.TabStop = false;
            // 
            // gbControls
            // 
            this.gbControls.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.gbControls.Controls.Add(this.bApply);
            this.gbControls.Controls.Add(this.cbShowEffect);
            this.gbControls.Controls.Add(this.bAbout);
            this.gbControls.Controls.Add(this.bSave);
            this.gbControls.Controls.Add(this.bLoadImage);
            this.gbControls.Controls.Add(this.nRange);
            this.gbControls.Controls.Add(this.nIntensity);
            this.gbControls.Controls.Add(this.label2);
            this.gbControls.Controls.Add(this.label1);
            this.gbControls.Controls.Add(this.tbIntensity);
            this.gbControls.Controls.Add(this.tbRange);
            this.gbControls.Location = new System.Drawing.Point(12, 342);
            this.gbControls.Name = "gbControls";
            this.gbControls.Size = new System.Drawing.Size(347, 164);
            this.gbControls.TabIndex = 1;
            this.gbControls.TabStop = false;
            this.gbControls.Text = "Controls";
            // 
            // tbRange
            // 
            this.tbRange.Location = new System.Drawing.Point(60, 25);
            this.tbRange.Maximum = 16;
            this.tbRange.Name = "tbRange";
            this.tbRange.Size = new System.Drawing.Size(104, 45);
            this.tbRange.TabIndex = 0;
            this.tbRange.Value = 2;
            this.tbRange.Scroll += new System.EventHandler(this.tbRange_Scroll);
            // 
            // tbIntensity
            // 
            this.tbIntensity.Location = new System.Drawing.Point(60, 100);
            this.tbIntensity.Maximum = 100;
            this.tbIntensity.Minimum = 1;
            this.tbIntensity.Name = "tbIntensity";
            this.tbIntensity.Size = new System.Drawing.Size(104, 45);
            this.tbIntensity.TabIndex = 1;
            this.tbIntensity.Value = 50;
            this.tbIntensity.Scroll += new System.EventHandler(this.tbIntensity_Scroll);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(19, 34);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(39, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Range";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(19, 107);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(46, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Intensity";
            // 
            // nIntensity
            // 
            this.nIntensity.Location = new System.Drawing.Point(170, 100);
            this.nIntensity.Name = "nIntensity";
            this.nIntensity.Size = new System.Drawing.Size(42, 20);
            this.nIntensity.TabIndex = 4;
            this.nIntensity.Value = new decimal(new int[] {
            50,
            0,
            0,
            0});
            this.nIntensity.ValueChanged += new System.EventHandler(this.nIntensity_ValueChanged);
            // 
            // nRange
            // 
            this.nRange.Location = new System.Drawing.Point(170, 25);
            this.nRange.Name = "nRange";
            this.nRange.Size = new System.Drawing.Size(42, 20);
            this.nRange.TabIndex = 5;
            this.nRange.Value = new decimal(new int[] {
            2,
            0,
            0,
            0});
            this.nRange.ValueChanged += new System.EventHandler(this.nRange_ValueChanged);
            // 
            // bLoadImage
            // 
            this.bLoadImage.Location = new System.Drawing.Point(225, 22);
            this.bLoadImage.Name = "bLoadImage";
            this.bLoadImage.Size = new System.Drawing.Size(116, 23);
            this.bLoadImage.TabIndex = 6;
            this.bLoadImage.Text = "Select Image";
            this.bLoadImage.UseVisualStyleBackColor = true;
            this.bLoadImage.Click += new System.EventHandler(this.bLoadImage_Click);
            // 
            // bSave
            // 
            this.bSave.Enabled = false;
            this.bSave.Location = new System.Drawing.Point(225, 51);
            this.bSave.Name = "bSave";
            this.bSave.Size = new System.Drawing.Size(116, 23);
            this.bSave.TabIndex = 7;
            this.bSave.Text = "Save Image";
            this.bSave.UseVisualStyleBackColor = true;
            this.bSave.Click += new System.EventHandler(this.bSave_Click);
            // 
            // bAbout
            // 
            this.bAbout.Location = new System.Drawing.Point(225, 109);
            this.bAbout.Name = "bAbout";
            this.bAbout.Size = new System.Drawing.Size(116, 23);
            this.bAbout.TabIndex = 8;
            this.bAbout.Text = "About";
            this.bAbout.UseVisualStyleBackColor = true;
            this.bAbout.Click += new System.EventHandler(this.bAbout_Click);
            // 
            // cbShowEffect
            // 
            this.cbShowEffect.AutoSize = true;
            this.cbShowEffect.Location = new System.Drawing.Point(238, 141);
            this.cbShowEffect.Name = "cbShowEffect";
            this.cbShowEffect.Size = new System.Drawing.Size(84, 17);
            this.cbShowEffect.TabIndex = 9;
            this.cbShowEffect.Text = "Show Effect";
            this.cbShowEffect.UseVisualStyleBackColor = true;
            // 
            // bApply
            // 
            this.bApply.Location = new System.Drawing.Point(225, 80);
            this.bApply.Name = "bApply";
            this.bApply.Size = new System.Drawing.Size(116, 23);
            this.bApply.TabIndex = 10;
            this.bApply.Text = "Apply";
            this.bApply.UseVisualStyleBackColor = true;
            this.bApply.Click += new System.EventHandler(this.bApply_Click);
            // 
            // ripBox
            // 
            this.ripBox.Location = new System.Drawing.Point(12, 512);
            this.ripBox.Name = "ripBox";
            this.ripBox.Size = new System.Drawing.Size(341, 96);
            this.ripBox.TabIndex = 2;
            this.ripBox.Text = "";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(371, 613);
            this.Controls.Add(this.ripBox);
            this.Controls.Add(this.gbControls);
            this.Controls.Add(this.imageBox);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load_1);
            ((System.ComponentModel.ISupportInitialize)(this.imageBox)).EndInit();
            this.gbControls.ResumeLayout(false);
            this.gbControls.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tbRange)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tbIntensity)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nIntensity)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nRange)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.PictureBox imageBox;
        private System.Windows.Forms.GroupBox gbControls;
        private System.Windows.Forms.CheckBox cbShowEffect;
        private System.Windows.Forms.Button bAbout;
        private System.Windows.Forms.Button bSave;
        private System.Windows.Forms.Button bLoadImage;
        private System.Windows.Forms.NumericUpDown nRange;
        private System.Windows.Forms.NumericUpDown nIntensity;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TrackBar tbIntensity;
        private System.Windows.Forms.TrackBar tbRange;
        private System.Windows.Forms.Button bApply;
        private System.Windows.Forms.RichTextBox ripBox;
    }
}

