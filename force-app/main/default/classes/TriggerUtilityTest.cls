@isTest
public class TriggerUtilityTest {

    @isTest
    static void testEnableBypass() {
        // Create a new TriggerUtility__c custom setting
        TriggerUtility__c settings = new TriggerUtility__c();
        settings.Bypass_Validation_Rules__c = false;
        insert settings;

        // Call the enableBypass method
        System.Test.startTest();
        TriggerUtility.enableBypass();
        System.Test.stopTest();

        // Retrieve the custom setting after the method call
        TriggerUtility__c updatedSettings = [SELECT Id, Bypass_Validation_Rules__c FROM TriggerUtility__c LIMIT 1];

        // Assert that the Bypass_Validation_Rules__c field is set to true
        System.assertEquals(true, updatedSettings.Bypass_Validation_Rules__c, 'The Bypass_Validation_Rules__c field should be true after enableBypass is called.');
    }

    @isTest
    static void testDisableBypass() {
        // Create a new TriggerUtility__c custom setting
        TriggerUtility__c settings = new TriggerUtility__c();
        settings.Bypass_Validation_Rules__c = true;
        insert settings;

        // Call the disableBypass method
        System.Test.startTest();
        TriggerUtility.disableBypass();
        System.Test.stopTest();

        // Retrieve the custom setting after the method call
        TriggerUtility__c updatedSettings = [SELECT Id, Bypass_Validation_Rules__c FROM TriggerUtility__c LIMIT 1];

        // Assert that the Bypass_Validation_Rules__c field is set to false
        System.assertEquals(false, updatedSettings.Bypass_Validation_Rules__c, 'The Bypass_Validation_Rules__c field should be false after disableBypass is called.');
    }

    @isTest
    static void testCreateCustomSettingIfNotExist() {
        // Ensure no TriggerUtility__c custom setting exists before the test
        delete [SELECT Id FROM TriggerUtility__c];

        // Call the enableBypass method, which should create a new custom setting record if it doesn't exist
        System.Test.startTest();
        TriggerUtility.enableBypass();
        System.Test.stopTest();

        // Retrieve the custom setting after the method call
        TriggerUtility__c updatedSettings = [SELECT Id, Bypass_Validation_Rules__c FROM TriggerUtility__c LIMIT 1];

        // Assert that the custom setting was created and Bypass_Validation_Rules__c is set to true
        System.assertNotEquals(null, updatedSettings, 'A custom setting record should have been created.');
        System.assertEquals(true, updatedSettings.Bypass_Validation_Rules__c, 'The Bypass_Validation_Rules__c field should be true after enableBypass is called.');
    }
}