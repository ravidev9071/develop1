trigger IncrementSerialNo on Account (after insert) {

    if((trigger.isInsert)&&(trigger.isAfter)){
        
        System.debug(trigger.new);
        List<Account> accList=[select site from Account];
        List<account> accToupdate=new List<Account>();
        for(Account ac:[select Id,site from Account where Id In :trigger.new]){
            account ac1=new account(Id=ac.Id);
            ac1.Site=String.valueOf(accList.size());
            accToupdate.add(ac1);
        }   
        update accToupdate;
    }
    
}