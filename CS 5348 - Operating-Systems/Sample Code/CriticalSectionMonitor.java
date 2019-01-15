package criticalSection;


/**
 * Comment Removed for Assessment Question
 */
public class CriticalSectionMonitor
{
	static String message = "Now Is The Time For All Good Men\n";
	static int numThreads = 200;
	
	static Object monitor = new Object();

	public static void main(String args[])
	{
		for (int idx = 0; idx < numThreads; idx++) {
			Thread t = new Thread(new StreamPrinter());
			t.start();
		}
		
		// Needed to start / unblock the first waiting thread. 
		synchronized(monitor) {
			monitor.notify();
		}
	}

	static class StreamPrinter implements Runnable
	{
		@Override
		public void run()
		{
			try {
				while (true) {
					byte chars[] = message.getBytes();
					
					synchronized(monitor) {  // Start Critical Section
						monitor.wait();
					}
					
					for (int idx = 0; idx < chars.length; idx++) {
						byte achar = chars[idx];
						System.out.write((char) achar);
						Thread.yield();
					}
					
					synchronized(monitor) { // End Critical Section
						monitor.notify();
					}
				}
			}
			catch (InterruptedException ex) {
				System.err.println(ex.getLocalizedMessage());
			}
		}
	}
}