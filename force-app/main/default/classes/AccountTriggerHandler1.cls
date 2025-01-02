public class AccountTriggerHandler1 {
    public static void handleAfterUpdate(List<Account> newAccounts) {
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for (Account acc : newAccounts) {
            if (acc.IsLWCUpdate__c == true) {
                accountsToUpdate.add(new Account(Id = acc.Id, IsLWCUpdate__c = false));
            }
        }
        
        if (!accountsToUpdate.isEmpty()) {
            try {
                TriggerUtility.enableBypass(); // Enable bypass
                update accountsToUpdate;
            } catch (DmlException e) {
                System.debug('Error updating accounts: ' + e.getMessage());
            } finally {
                TriggerUtility.disableBypass(); // Disable bypass
            }
        }
    }
}