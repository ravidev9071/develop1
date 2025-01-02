public class UpdateDataUsingStandardApi {
    @future(callout=true)
    public static void updateData(String accName,String ids){
        String Id=ids;
        String Name=accName;
        String jsonstr = '{"Name" : "' + Name + '"}';
        String token='';
        token=getAccessToken.getToken();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://umeshupadhyay-dev-ed.my.salesforce.com/services/data/v55.0/sobjects/Account/'+Id);
        request.setMethod('PATCH');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization','Bearer '+token);
        request.setBody(jsonstr);
        
        HttpResponse response = http.send(request);
        System.debug(response.getBody());  
    }
}