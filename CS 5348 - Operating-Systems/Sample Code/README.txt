
CriticalSectionBroken.java
  This is the original version with no synchronization and the messages are 
  interleaved. The important thing to notice is that there are N object each 
  of which are concurrently printing their message to the shared 
  OutputStream (stdout). 
 
CriticalSectionFailedSynchronize.java
  This version attempts to build the critical section by synchronizing the
  printMessage method and fails because each instance is being synchronized
  and NOT a global lock. 
 
CriticalSectionMonitor.java
  This version uses a single, global Object (monitor) to lock the
  critical section across all StreamPrinter objects.
  
CriticalSectionSemaphore.java
  This version uses a single, global Semaphore to lock the
  critical section across all StreamPrinter objects. 
 
CriticalSectionSynchronizedBlock.java
  This version uses a single, global Object to create a 
  synchronized block to lock the critical section across 
  all StreamPrinter objects. 