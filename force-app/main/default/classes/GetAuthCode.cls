public class GetAuthCode {
    @AuraEnabled
    public static String getCode(String Code){
        String code1=Code;
        String token='';
        String instance_url='';
        UmeshOrgApi__mdt listEmailDomain = [SELECT client_id__c,grant_type__c,password__c,secret__c,username__c,redirect_uri__c from UmeshOrgApi__mdt limit 1];
        String client_id=listEmailDomain.client_id__c;String secret=listEmailDomain.secret__c;String username=listEmailDomain.username__c;
        String password=listEmailDomain.password__c;String grant_type=listEmailDomain.grant_type__c; 
        String uri=listEmailDomain.redirect_uri__c;
        String reqbody = 'grant_type=authorization_code&client_id='+client_id+'&client_secret='+secret+'&redirect_uri='+uri+'&code='+code1 ;
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        HttpResponse response = h.send(req);
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        token = (String)results.get('access_token');
        instance_url = (String)results.get('instance_url');
        System.debug(token);
        System.debug('Done'+instance_url);
        return token;
   
    }
}