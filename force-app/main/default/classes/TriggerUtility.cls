public class TriggerUtility {
    public static void enableBypass() {
        TriggerUtility__c settings = TriggerUtility__c.getOrgDefaults();
        if (settings == null) {
            settings = new TriggerUtility__c();
        }
        settings.Bypass_Validation_Rules__c = true;
        upsert settings;
    }

    public static void disableBypass() {
        TriggerUtility__c settings = TriggerUtility__c.getOrgDefaults();
        if (settings == null) {
            settings = new TriggerUtility__c();
        }
        settings.Bypass_Validation_Rules__c = false;
        upsert settings;
    }
}