public class Account_Creation {
    public static void CreateNewAccRec(){
        
        Account acc=new Account();
        acc.Name='Monday Account Creation';
        insert acc;
        System.debug(acc);
        
    }
}