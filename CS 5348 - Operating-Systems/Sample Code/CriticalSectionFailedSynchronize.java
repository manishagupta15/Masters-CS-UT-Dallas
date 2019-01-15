package criticalSection;

/**
 * Comment Removed for Assessment Question
 */
public class CriticalSectionFailedSynchronize
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
		@Override
		public void run()
		{
			while (true) {
				printMessage();
			}
		}

		private synchronized void printMessage()
		{
			byte chars[] = message.getBytes();
			for (int idx = 0; idx < chars.length; idx++) {
				byte achar = chars[idx];
				System.out.write((char) achar);
				Thread.yield();
			}
		}
	}
}
