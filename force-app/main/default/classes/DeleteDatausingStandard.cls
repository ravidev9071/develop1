public class DeleteDatausingStandard {
    @future(callout=true)
    public static void DeleteData(String ids){
        String Id=ids;
        String token='';
        token=getAccessToken.getToken();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://umeshupadhyay-dev-ed.my.salesforce.com/services/data/v51.0/sobjects/Account/'+Id);
        request.setMethod('DELETE');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization','Bearer '+token);
        HttpResponse response = http.send(request);
        System.debug(response.getBody());  
    }
}