//class for a button
public class SimonButton {
	int colour[];
	int xOrigin, yOrigin;
	int width, height;
	int buttonID;

	//animates the alternate animation for the button (e.g. a glow)
	boolean altAnim = false;

	//constructor
	public SimonButton(){
		
		colour = new int[]{120, 120, 120, 100};
		buttonID = 0;
	}

	public SimonButton(int x, int y, int w, int h, int c[], int id){
		xOrigin = x; 
		yOrigin = y;
		width = w;
		height = h;
		colour = c;
		buttonID = id;
	}

	public SimonButton(int x, int y, int w, int h,int r, int g, int b, int a, int id){
		xOrigin = x; 
		yOrigin = y;
		width = w;
		height = h;
		colour = new int[] {r, g, b, a};
		/*colour[0] = r;
		colour[1] = g;
		colour[2] = b;
		colour[3] = a;//= {r, g, b, a};*/
		buttonID = id;
	}


	//flip to the animation state
	public void setAnimFlag(){
		altAnim = !altAnim;
	}

	public void setAnimFlag(boolean f){
		altAnim = f;
	}

	public boolean getAnimFlag(){
		return altAnim;
	}

	

	//draw the button
	public void drawButton(){	
		pushMatrix();
		noStroke();
		//fill(colour[0], colour[1], colour[2], colour[3]);

		if (altAnim){
			fill(colour[0], colour[1], colour[2], colour[3]);
		}
		else{
			fill(203, 210, 223);
		}
		rect(xOrigin, yOrigin, width, height, 20);
		popMatrix();
	}

	public void animateButton(){
		//if (altAnim){
			//do the glow;
		pushMatrix();
		/*strokeWeight(40);
		stroke(colour[0], colour[1], colour[2], colour[3]);*/
			
			//noStroke();
		fill(colour[0], colour[1], colour[2], colour[3]);
		
		rect(xOrigin, yOrigin, width, height, 6);

		popMatrix();
		//fill(colour[0], colour[1], colour[2], colour[3]);
		//rect(xOrigin, yOrigin, width, height);
		//}
	}



	//bounds checking to see if the button is clicked
	//there's probably a library to check it more eaisly in processing but whatever
	public boolean isClicked(int x, int y){
		if (x >= xOrigin - width/2 && x <= xOrigin + width/2){
			if (y >= yOrigin - height/2 && y <= yOrigin + height/2){
				println("Button clicked at " + buttonID);
				return true;
			}
		}
		//println("false hitbox");
		return false;
	}


}