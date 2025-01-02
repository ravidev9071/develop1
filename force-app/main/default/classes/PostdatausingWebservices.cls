public class PostdatausingWebservices {
    public static void Postdata(){
        String Name='RAVI KUMAR SINGH';
        String jsonstr = '{"name" : "' + Name + '"}';
        String token='';
        token=getAccessToken.getToken();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://umeshupadhyay-dev-ed.my.salesforce.com/services/apexrest/Accounts/*');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization','Bearer '+token);
        request.setBody(jsonstr);
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
    }
}