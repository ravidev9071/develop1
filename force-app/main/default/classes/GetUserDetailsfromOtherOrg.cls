public class GetUserDetailsfromOtherOrg {
    public static void GetUserData(){
        String token='';
        token=getAccessToken.getToken();
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setHeader('Authorization','Bearer '+token);
        req.setEndpoint('https://login.salesforce.com/services/oauth2/userinfo');
        HttpResponse response = h.send(req);
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        String email = (String)results.get('email');
        String name = (String)results.get('name');
        System.debug('Name:::-'+name+'  '+'Email:::-'+email);
        
    }
    
}