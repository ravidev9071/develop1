trigger AddEmialOnAccount on Contact (after insert,after update,before delete) {
    
    
    if((trigger.isAfter&&trigger.isInsert)||(trigger.isAfter&&trigger.isupdate)){
        Set<Id> accId=new Set<Id>();
        for(Contact c:trigger.new){
            if(c.Email!=null&&c.AccountId!=null)
            { accId.add(c.AccountId);}
        }
        
        List<Account> acclist=[select Id,Name,Description from Account where Id IN :accId];
        List<Account> acc=new list<Account>();
        for(Account ac :acclist){
            for(contact c:trigger.new){
                if(ac.Description==null){
                    ac.Description=c.Email;
                }else{
                    ac.Description=ac.Description+','+c.Email;
                }
            }acc.add(ac); 
            
        }
        if(!acc.isEmpty()&&acc.size()>0)
        {update acc;}
    }
    
    
    if(trigger.isbefore&&trigger.isDelete){
        
        //0:::a@gmail.com,b@gmail.com,c@gmail.com
        //a,b,c,d remove b
        //a,c,d
        Set<Id> accId=new Set<Id>();
        for(Contact c:trigger.old){
            if(c.Email!=null)
            { accId.add(c.AccountId);}
        }
        
        List<Account> acclist=[select Id,Name,Description from Account where Id IN :accId];
        List<Account> acc=new list<Account>();
        list<String> accDes=new List<String>();
        for(Account ad : acclist){
            for(Contact cd : trigger.old){
                accDes.add(ad.Description);
                
                String a=accDes[0].replaceAll(cd.Email+',', '');
                                System.debug('before remove-' + accDes[0]);

                System.debug('after remove-' + a);
                account a1=new Account();
                a1.Id=ad.Id;
                a1.Description=a;
                acc.add(a1);
            }
            //update ad;
            
        }
        update acc;
    }
    
    
}