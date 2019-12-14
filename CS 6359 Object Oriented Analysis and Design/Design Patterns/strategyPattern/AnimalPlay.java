package strategyPattern;

public class AnimalPlay {

	public static void main(String[] args) {
		Animal sparky = new Dog();
		Animal tweety = new Bird();
		Animal kitty = new Cat();
		
		System.out.println("Dog: " + sparky.tryToFly());
		
		System.out.println("Bird: " + tweety.tryToFly());
		
		// This allows dynamic changes for flyingType
		
		sparky.setFlyingAbility(new ItFlys());
		
		System.out.println("Dog: " + sparky.tryToFly());
		kitty.setFlyingAbility(new CantFly());
		System.out.println("Cat: " + kitty.tryToFly());
		
	
	}

}
