trigger RestrictRecordCreationAndEdit on Account (before insert, before update) {
    // Define the required Permission Set name
    String requiredPermissionSet = 'KCS3';
    String requiredPermissionSet1 = 'KCS2';

    // Get the current user's Id
    Id currentUserId = UserInfo.getUserId();
   
    system.debug('currentUserId:::'+currentUserId);
    // Query the PermissionSetAssignment to check if the user has Permission Set 3
    List<PermissionSetAssignment> assignedPermissions = [
        SELECT PermissionSet.Name
        FROM PermissionSetAssignment
        WHERE AssigneeId = :currentUserId
    ];
    system.debug('assignedPermissions:::'+assignedPermissions);

    // Track if the user has the required permission set
    Boolean hasRequiredPermissionSet = false;
    for (PermissionSetAssignment psa : assignedPermissions) {
        if (psa.PermissionSet.Name == requiredPermissionSet || psa.PermissionSet.Name == requiredPermissionSet1) {
            System.debug('psa.PermissionSet.Name::'+psa.PermissionSet.Name);
            hasRequiredPermissionSet = true;
            break;
        }
    }

    // If the user does not have Permission Set 3, prevent the action
    if (!hasRequiredPermissionSet) {
        System.debug('arr::'+!hasRequiredPermissionSet);
        for (Account record : Trigger.new) {
                            System.debug('All:::'+record);

                            System.debug('type:::'+record.RecordType.DeveloperName);

            if (record.RecordTypeId == '012Ig000000XdZgIAK') {
            record.addError('You do not have the required permission to create or edit this record. Please contact your administrator.');
            }
        }
    }
}