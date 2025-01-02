public class TryAndCatchTestcoverageCheck {
    public static void Test(String accName){
        try{
            Account acc=new Account();
            acc.Name=accName;
           // insert acc;
        }
        catch(Exception e){
    System.debug('Exception is : ' + e.getMessage());
        }
    }
}