public class getAccessToken {
    public static String getToken(){
        String token='';
        UmeshOrgApi__mdt listEmailDomain = [SELECT client_id__c,grant_type__c,password__c,secret__c,username__c from UmeshOrgApi__mdt limit 1];
        String client_id=listEmailDomain.client_id__c;String secret=listEmailDomain.secret__c;String username=listEmailDomain.username__c;
        String password=listEmailDomain.password__c;String grant_type=listEmailDomain.grant_type__c; 
        String reqbody = 'grant_type=password&client_id='+client_id+'&client_secret='+secret+'&username='+username+'&password='+password ;
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        HttpResponse response = h.send(req);
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        token = (String)results.get('access_token');
        return token;
    }
}