//Simon functions and display 
//Most of the functions here are self explanatory
public class Simon{
	int score = 0;
	int life = 3;
	int round = 0; 

	//how long one turn lasts
	int turnDuration = 1000;


	//total rounds and buttons 
	int numRounds;
	int numButtons;

	boolean win = false;
	
	//ArrayList of all simon buttons
	ArrayList<SimonButton> buttons;

	//use this to advance the next round
	int counters[];

	//Constructor for initialization
	public Simon(){
		numButtons = 9;
		numRounds = 8;

		counters  = new int[numRounds];
		buttons = new ArrayList<SimonButton>();

		for (int i = 0; i < numRounds; i++){
			counters[i] = int(random(0, numButtons));
		}
	}


	//Constructor with params
	public Simon(int s, int l, int nb, int nr){	
		counters  = new int[numRounds];
		buttons = new ArrayList<SimonButton>();

		score = s;
		life = l;
		numButtons = nb;
		numRounds = nr;
		counters[round] = int(random(0, numButtons - 1));	
	}

	//Update the score. No negative integers
	public void updateScore(int s){	
		score += s;
		if (score < 0){
			score = 0;
		}
	}

	//Update life
	public void updateLife(int s){
		life -= s;
		if (life < 0){
			life = 0;
		}
	}

	//checks whether the player has any lives left
	public boolean checkLifeStatus(){
		if (life <= 0){
			return false;
		}
		return true;
	}

	//checks whether the player has won
	public boolean checkWinStatus(){
		if (checkLifeStatus()){
			if (round > numRounds - 1){
				win = true;
				return true;
			}
		}
		return false;
	}

	//Reset all animations to false
	public void resetButtons(){
		for (int i = 0; i < buttons.size(); i++){
			buttons.get(i).setAnimFlag(false);
		}
	}

	public void advanceRound(){
		round++;
	}

	//Stats for the player
	public void displayStats(){
		pushMatrix();
		textSize(32);
		fill(100, 200, 190);
		text("SIMON", width/2, 50);

		textSize(24);
		fill(255,215,0);
		if (round < 0){
			text("Round --" + " of " + numRounds, width/2, 80);
		}
		else if (round < numRounds){
			text("Round " + int(round+1) + " of " + numRounds, width/2, 80);
		}

		else if (round >= numRounds){
			text("Round " + int(round) + " of " + numRounds, width/2, 80);
		}
		
		text("Score: " + score, width/2, 110);
		text("Lives left: " + life, width/2, 140);
		popMatrix();
	}

	/*
	Displays win message, lose message, etc...self explanatory stuff
	*/
	public void displayWin(){
		textSize(40);
		fill(100, 200, 190);
		text("You win!", width/2, height - 60);
	}

	public void displayLose(){
		textSize(40);
		fill(100, 200, 190);
		text("You lost! Better luck next time!", width/2, height - 60);
	}

	public void displaySimonSays(){
		textSize(40);
		fill(100, 200, 190);
		text("Watch carefully...", width/2, height - 60);
	}

	public void displayYouSay(){
		textSize(40);
		fill(100, 200, 190);
		text("Copy Simon...", width/2, height - 60);	
	}

	public void displayWrongMove(){
		textSize(40);
		fill(255, 20, 10);
		text("Wrong! Try again...", width/2, height - 110);
	}

	public void displayStart(){
		textSize(40);
		fill(255,127,80);
		text("Click anywhere to start...", width/2, height - 60);
	}


}