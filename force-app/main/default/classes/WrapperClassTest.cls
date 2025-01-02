public with sharing class WrapperClassTest {
@AuraEnabled
    public static List<Account> getAccounts() {
    List<Account> accList=[Select Id,Name from Account limit 5];
    return accList;
    }
    @AuraEnabled
    public static void createAccount(String accName,String secName){
        
    System.debug('Account:::'+accName+' '+'Second:::'+secName);
    Account acc=new Account();
    acc.Name=accName;
    insert acc;
    }
}