public class AnotherQueueableClass implements Queueable { 
    public void execute(QueueableContext context) {
       contact con=new Contact();
        con.lastName='Tst';
        insert con;
        
        
    }
}