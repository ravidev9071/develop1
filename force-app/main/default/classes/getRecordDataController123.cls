public class getRecordDataController123 {
@AuraEnabled(cacheable=true)
  public static List<Account> getAccounts() {
  return [SELECT Id, Name, Phone FROM Account limit 10];
  }
}