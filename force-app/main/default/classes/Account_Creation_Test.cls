@isTest
public class Account_Creation_Test {
      @isTest
    public static void Account_Test(){
        Account acc=new Account();
        acc.Name='Test';
        insert acc;
        Test.startTest();
        Account_Creation.CreateNewAccRec();
        System.assertEquals('Test', acc.Name, 'Test pass successfully');
        Test.stopTest();
       
    }
}