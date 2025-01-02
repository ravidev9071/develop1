public with sharing class lwcAppExampleApex {
 
    @AuraEnabled(cacheable=true)
    public static Map<ID, ContentDistribution> getRelatedFilesByRecordId(){       
        
        // List<Contact> contactList = [Select Id, FirstName, LastName, Email, Phone, Account.Name From Contact Where Account.Name=:keySearch];
        // return contactList;
        String recordIdSet='001Ig000003lgzhIAA';
         List<ID> docLinkIdList = new List<ID>();
                 Map<ID, String> mapIdTitle = new Map<ID, String>();
        Map<ID,ContentDistribution> mapContentDistribution=new Map<ID, ContentDistribution>(); 

        List<ContentDocumentLink> docLinkList = [SELECT ContentDocumentId,LinkedEntityId FROM ContentDocumentLink
                                                 WHERE LinkedEntityId =:recordIdSet]; 
                                                  
        for (ContentDocumentLink docLink : docLinkList) {
            docLinkIdList.add(docLink.ContentDocumentId);
        }        
         List<ContentVersion> contentVersionList = [SELECT ContentDocumentId, FileExtension, Title
                                     FROM ContentVersion WHERE ContentDocumentId IN : docLinkIdList ];

                                     for (ContentVersion contentVersionObj : contentVersionList) {
            mapIdTitle.put(contentVersionObj.ContentDocumentId, contentVersionObj.Title);
             List<ContentDistribution> contentDistList = [Select Id,Name, ContentDocumentId, ContentDownloadUrl, DistributionPublicUrl 
                                    from ContentDistribution 
                                    where ContentDocumentId IN : docLinkIdList ORDER BY CreatedDate ASC];
                                    System.debug('contentDistList::'+contentDistList);
                                    for(ContentDistribution contentDistObj:contentDistList){
            contentDistObj.Name=mapIdTitle.get(contentDistObj.ContentDocumentId);
            mapContentDistribution.put(contentDistObj.ContentDocumentId,contentDistObj);
        }

        
        }return mapContentDistribution;
    }
     @AuraEnabled(cacheable=true)
        public static Map<ID, String> getRelatedFilesByRecordId1(String recordId) {
            // Get record file IDs        
            List<ContentDocumentLink> files = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :recordId];
            List<ID> fileIDs = new List<ID>();
            for (ContentDocumentLink docLink : files) {
                fileIDs.add(docLink.ContentDocumentId);
            }
     
            List<ContentVersion> docs = [SELECT ContentDocumentId, FileExtension, Title 
                FROM ContentVersion WHERE ContentDocumentId IN : fileIDs];
            Map<ID, String> mapIdTitle = new Map<ID, String>();
            for (ContentVersion docLink : docs) {
                mapIdTitle.put(docLink.ContentDocumentId, docLink.Title);
            }
            return mapIdTitle;
        }
}