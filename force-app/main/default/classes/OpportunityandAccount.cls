public class OpportunityandAccount {
    public static void AddAmount(List<Opportunity> oppList){
        Set<Id> accId=new Set<Id>(); 
        for(Opportunity op:oppList){
            if(op.AccountId!=null){
                accId.add(op.AccountId);
            }
        }
        System.debug('Account Id on Opp  '+accId);
        List<Account> acclist=[select Id,NumberOfEmployees,(select Id,Amount,StageName from Opportunities) from Account where Id IN :accId];
        List<account> accupdate=new List<Account>();
        for(Account acc:acclist){
            acc.NumberOfEmployees=0;
            for(Opportunity op:acc.Opportunities){
                
                if(op.StageName=='Closed Won'){
                    system.debug('acha to ye tha');
                    if(acc.NumberOfEmployees==null){
                        acc.NumberOfEmployees=integer.valueOf(op.Amount);
                    }
                    else{
                        
                        acc.NumberOfEmployees+=integer.valueOf(op.Amount); 
                    }    
                }/*else if(op.StageName=='Closed Lost'){
                   
                    System.debug('Lost::'+op.Amount+'Lost:::'+acc.NumberOfEmployees);
                }*/
                
                
                
                
                
                
                
            }
            accupdate.add(acc);
        }
        
        update accupdate;
    }
}