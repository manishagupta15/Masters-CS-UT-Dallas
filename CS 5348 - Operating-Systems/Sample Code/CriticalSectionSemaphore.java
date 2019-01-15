package criticalSection;

import java.util.concurrent.Semaphore;

/**
 * Comment Removed for Assessment Question
 */
public class CriticalSectionSemaphore
{
	static String message = "Now Is The Time For All Good Men\n";
	static int numThreads = 200;

	public static void main(String args[])
	{
		for (int idx = 0; idx < numThreads; idx++) {
			Thread t = new Thread(new StreamPrinter());
			t.start();
		}
	}

	static class StreamPrinter implements Runnable
	{
		static Semaphore sema = new Semaphore(1);

		@Override
		public void run()
		{
			try {
				while (true) {
					byte chars[] = message.getBytes();
					sema.acquire();
					for (int idx = 0; idx < chars.length; idx++) {
						byte achar = chars[idx];
						System.out.write((char) achar);
						Thread.yield();
					}
					sema.release();
				}
			}
			catch (InterruptedException ex) {
				System.err.println(ex.getLocalizedMessage());
			}
		}
	}
}