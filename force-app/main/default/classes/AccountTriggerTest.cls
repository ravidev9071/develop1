@isTest
public class AccountTriggerTest {
    @isTest
    static void testWithoutTrigger() {
        // Disable the trigger
        TriggerControl.isTriggerDisabled = true;

        // Perform DML without triggering logic
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Validate that the trigger did not run
        Account insertedAccount = [SELECT Id, Description FROM Account WHERE Id = :acc.Id];
        System.assertEquals(null, insertedAccount.Description, 'Trigger logic should not have executed');
    }

    @isTest
    static void testWithTrigger() {
        // Enable the trigger (default behavior)
        TriggerControl.isTriggerDisabled = false;

        // Perform DML and trigger logic should execute
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Validate that the trigger ran
        Account insertedAccount = [SELECT Id, Description FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Updated by Trigger', insertedAccount.Description, 'Trigger logic should have executed');
    }
}