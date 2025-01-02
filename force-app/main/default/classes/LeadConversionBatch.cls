global class LeadConversionBatch implements Database.Batchable<SObject>, Database.Stateful {
   
    List<String> recordIds=new List<String>();
    global LeadConversionBatch() {
        recordIds = System.label.LeadConversionId.split(',');
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([
            SELECT Id, FirstName, LastName,Possible_Matching_Account__c,Country
            FROM Lead
            WHERE IsConverted = FALSE AND Possible_Matching_Account__r.Id IN : recordIds//AND Possible_Matching_Account__r.Name='JP morgan' //AND Id IN :recordIds
        ]);
    }
    
    global void execute(Database.BatchableContext BC, List<Lead> scope) {
        try{
            RecordType contactRecordType = [SELECT Id FROM RecordType WHERE SObjectType = 'Contact' AND Name = 'Service' LIMIT 1];
            List<Database.LeadConvert> leadConverts = new List<Database.LeadConvert>();
            LeadStatus convertStatus = [SELECT Id, ApiName FROM LeadStatus WHERE IsConverted=true LIMIT 1];
            
            for (Lead lead : scope) {
                if(lead.Possible_Matching_Account__c!=null){
                    Database.LeadConvert lc = new Database.LeadConvert();
                    lc.setLeadId(lead.Id);
                    lc.setAccountId(lead.Possible_Matching_Account__c);
                    lc.setConvertedStatus(convertStatus.ApiName);
                    lc.setDoNotCreateOpportunity(true);
                    leadConverts.add(lc);
                }
                
            }
            
            if (!leadConverts.isEmpty()) {
                List<Database.LeadConvertResult> results = Database.convertLead(leadConverts);
                List<Contact> contactsToUpdate = new List<Contact>();
                for (Database.LeadConvertResult result : results) {
                    if (result.isSuccess()) {
                        Contact convertedContact = [SELECT Id,MailingCountry FROM Contact WHERE Id = :result.getContactId()];
                        convertedContact.RecordTypeId = contactRecordType.Id;
                        contactsToUpdate.add(convertedContact);
                    }
                }
                
                if (!contactsToUpdate.isEmpty()) {
                    update contactsToUpdate;
                }
            }
        }
        catch(Exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
}