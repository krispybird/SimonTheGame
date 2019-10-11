//Button class
//Contains most of the data needed to draw buttons and animate when necessary

public class SimonButton {

	int xOrigin, yOrigin;
	int buttonWidth, buttonHeight;
	int buttonID;
	PImage icon_default;
	PImage icon_alt;

	//animates the alternate animation for the button (e.g. a glow)
	boolean altAnim = false;

	//constructors
	public SimonButton(){
		buttonID = 0;
		icon_default = loadImage("assets/icon-neutral.png");
	}

	public SimonButton(int x, int y, int w, int h, int id){
		xOrigin = x; 
		yOrigin = y;
		buttonWidth = w;
		buttonHeight = h;
		buttonID = id;

		icon_default = loadImage("assets/icon-neutral.png");
		icon_alt = loadImage("assets/icon-alt-" + id + ".png");
	}


	//Gettters/setters to modify animation flag
	public void setAnimFlag(){
		altAnim = !altAnim;
	}

	public void setAnimFlag(boolean f){
		altAnim = f;
	}

	public boolean getAnimFlag(){
		return altAnim;
	}


	//draw the button or it's animated counterpart
	public void drawButton(){	
		pushMatrix();

		if (altAnim){
			image(icon_alt, xOrigin, yOrigin, buttonWidth, buttonHeight);
		}
		else{
			image(icon_default, xOrigin, yOrigin, buttonWidth, buttonHeight);
		}
		popMatrix();
	}

	//Do some bounds checking to see if we clicked this button
	public boolean isClicked(int x, int y){
		if (x >= xOrigin - buttonWidth/2 && x <= xOrigin + buttonWidth/2){
			if (y >= yOrigin - buttonHeight/2 && y <= yOrigin + buttonHeight/2){
				return true;
			}
		}
		return false;
	}

}