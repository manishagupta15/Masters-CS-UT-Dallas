package criticalSection;

/**
 * Comment Removed for Assessment Question
 */
public class CriticalSectionSynchronizedBlock
{
	static String message = "Now Is The Time For All Good Men\n";
	static int numThreads = 200;
	
	static Integer lock = 1;

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
				byte chars[] = message.getBytes();
				synchronized (lock) {
					for (int idx = 0; idx < chars.length; idx++) {
						byte achar = chars[idx];
						System.out.write((char) achar);
						Thread.yield();
					}
				}
			}
		}
	}
}
