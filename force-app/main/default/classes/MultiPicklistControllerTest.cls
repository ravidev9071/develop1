@isTest
public class MultiPicklistControllerTest {
    
    @isTest
    static void testGetRecordNames() {
        // Create test data
        Service_Order_Template__c ser = new Service_Order_Template__c(Name = 'Test Service order template 1');
        Service_Order_Template__c ser1 = new Service_Order_Template__c(Name = 'Test Service order template 2');
        insert new List<Service_Order_Template__c> { ser, ser1 };
            
            // Call the method and assert
            List<Map<String, String>> result = MultiPicklistController.getRecordNames('Service_Order_Template__c');
        System.assertEquals(2, result.size());
        System.assert(result[0].containsKey('Id'));
        System.assert(result[0].containsKey('Name'));
    }
    
    @isTest
    static void testGetSelectedValues() {
        // Create test Knowledge__kav and related data
        Service_Order_Template__c serviceTemplate = new Service_Order_Template__c(Name = 'Service Template 1', Is_Active__c = true);
        insert serviceTemplate;
        
        Knowledge__kav knowledge = new Knowledge__kav(Title='Know 3',UrlName='Know-3',Service_Order_Templates__c = serviceTemplate.Id + ';Service Template 1');
        insert knowledge;
        
        // Call the method and assert
        List<Map<String, Object>> result = MultiPicklistController.getSelectedValues(knowledge.Id);
        System.assertEquals(1, result.size());
        System.assertEquals('Service Template 1', result[0].get('Name'));
        System.assertEquals('Active', result[0].get('IsActive'));
    }
    
    @isTest
    static void testSaveSelectedValues() {
        // Create test data
        Knowledge__kav knowledge = new Knowledge__kav(Title='Know 4',UrlName='Know-4');
        insert knowledge;
        
        List<Map<String, String>> selectedValues = new List<Map<String, String>> {
            new Map<String, String>{'Id' => 'testId1', 'Name' => 'Test Name 1'},
                new Map<String, String>{'Id' => 'testId2', 'Name' => 'Test Name 2'}
        };
            
            // Call the method
            MultiPicklistController.saveSelectedValues(knowledge.Id, selectedValues, true);
        
        // Query and assert
        knowledge = [SELECT Service_Order_Templates__c, MultiBoxShowHide__c FROM Knowledge__kav WHERE Id = :knowledge.Id];
        System.assertEquals('testId1;Test Name 1,testId2;Test Name 2', knowledge.Service_Order_Templates__c);
        System.assertEquals(true, knowledge.MultiBoxShowHide__c);
    }
    
    @isTest
    static void testEditSelectedValues() {
        // Create test data
        Knowledge__kav knowledge = new Knowledge__kav(Title='Know 5',UrlName='Know-5',MultiBoxShowHide__c = false);
        insert knowledge;
        
        // Call the method
        MultiPicklistController.EditSelectedValues(knowledge.Id, true);
        
        // Query and assert
        knowledge = [SELECT MultiBoxShowHide__c FROM Knowledge__kav WHERE Id = :knowledge.Id];
        System.assertEquals(true, knowledge.MultiBoxShowHide__c);
    }
    
    @isTest
    static void testGetBooleanField() {
        // Create test data
        Knowledge__kav knowledge = new Knowledge__kav(Title='Know 2',UrlName='Know-2',MultiBoxShowHide__c = true);
        insert knowledge;
        
        // Call the method and assert
        Boolean result = MultiPicklistController.getBooleanField(knowledge.Id);
        System.assertEquals(true, result);
    }
    
    @isTest
    static void testGetUserAccessLevel() {
         // Create mock admin profiles and permission sets
        String mockAdminProfiles = Label.AdminProfiles; // Example: 'System Administrator,Custom Admin'
        String mockFullAccessPermissionSets = Label.FullAccessPermissionSets; // Example: 'Full_Access_Set'

        // Split and store in sets
        Set<String> adminProfileSet = new Set<String>(mockAdminProfiles.split(','));
        Set<String> fullAccessPermissionSet = new Set<String>(mockFullAccessPermissionSets.split(','));

        // Create a test user
        Profile customProfile = [SELECT Id FROM Profile WHERE Name = 'Admin clone profile' LIMIT 1];
        User testUser = new User(
            LastName = 'Test',
            Email = 'testuser@example.com',
            Username = 'testuser' + System.currentTimeMillis() + '@example.com',
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = customProfile.Id,
            LanguageLocaleKey = 'en_US'
        );

        insert testUser;

        // Run test logic as the created user
        System.runAs(testUser) {
            // Verify the test user is inserted and fetch user details
            User currentUser = [SELECT Id, Profile.Name FROM User WHERE Id = :UserInfo.getUserId()];
            System.assertNotEquals(null, currentUser);

            // Check if the user's profile is in the mock admin set
            String profileName = currentUser.Profile.Name;
            Boolean isAdminProfile = adminProfileSet.contains(profileName);

            // Check if the user has any of the mocked full access permission sets
            Boolean hasFullAccessPermissionSet = false;
            List<PermissionSetAssignment> permissionSets = [SELECT PermissionSet.Name 
                                                            FROM PermissionSetAssignment 
                                                            WHERE AssigneeId = :currentUser.Id];
            for (PermissionSetAssignment psa : permissionSets) {
                if (fullAccessPermissionSet.contains(psa.PermissionSet.Name)) {
                    hasFullAccessPermissionSet = true;
                    break;
                }
            }

            // Determine the expected access level
            String expectedAccessLevel = isAdminProfile || hasFullAccessPermissionSet ? 'Full' : 'Read-Only';

            // Call the actual method
            String accessLevel = MultiPicklistController.getUserAccessLevel();

            // Assert the access level matches the expected value
            System.assertEquals(expectedAccessLevel, accessLevel);
        }
    }
    
}