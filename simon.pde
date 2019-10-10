//keep track of state
public class Simon{
	int score = 0;
	int life = 3;
	int round = 0; 	//start at 0 and use this as a counter, but present it as round+1

	int turnDuration = 1000;


	//constants
	int numRounds;
	int numButtons;

	boolean win = false;
	
	//list of all simon buttons
	ArrayList<SimonButton> buttons;

	//use round -1 to keep track of where we are 
	//use this to advance the next round
	int counters[];


	//constructor for initializing the game simon
	public Simon(){
		numButtons = 4;
		numRounds = 5;

		counters  = new int[numRounds];
		buttons = new ArrayList<SimonButton>();

		for (int i = 0; i < numRounds; i++){
			counters[i] = int(random(0, numButtons - 1));
			println("Numbers: " + i + " " + counters[i]);

		}
	}


	//initialize by specifying some values
	public Simon(int s, int l, int nb, int nr){	
		counters  = new int[numRounds];
		buttons = new ArrayList<SimonButton>();

		score = s;
		life = l;
		numButtons = nb;
		numRounds = nr;
		counters[round] = int(random(0, numButtons - 1));	
	}


	public void updateScore(int s){
		score += s;
	}

	public void updateLife(int s){
		life -= s;
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
			if (round >= numRounds - 1){
				win = true;
				return true;
			}
		}
		return false;
	}

	public void resetButtons(){
		for (int i = 0; i < buttons.size(); i++){
			buttons.get(i).setAnimFlag(false);
		}
	}



	public void advanceRound(){
		//advance the round and generate a random number for the next button
		round++;
		//counters[round] = int(random(0, numButtons - 1));	

	}

	public void displayStats(){
		pushMatrix();
		textSize(32);
		fill(100, 200, 190);
		text("Simon", width/2, 50);

		textSize(24);
		fill(38, 160, 218);
		if (round < 0){
			text("Round --" + " of " + numRounds, width/2, 80);
		}
		else{
			text("Round " + int(round+1) + " of " + numRounds, width/2, 80);
		}
		
		text("Score: " + score, width/2, 110);
		text("Lives left: " + life, width/2, 140);
		popMatrix();
	}

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
		fill(100, 200, 190);
		text("Wrong! Try again...", width/2, height - 60);
	}

	public void displayStart(){
		textSize(40);
		fill(100, 200, 190);
		text("Click anywhere to start...", width/2, height - 60);
	}




}