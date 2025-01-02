trigger MobileLencheck on Contact (after insert) {
    
    if(trigger.isAfter&&trigger.isInsert){
        
        Set<Id> accId=new Set<Id>();
        List<Id> conId=new List<Id>();
        
        for(Contact con:trigger.new){
            if(con.AccountId!=null){
                accId.add(con.AccountId);
                conId.add(con.id);
            }
            
        }
        List<ContentDocumentLink> conDocument = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :accId];
        //  System.debug(cdls);
        
        // List<Account> acclist=[Select Id from account where Id IN : accId];
        
        List<contact> conlist=[Select Id from contact where Id IN : conId];
        
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        
        cDocLink.ContentDocumentId = conDocument[0].ContentDocumentId;//Add ContentDocumentId
        
        cDocLink.LinkedEntityId = conId[0];//Add attachment parentId
        
        cDocLink.ShareType = 'V';//V – Viewer permission. C – Collaborator permission. I – Inferred permission.
        
       // cDocLink.Visibility = 'InternalUsers';//AllUsers, InternalUsers, SharedUsers
        
        Insert cDocLink;
        
    }   
    
    
}