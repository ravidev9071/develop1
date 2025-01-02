public class PostdatausingStandardApi {
    @future(callout=true)
    public static void Send(String accName,String ids){
        String Name=accName;
        String jsonstr = '{"Name" : "' + Name + '"}';
        String token='';
        token=getAccessToken.getToken();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://umeshupadhyay-dev-ed.my.salesforce.com/services/data/v55.0/sobjects/Account/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization','Bearer '+token);
        request.setBody(jsonstr);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                         response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
            String result=response.getBody();
            Object fieldList = JSON.deserializeUntyped(result);   
            Map<String,Object> data = (Map<String,Object>)fieldList;
            system.debug(data.get('id'));
            List<Account> accUpdate=new List<Account>();
            for(Account ac:[select AccountNumber from account where Id = :ids])
            {
                ac.AccountNumber=String.valueOf(data.get('id'));
                AccountTriggerHandler.isFirstTime = false;
                
                accUpdate.add(ac);
            }
            update accUpdate;
        }
        
    }
}