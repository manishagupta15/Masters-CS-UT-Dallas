package factoryPattern;
import java.util.Scanner;

public class OldEnemyShipTesting {

	public static void main(String[] args){

		EnemyShip theEnemy = null;
		
		String enemyShipOption = "";
		
		// Old way of creating objects
		// When we use new we are not being dynamic
		 
		Scanner userInput = new Scanner(System.in);
		
		System.out.print("What type of ship? (U / R / B)");
		
		if (userInput.hasNextLine()){
			
			enemyShipOption = userInput.nextLine();
		
		}
		
		if(enemyShipOption.equals("U")){
			
			theEnemy  = new UFOEnemyShip();
			
		} else if (enemyShipOption.equals("R")){
			
			theEnemy  = new RocketEnemyShip();
		} else {
			
			theEnemy = new BigUFOEnemyShip();
			
		}
		
		doStuffEnemy(theEnemy);
		
		System.out.print("\n");
		

		
		
	}
	
	// Executes methods of the super class
	
	public static void doStuffEnemy(EnemyShip anEnemyShip){
		
		anEnemyShip.displayEnemyShip();
		
		anEnemyShip.followHeroShip();
		
		anEnemyShip.enemyShipShoots();
		
	}
	
}
