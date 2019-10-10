//Make a simple game played with the mouse
//generates shapes along the screen that you have to click

//Is Simon
/*public static void main(String[] args){
	

}*/

import java.util.ArrayList;

Simon simon;
boolean clickedButtonFlag = false;
boolean simonSays = true;	//keep a state machine here to keep track of when it is simon's turn
int timeDelay = 0;

boolean start = false;	//starting flag
boolean wrong = false;
boolean userWent = false;
int currentButtonSelected = -1; //the current button selected
int lightPosition = 0; //position of how far along in the string of sequences the light is
PImage img;


int startTime, timer;


//if the current button selected is equal to the button that is being pressed;



public void setup(){
	size(800, 800);
	//fullScreen();
	background(255);
	smooth();
	ellipseMode(RADIUS);
	rectMode(CENTER);
	textAlign(CENTER);
	imageMode(CENTER);

	simon = new Simon();

	simon.buttons.add(new SimonButton(width/2 - 90, height/2 - 90, 150, 150, 229, 93, 135, 100, 0));

	simon.buttons.add(new SimonButton(width/2 + 90, height/2 - 90, 150, 150, 244, 208, 63, 100, 1));

	
	simon.buttons.add(new SimonButton(width/2 - 90, height/2 + 90, 150, 150, 22, 160, 33, 100, 2));

	simon.buttons.add(new SimonButton(width/2 + 90, height/2 + 90, 150, 150, 95, 195, 228, 100, 3));

	startTime = millis();

	/*for (int i = 0; i < 4; i++){
		SimonButton b = new SimonButton(width/5 *i+1, (i % 2) * height/4 , 150, 150, 50*(i+1), 40*(i+1), 40*(i+1), 100, i);
		simon.buttons.add(b);
	}*/

}

//check if it is first win condition
//if not, check if it is simon's turn
//if your turn, wait until you 
public void draw(){
	//pulse then wait for user input
	//
	//if start or replied to, then animate and flash

	/*if (round == 1 || clickedButtonFlag == true){

		//wait for user input
	}*/
	clear();
	background(255);
	simon.displayStats();


	if (!start){
		simon.displayStart();
	}

	else if (simon.checkWinStatus() == true){
		simon.displayWin();
		img = loadImage("winner.jpg");
		image(img, width/2, height/2);
	}

	else if (simon.checkLifeStatus() == false){
		simon.displayLose();
	}

	else{
		


		
		

		if (simonSays){
			simon.displaySimonSays();
			if (millis() - timer >= 2000 && millis() - timer <= 3000){
				simon.resetButtons();
			}
			else if (millis() - timer >= 2000){
				
				simonsTurn();
			}

			//simonsTurn();
			
			//Thread.sleep(1000);
			//simonSays = false;

		}
		else{
			if (millis() - timer >= 1000){ 
				simon.displayYouSay();
				//yourTurn();
			}
			//yourTurn();
		}
		for (int i = 0; i < simon.buttons.size(); i++){
			simon.buttons.get(i).drawButton();
		}

	}
	
	



	
}

void simonsTurn(){
	
	//advance round if the user did not get the round wrong, otherwise repeat the current one
	println("Simon round" + simon.round);

	
	if (millis() >= timer){

		//issue is that it is continually advancing rounds 
		
		//if (millis() - timer >= 1000){
				
			//simon.buttons.get(simon.counters[lightPosition]).setAnimFlag(true);
			println("Lightpos: " + lightPosition + ", round: " +  simon.round);
			
				
			simon.buttons.get(simon.counters[lightPosition]).setAnimFlag(true);
			
			if (lightPosition < simon.round){
				lightPosition++;
			}
			else{
				//if we finished, then advance
				simonSays = false;
				/*simon.resetButtons();*/
				lightPosition = 0;

				if (!wrong){
					simon.resetButtons();
				}
			}
			timer = millis() + 100;	
	}

}

//check if this is the correct button that is clicked
//if not then reject, but avoid false clicks otherwise

void yourTurn(){
	/*for (int i = 0; i < simon.buttons.size(); i++){
		simon.buttons.get(i).setAnimFlag(false);
	}*/
	println("Round " + simon.round + " lP" + lightPosition);
}

void mousePressed(){
	if (!simonSays){
		simon.resetButtons();
	}
}

void mouseReleased(){

	//starts the game
	if (start == false){
		start = true;
		return;
	}

	if (!simonSays){
		//sets a wrong flag unless we did click the right button
		wrong = true;
		for (int i = 0; i < simon.buttons.size(); i++){
			if (simon.buttons.get(i).isClicked(mouseX, mouseY)){
				currentButtonSelected = i;

				if (simon.buttons.get(simon.counters[lightPosition]).buttonID == currentButtonSelected){
					//good! advance 
					simon.buttons.get(simon.counters[lightPosition]).setAnimFlag(true);
					wrong = false;
					if (lightPosition < simon.round){
						lightPosition++;
					}
					else{
						simonSays = true;
						lightPosition = 0;
					}
				}

			}
		}

		if (wrong){
			simon.displayWrongMove();
			simonSays = true;
			lightPosition = 0;
			simon.life--;
		}
		else{
			simon.advanceRound();
		}
	}
	
}

void light(){

	//delay(1000)
	delay(1000);
}
