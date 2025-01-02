@isTest
public class CreateAccountContactTest {
    public static Account createAccount(){
         Account acc = new Account(Name = 'Test Account',
                                   Fax = '123-456-7890',
                                   BillingStreet = '123 Test St',
                                   BillingCity = 'Test City',
                                   BillingState = 'Test State',
                                   BillingPostalCode = '12345',
                                   BillingCountry = 'Test Country',
                                   Phone = '987-654-3210');
        return acc;
    }
    
    // Test method to cover trigger functionality
    static testMethod void testCreateAccountContact() {
        
        // Create test data
        Account acc = CreateAccountContactTest.createAccount();
        insert acc;
        System.debug('Account Created :'+acc);
        // Query to check if contact is created
        List<Contact> contacts = [SELECT Id, LastName, AccountId, Fax, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, Phone 
                                  FROM Contact 
                                  WHERE AccountId = :acc.Id];
        System.debug('contacts::::'+contacts);
        
        // Assertion to check if contact is created with correct values
        System.assertEquals(1, contacts.size());
        Contact createdContact = contacts[0];
        System.assertEquals(acc.Name, createdContact.LastName);
        System.assertEquals(acc.Id, createdContact.AccountId);
        System.assertEquals(acc.Fax, createdContact.Fax);
        System.assertEquals(acc.BillingStreet, createdContact.MailingStreet);
        System.assertEquals(acc.BillingCity, createdContact.MailingCity);
        System.assertEquals(acc.BillingState, createdContact.MailingState);
        System.assertEquals(acc.BillingPostalCode, createdContact.MailingPostalCode);
        System.assertEquals(acc.BillingCountry, createdContact.MailingCountry);
        System.assertEquals(acc.Phone, createdContact.Phone);
    }
}
/*
@isTest
public class CreateAccountContactTest {

    // Test factory to create test data
    public class TestDataFactory {
        
        public static Account createTestAccount() {
            return new Account(Name = 'Test Account',
                               Fax = '123-456-7890',
                               BillingStreet = '123 Test St',
                               BillingCity = 'Test City',
                               BillingState = 'Test State',
                               BillingPostalCode = '12345',
                               BillingCountry = 'Test Country',
                               Phone = '987-654-3210');
        }
    }

    // Test method to cover trigger functionality
    static testMethod void testCreateAccountContact() {
        
        // Create test data using test factory
        Account acc = TestDataFactory.createTestAccount();
        insert acc;
        
        // Query to check if contact is created
        List<Contact> contacts = [SELECT Id, LastName, AccountId, Fax, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, Phone 
                                  FROM Contact 
                                  WHERE AccountId = :acc.Id];
        
        // Assertion to check if contact is created with correct values
        System.assertEquals(1, contacts.size());
        Contact createdContact = contacts[0];
        System.assertEquals(acc.Name, createdContact.LastName);
        System.assertEquals(acc.Id, createdContact.AccountId);
        System.assertEquals(acc.Fax, createdContact.Fax);
        System.assertEquals(acc.BillingStreet, createdContact.MailingStreet);
        System.assertEquals(acc.BillingCity, createdContact.MailingCity);
        System.assertEquals(acc.BillingState, createdContact.MailingState);
        System.assertEquals(acc.BillingPostalCode, createdContact.MailingPostalCode);
        System.assertEquals(acc.BillingCountry, createdContact.MailingCountry);
        System.assertEquals(acc.Phone, createdContact.Phone);
    }
}


*/