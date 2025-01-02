public class AsyncExecutionExample implements Queueable{
    public void execute(QueueableContext context) {
        Account a = new Account(Name='SFDC',Phone='(415) 555-1212');
        insert a; 
                System.enqueueJob(new AnotherQueueableClass());

    }
}