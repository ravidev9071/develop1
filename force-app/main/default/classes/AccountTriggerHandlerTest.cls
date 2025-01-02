@isTest
public class AccountTriggerHandlerTest {

    @isTest
    static void testHandleAfterUpdate() {
        // Create test account record
        Account testAccount = new Account(Name = 'Test Account', IsLWCUpdate__c = true);
        insert testAccount;

        // Update the test account
        testAccount.IsLWCUpdate__c = true;
        update testAccount;

        // Verify that the trigger handler's logic worked correctly
        testAccount = [SELECT Id, IsLWCUpdate__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(false, testAccount.IsLWCUpdate__c, 'IsLWCUpdate__c should be false after the update.');
    }
}