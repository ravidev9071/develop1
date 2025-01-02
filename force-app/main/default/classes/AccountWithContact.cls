public with sharing class AccountWithContact {
    @AuraEnabled(cacheable=true)   
    public static List<Account> getAccountandContacts(){
    return [Select Id,Name,Phone,Type,Website,LastModifiedById,Rating from account];

     }
    @AuraEnabled(cacheable=true)   
    public static List<Contact> ShowContact(String accId){
    System.debug('Account Id::'+accId);

    return [Select Name,FirstName,LastName,Phone,Email,Description,LastModifiedById from Contact where AccountId=:accId];

    }

}