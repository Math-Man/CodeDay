package tc.core;

import javafx.scene.input.KeyCode;
import processing.core.PApplet;

public class AppletMain  extends PApplet 
{
	

	int[][] ints;
	final int SHIFT_AMOUNT = 8;
	final double MOUSE_THRESHOLD = 0.05;
    final int WINDOWSIZE_X = 500;
    final int WINDOWSIZE_Y = 380;
    int BOARD_SIZE = 1000;
	int OFFSETX = 0;
	int OFFSETY = 0;
	
	
	public void settings()
	{
		size(WINDOWSIZE_X, WINDOWSIZE_Y);
		
		if(BOARD_SIZE < WINDOWSIZE_X ) 
		{
			BOARD_SIZE = WINDOWSIZE_X;
		}
		
		if(BOARD_SIZE < WINDOWSIZE_Y) 
		{
			BOARD_SIZE = WINDOWSIZE_Y;
		}
    } 

	
	
    public void setup()
    {
    	ints = new int[BOARD_SIZE][BOARD_SIZE];
    	for(int i = 0; i < BOARD_SIZE; i++) 
    	{
    		for(int j = 0 ; j < BOARD_SIZE; j++) 
    		{
    			ints[j][i] = color(random(0,255));
//    			set(j, i, ints[j][i]);
    		}
    	}
    }

    public void draw()
    {
    	background(255);
    	controlCheck();
    	drawitems();
    	
    	
    	stroke(255,0,0);
    	ellipse(width/2, height/2, 5, 5);
    	
    	
    }

    public void controlCheck()
    {
    	
    	
    	if((keyPressed && KeyCode.UP.getCode() == this.keyCode) || (mouseY < height * (MOUSE_THRESHOLD))) 
    	{
    		shiftItems(OFFSETX, OFFSETY - SHIFT_AMOUNT);
    	}
    	else if((keyPressed &&  KeyCode.DOWN.getCode() == this.keyCode) || (mouseY > height * (1 - MOUSE_THRESHOLD))) 
    	{
    		shiftItems(OFFSETX, OFFSETY + SHIFT_AMOUNT);
    	}
    	else if((keyPressed && KeyCode.LEFT.getCode() == this.keyCode) || (mouseX < height * (MOUSE_THRESHOLD))) 
    	{
    		shiftItems(OFFSETX - SHIFT_AMOUNT, OFFSETY);
    	}
    	else if((keyPressed && KeyCode.RIGHT.getCode() == this.keyCode) || (mouseX > height * (1 - MOUSE_THRESHOLD))) 
    	{
    		shiftItems(OFFSETX + SHIFT_AMOUNT, OFFSETY);
    	}
	}
    

    public void shiftItems(int offsetX, int offsetY) 
    {

    	if(!(offsetX < 0 || offsetX + width > BOARD_SIZE )) 
    	{
    		OFFSETX = offsetX ;
    	}
    	
    	if(!(offsetY < 0 || offsetY + height > BOARD_SIZE)) 
    	{
    		OFFSETY = offsetY ;
    	}

    }
    
    public void drawitems() 
    {
    	try 
    	{
	    	for(int i = 0; i < height; i++) 
	    	{
	    		for(int j = 0 ; j < width; j++) 
	    		{
	    			set(j, i, ints[j + OFFSETX][i + OFFSETY ]);  
	    		}
	    	}
    	}
    	catch(Exception e) 
    	{
    		
    	}
    }
    
}
