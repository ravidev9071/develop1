public class DeleteDatausingWebservices {
    public static void DeleteData(){
        String Id='0015g00001Ioq9TAAR';
        String token='';
        token=getAccessToken.getToken();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://umeshupadhyay-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+Id);
        request.setMethod('DELETE');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization','Bearer '+token);
        HttpResponse response = http.send(request);
        System.debug(response.getBody());  
    }
}