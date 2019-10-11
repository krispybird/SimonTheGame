//Make a simple game played with the mouse
//generates shapes along the screen that you have to click

//Is Simon
/*public static void main(String[] args){
	

}*/

//Part of the logic of the draw loop + mouse pressed/release was based off of Saxion-ACT's simon code -- especially in ironing out the bugs with timing and making sure that the 'glow' animation lights up when pressed
//https://github.com/SaxionACT-Art-and-Technology/Processing-Simon-Says

import java.util.ArrayList;

Simon simon;
boolean clickedButtonFlag = false;
boolean simonSays = true;	//keep a state machine here to keep track of when it is simon's turn
int timeDelay = 0;

boolean start = false;	//starting flag
boolean wrong = false;
boolean userWent = false;
int currentButtonSelected = -1; //the current button selected
int simonsPosition = 0; //position of how far along in the string of sequences the light is
PImage img;
final int FPS = 2;

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
	frameRate(FPS);

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
		
		if (millis() >= timer){
			simon.resetButtons();
		}




		if (simonSays){
			if (millis() - timer > 1000 && millis() - timer <= 1500){
				simon.resetButtons();
			}
			 if (millis() - timer >= 1000){
				simon.displaySimonSays();
				simonsTurn();
			}

			//simonsTurn();
			
			//Thread.sleep(1000);
			//simonSays = false;

		}
		else{
			//simon.resetButtons();
			/*if (millis() - timer >= 000){ 
				simon.displayYouSay();
				//yourTurn();
			}*/
			//yourTurn();
			

				simon.displayYouSay();
			
		}

		for (int i = 0; i < simon.buttons.size(); i++){
			simon.buttons.get(i).drawButton();
		}

	}	
}


void simonsTurn(){

	if (millis() >= timer){
		int currentLight = simon.counters[simonsPosition];
		simon.buttons.get(currentLight).setAnimFlag(true);
		println("Simon's position: " + simonsPosition);

		if (simonsPosition < simon.round){
			simonsPosition++;
			println("Advancing round: " + simonsPosition);
		}
		else{
			//if we finished, then advance
			simonSays = false;
			simonsPosition = 0;

			/*if (!wrong){
				simon.resetButtons();
			}*/
			timer = millis() + simon.turnDuration;
		}
	}
}

void yourTurn(){
	/*for (int i = 0; i < simon.buttons.size(); i++){
		simon.buttons.get(i).setAnimFlag(false);
	}*/
	println("Round " + simon.round + " lP" + simonsPosition);

}

void mousePressed(){
	if (!simonSays){
		for (int i = 0; i < simon.buttons.size(); i++){ 
			if (simon.buttons.get(i).isClicked(mouseX, mouseY)){
				println("Pressed: " + i);
				currentButtonSelected = i;
				simon.buttons.get(currentButtonSelected).setAnimFlag(true);
				simon.buttons.get(i).drawButton();
			}
		}
	}
}

void mouseReleased(){

	//starts the game
	if (start == false){
		start = true;
		return;
	}

	else if (!simonSays){
		//sets a wrong flag unless we did click the right button
		wrong = true;

		for (int i = 0; i < simon.buttons.size(); i++){

			//if selected
			if (simon.buttons.get(i).isClicked(mouseX, mouseY)){

				currentButtonSelected = i;
				simon.buttons.get(currentButtonSelected).setAnimFlag(true);


				if (simon.buttons.get(simon.counters[simonsPosition]).buttonID == currentButtonSelected){
					//good! advance 
					
					wrong = false;

					if (simonsPosition < simon.round){
						simonsPosition++;
					}

					else if (simonsPosition >= simon.round){
						simonSays = true;
						simonsPosition = 0;
						if (simon.round < simon.numRounds){
							simon.advanceRound();
						}
						simon.updateScore(1);
		
						timer = millis() + simon.turnDuration;

					}
				}


			}
		}

		if (wrong){
			simon.displayWrongMove();
			simonSays = true;
			simonsPosition = 0;
			simon.life--;
			simon.updateScore(-1);
			timer = millis() - simon.turnDuration;

		}
		
		/*else{
			
		}*/
	}
	
}

void light(){

	//delay(1000)
	delay(1000);
}
