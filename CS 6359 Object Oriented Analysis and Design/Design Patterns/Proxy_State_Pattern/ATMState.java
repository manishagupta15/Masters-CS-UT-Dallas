package Proxy_State_Pattern;

public interface ATMState {
	
	void insertCard();
	void ejectCard();
	void insertPin(int pinEntered);
	void requestCash(int cashToWithdraw);
	
}
