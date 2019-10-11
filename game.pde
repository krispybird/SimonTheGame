
/*
IAT 806 - Assignment 7 - Make a game using OOP
Tiffany Wun
ID: 300407747

SIMON - Emoji version

+ About: This is a simple variant of "Simon" that uses the old Android emoji collection as buttons

+ Instructions: Use mouse to play. Watch for the icon changes, and beat all rounds to win! Aim for the highest score. Wrong clicks cost 1 life. The game is over when you lose all your lives.

+ Structure: This code has two classes: class SimonButton handles everything graphically related to the button, while class Simon stores most of the logic of the game. Several global variables are used to store states in the draw loop. 

Note that the FPS is slowed down to 2 frames/second -- any faster and you will miss the transitions easily

Part of the logic of the draw loop + mouse pressed/release was based off of Saxion-ACT's simon code -- especially in ironing out the bugs with timing and making sure that the 'on' animation lights up when pressed

https://github.com/SaxionACT-Art-and-Technology/Processing-Simon-Says


*/

import java.util.ArrayList;

//for ease of access I just kept most of the states here...could store it in class Simon alternatively
Simon simon;
PImage winScreen;

boolean simonSays = true; //keep a state machine here to keep track of when it is simon's turn

boolean start = false;	//flag to start new game flag
boolean wrong = false;	//keep track of whether user was wrong last turn

int currentButtonSelected = -1; //the current button selected by the user
int simonsPosition = 0; //position of how far along in the string of sequences the light is

int timer;	//generate a timer to add some timing between transitions and states
final int FPS = 2;	//fps -- KEEP THIS LOW so the player sees transitions


public void setup(){

	//setup
	size(1000, 1000);
	background(255);
	smooth();
	ellipseMode(RADIUS);
	rectMode(CENTER);
	textAlign(CENTER);
	imageMode(CENTER);
	frameRate(FPS);

	//simon class	
	simon = new Simon();

	//load some other stuff
	winScreen = loadImage("assets/winner.jpg");
	int dimensions = 150;
	int idCounter = 0;

	//generate buttons
	for (int i = 0; i < 3; i++){
		for (int j = 0; j < 3; j++){
			simon.buttons.add(new SimonButton((i+1) * width/4, (j+1) * height/4, dimensions, dimensions, idCounter));
			idCounter++;
		}
	}
}

/*
Using a state machine to keep track of where we are gameplay-wise
Logic is as follows:
+ Checking the start/win/lose conditions
+ If Simon's turn, run through sequence to display
+ Wait for user input
*/
public void draw(){

	clear();
	background(0, 191,255);
	simon.displayStats();

	//Go through start/win/lose conditions, yadda yadda...
	if (!start){
		simon.displayStart();
	}
	else if (simon.checkWinStatus() == true){
		simon.displayWin();
		image(winScreen, width/2, height/2);
	}
	else if (simon.checkLifeStatus() == false){
		simon.displayLose();
	}


	//The interesting part
	else{
		
		if (millis() >= timer){
			simon.resetButtons();
		}

		//Run through Simon's turn
		//The first condition is there to reset the alternate animation for half a second and then transition to the next one
		//The second condition is a timer that runs the animation for 1s intervals
		if (simonSays){
			if (millis() - timer > 1000 && millis() - timer <= 1500){
				simon.resetButtons();
			}
			 if (millis() - timer >= 1000){
				simon.displaySimonSays();
				simonsTurn();
			}
		}

		//User's turn -- this doesn't really do anything since most of the user input comes from mouse
		else{
			simon.displayYouSay();
		}

		//Draw the buttons
		for (int i = 0; i < simon.buttons.size(); i++){
			simon.buttons.get(i).drawButton();
		}

	}	
}

//If it's simon's turn
//Since the sequence of buttons for all of the game's rounds are generated already in Simon's constructor, this just iterates through that counter and displays 
//Uses a timer and a position counter (currentLight) 
void simonsTurn(){

	if (millis() >= timer){	
		//Set position of which button (currentLight) to animate
		int currentLight = simon.counters[simonsPosition];
		simon.buttons.get(currentLight).setAnimFlag(true);
		println("Simon's position: " + simonsPosition);

		//Advance to next button to animate up until the current round
		if (simonsPosition < simon.round){
			simonsPosition++;
			println("Advancing round: " + simonsPosition);
		}

		//reset the position of Simon's animation sequence that we finished walking through
		else{
			simonSays = false;
			simonsPosition = 0;
			timer = millis() + simon.turnDuration;
		}
	}
}

//Placeholder mainly
void yourTurn(){
	println("Your Turn");
}

//I split up most of the user logic similarly to saxion-ACT's version of Simon, since this allows for the animation to become more apparent when the user presses a button
//Checks if it is not Simon's turn, then animates pressed button
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

//Checks logic if it is the right button in the sequence that we pressed
void mouseReleased(){

	//Advances the game if we're at the start screen
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

				//advance if correct
				if (simon.buttons.get(simon.counters[simonsPosition]).buttonID == currentButtonSelected){
					
					wrong = false;

					if (simonsPosition < simon.round){
						simonsPosition++;
					}

					//resets position if we followed the entire sequence correctly and passes the turn back to Simon
					//Advances timer
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

		//If the user chose wrongly during the sequence, they must repeat the round
		//They also lose one life
		if (wrong){
			simon.displayWrongMove();
			simonSays = true;
			simonsPosition = 0;
			simon.life--;
			simon.updateScore(-1);
			timer = millis() - simon.turnDuration;
		}
	}	
}
