global class BatchClassPratice implements Database.Batchable<sobject>   {
    
    public Database.QueryLocator Start(Database.BatchableContext jobId){
        String query = 'SELECT Id,Name FROM Account';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext jobId,List<Account> recordlist){
       
        Database.deleteResult[] srList = Database.delete(recordlist, false);

        //delete recordlist;
        
    }
    public void finish(Database.BatchableContext jobId){
        
        
    }
    
    
    
    
}