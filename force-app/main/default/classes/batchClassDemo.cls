global class batchClassDemo implements Database.Batchable<SObject>, Database.Stateful {
    global Database.QueryLocator Start(Database.BatchableContext bc){
         String query = 'SELECT Id,Name FROM Account';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc,List<Account> acc){
        for(Account ac:acc){
            System.debug('test::'+ac);
        }
    }
    global void finish(Database.BatchableContext bc){
        
    }
  
}