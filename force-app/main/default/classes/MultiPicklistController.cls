public with sharing class MultiPicklistController {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getRecordNames(String objectName) {
        List<Map<String, String>> recordDetails = new List<Map<String, String>>();
       // Order by Name in ascending (alphabetical) order
        String query = 'SELECT Id, Name FROM ' + objectName + ' ORDER BY Name ASC';
        List<SObject> records = Database.query(query);

        for (SObject record : records) {
            Map<String, String> recordMap = new Map<String, String>();
            recordMap.put('Id', (String)record.get('Id'));
            recordMap.put('Name', (String)record.get('Name'));
            recordDetails.add(recordMap);
            System.debug('Name:::'+(String)record.get('Name'));
        }   
        return recordDetails;
    }
    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getSelectedValues(Id recordId) {
    Account kn = [SELECT Service_Order_Templates__c, MultiBoxShowHide__c FROM Account WHERE Id = :recordId LIMIT 1];

    // Initialize the result list
    List<Map<String, Object>> selectedValues = new List<Map<String, Object>>();

    if (!String.isEmpty(kn.Service_Order_Templates__c)) {
        // Split the field to get individual records
        List<String> records = kn.Service_Order_Templates__c.split(',');

        // Extract IDs and Names from the records
        Map<Id, String> recordIdToStoredName = new Map<Id, String>();
        for (String record : records) {
            List<String> parts = record.split(';');
            if (parts.size() == 2) {
                recordIdToStoredName.put(Id.valueOf(parts[0]), parts[1]);
            }
        }

        // Query the database to find existing records and fetch their current Names
        Map<Id, Service_Order_Template__c> currentRecords = new Map<Id, Service_Order_Template__c>(
            [SELECT Id, Name,Is_Active__c FROM Service_Order_Template__c WHERE Id IN :recordIdToStoredName.keySet()]
        );

        // Iterate through the records and populate the selectedValues list
        for (Id recId : recordIdToStoredName.keySet()) {
            Map<String, Object> recordMap = new Map<String, Object>();
            String Name = recordIdToStoredName.get(recId);
            String currentName = currentRecords.containsKey(recId) ? currentRecords.get(recId).Name : null;
             Boolean isActive = currentRecords.containsKey(recId) ? currentRecords.get(recId).Is_Active__c : null;

            recordMap.put('Id', recId);
            recordMap.put('IsActive', isActive != null ? (isActive ? 'Active' : 'Inactive') : 'Unknown');
            recordMap.put('Name', Name);
            recordMap.put('UpdatedName', currentName);
            recordMap.put('Exists', currentRecords.containsKey(recId));
            recordMap.put('IsNameUpdated', currentName != null && !currentName.equals(Name)); // Compare names

            selectedValues.add(recordMap);
        }
    }

    return selectedValues;
   }
@AuraEnabled
    public static void saveSelectedValues(Id recordId, List<Map<String, String>> selectedValues,Boolean isActive) {
        Account kn = [SELECT Service_Order_Templates__c,MultiBoxShowHide__c FROM Account WHERE Id = :recordId LIMIT 1];
        List<String> records = new List<String>();
        List<String> recordName = new List<String>();
        for (Map<String, String> value : selectedValues) {
            records.add(value.get('Id') + ';' + value.get('Name'));
            recordName.add(value.get('Name'));

        }

        kn.Service_Order_Templates__c = String.join(records, ',');
        kn.Service_Order_Template_Names__c = String.join(recordName, ',');
        kn.IsLWCUpdate__c =true;
        kn.MultiBoxShowHide__c=isActive;
        update kn;
    }
   
    @AuraEnabled
    public static void EditSelectedValues(Id recordId ,Boolean isActive) {
        Account kn = [SELECT MultiBoxShowHide__c FROM Account WHERE Id = :recordId LIMIT 1];
        kn.MultiBoxShowHide__c=isActive;
        kn.IsLWCUpdate__c =true;
        update kn;
    }
     @AuraEnabled(cacheable=true)
    public static Boolean getBooleanField(Id recordId) {
        // Query the Boolean field
        Account obj = [SELECT MultiBoxShowHide__c FROM Account WHERE Id = :recordId LIMIT 1];
        return obj.MultiBoxShowHide__c;
    }
    
    @AuraEnabled(cacheable=true)
    public static String getUserAccessLevel() {
    // Get current user's ID
    Id userId = UserInfo.getUserId();
    // Retrieve profile names from Custom Label
    String adminProfiles = Label.AdminProfiles; // Comma-separated profile names
    Set<String> adminProfileSet = new Set<String>(adminProfiles.split(','));
       
    // Retrieve permission set names from Custom Label
    String fullAccessPermissionSets = Label.FullAccessPermissionSets; // Comma-separated permission set names
    Set<String> fullAccessPermissionSet = new Set<String>(fullAccessPermissionSets.split(','));
    // Check user's profile
    User currentUser = [SELECT Profile.Name FROM User WHERE Id = :userId LIMIT 1];
        
    String profileName = currentUser.Profile.Name;
    if (adminProfileSet.contains(profileName)) {
        return 'Full';
    }
  
    // Check user's permission sets
    List<PermissionSetAssignment> permissionSets = [SELECT PermissionSet.Name 
                                                     FROM PermissionSetAssignment 
                                                     WHERE AssigneeId = :userId];
    for (PermissionSetAssignment psa : permissionSets) {
        if (fullAccessPermissionSet.contains(psa.PermissionSet.Name)) {
            return 'Full';
        }
    }

    // Default access level
    return 'Read-Only';
   }

}