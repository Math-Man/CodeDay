package tc.core;

import javafx.scene.input.KeyCode;
import processing.core.PApplet;

public class AppletMain  extends PApplet 
{
	
	public void settings()
	{
		size(512,512);
    } 

	int[][] ints;
	final int SHIFT_AMOUNT = 5;
	int OFFSETX = 0;
	int OFFSETY = 0;
	
    public void setup()
    {
    	ints = new int[1024][1024];
    	for(int i = 0; i < 1024; i++) 
    	{
    		for(int j = 0 ; j < 1024; j++) 
    		{
    			ints[j][i] = color(random(0,255));
    			set(j, i, ints[j][i]);
    		}
    	}
    }

    public void draw()
    {
    	
    }

    public void keyPressed()
    {
    	if(KeyCode.UP.getCode() == this.keyCode) 
    	{
    		drawitems(OFFSETX, OFFSETY - SHIFT_AMOUNT);
    	}
    	else if(KeyCode.DOWN.getCode() == this.keyCode) 
    	{
    		drawitems(OFFSETX, OFFSETY + SHIFT_AMOUNT);
    	}
    	else if(KeyCode.LEFT.getCode() == this.keyCode) 
    	{
    		drawitems(OFFSETX - SHIFT_AMOUNT, OFFSETY);
    	}
    	else if(KeyCode.RIGHT.getCode() == this.keyCode) 
    	{
    		drawitems(OFFSETX + SHIFT_AMOUNT, OFFSETY);
    	}
	}
    
    
    public void drawitems(int offsetX, int offsetY) 
    {
    	try 
    	{
    	for(int i = 0; i < height; i++) 
    	{
    		for(int j = 0 ; j < width; j++) 
    		{
    			set(j, i, ints[j + OFFSETX + offsetX][i + OFFSETY + offsetY]);  
    		}
    	}
    	OFFSETX = offsetX ;
		OFFSETY = offsetY ;
    	}
    	catch(Exception e) 
    	{
    		
    	}
    }
    
}
