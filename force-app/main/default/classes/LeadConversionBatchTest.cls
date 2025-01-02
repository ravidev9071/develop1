@isTest
public class LeadConversionBatchTest {
    @isTest
    static void testLeadConversionBatch() {
        List<String> accList = new List<String>{'001Ig000004vEjrIAE', '001Ig000004vEk1IAE','001Ig000004vEjsIAE'};
           Lead testLead1 = new Lead(
                FirstName = 'Test',
                LastName = 'Lead1',
                Company = 'Test Company',
                Possible_Matching_Account__c = accList[0],
                Status = 'Open - Not Contacted'
            );
         Lead testLead2 = new Lead(
            FirstName = 'Test',
            LastName = 'Lead2',
            Company = 'Test Company',
            Status = 'Open - Not Contacted'
        );
         insert new List<Lead> { testLead1, testLead2 };
        
        Test.startTest();
         LeadConversionBatch leadConversionBatch = new LeadConversionBatch();
         Database.executeBatch(leadConversionBatch, 10);
        Test.stopTest();
        List<Contact> contacts = [SELECT Id, RecordTypeId FROM Contact WHERE AccountId IN :accList];
        
        System.assertEquals(1, contacts.size());
        Contact convertedContact = contacts[0];
        
        RecordType contactRecordType = [SELECT Id FROM RecordType WHERE SObjectType = 'Contact' AND Name = 'Service' LIMIT 1];
        
        System.assertEquals(contactRecordType.Id, convertedContact.RecordTypeId);
        
        List<Lead> leads = [SELECT Id, IsConverted, ConvertedContactId FROM Lead WHERE Id = :testLead1.Id];
        System.assertEquals(1, leads.size());
        System.assert(leads[0].IsConverted);
        System.assertNotEquals(null, leads[0].ConvertedContactId);
    }
    
}