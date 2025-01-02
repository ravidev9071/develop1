public class getDatausingWebservices {
    public static String Getdata(){
        String message='';
        String token='';
        token=getAccessToken.getToken();
        if(token!=null){
            HttpRequest req1=new HttpRequest();
            req1.setEndpoint('https://umeshupadhyay-dev-ed.my.salesforce.com/services/apexrest/Accounts/*');
            req1.setMethod('GET');
            req1.setHeader('Authorization','Bearer '+token);
            Http http1=new Http();
            HttpResponse response1=new HttpResponse();
            response1=http1.send(req1);
            List<Account> accinsertapi=new List<Account>();
            List<Object> listObj =new list<object>();
            if (response1.getStatusCode() == 200) {
                 List < Object > results1 = (List < Object >) JSON.deserializeUntyped(response1.getBody());
                for(object objnew:results1){
                    Map<String, Object> a2 = (Map<String, Object>)objnew;
                    Account acc=new Account();
                    acc.Name=String.valueOf(a2.get('Name'));
                    acc.Description=String.valueOf(a2.get('Id'));
                    accinsertapi.add(acc);
                }
                insert accinsertapi;
            }  
        }
        return 'Data have been successfully get using webservices';
    }
}