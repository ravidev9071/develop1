public class getDataGoogleDrive {
    @AuraEnabled
    public static List<object> GetdatafromDrive(){
      /*  String token=tkn;
        HttpRequest req1=new HttpRequest();
        req1.setEndpoint('https://www.googleapis.com/drive/v3/files?');
        req1.setMethod('GET');
        req1.setHeader('Authorization','Bearer '+token);
        Http http1=new Http();
        HttpResponse response1=new HttpResponse();
        response1=http1.send(req1);
        Map < String, Object > results1 = (Map < String, Object >) JSON.deserializeUntyped(response1.getBody());
        List<Object> dataTargetOrg = (List<Object>)results1.get('files');
        System.debug('files------'+dataTargetOrg);

        return dataTargetOrg;*/

        HttpRequest req1=new HttpRequest();
        req1.setEndpoint('callout:GoogleDriveName/files?');
        req1.setMethod('GET');
        Http http1=new Http();
        HttpResponse response1=new HttpResponse();
        response1=http1.send(req1);
        Map < String, Object > results1 = (Map < String, Object >) JSON.deserializeUntyped(response1.getBody());
        List<Object> dataTargetOrg = (List<Object>)results1.get('files');
        System.debug('files------'+dataTargetOrg);
        return dataTargetOrg;


    }
    @AuraEnabled
    public static string getAccessTokendrive(String authcode){
        System.debug(authcode);
        String  tokenUrl='https://accounts.google.com/o/oauth2/token';
        String code=authcode;
        String secert='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';
        String redirect_uri='https://ravidev2023-dev-ed--c.develop.vf.force.com/apex/vfpageexternalsite?core.apexpages.request.devconsole=1';
        String key=System.label.googlekey;
        HttpRequest req = new HttpRequest();
                req.setMethod('POST');
                req.setEndpoint(tokenUrl);
                req.setHeader('content-type', 'application/x-www-form-urlencoded');
                
                String messageBody ='code='+code+'&client_id='+key+
                    '&client_secret='+secert+
                    '&redirect_uri='+redirect_uri+
                    '&grant_type=authorization_code';
                req.setHeader('Content-length', String.valueOf(messageBody.length()));
                req.setBody(messageBody);
                req.setTimeout(60*1000);
                system.debug('messageBody:'+messageBody);
                
                Http callout = new Http();
                String responseText;
                HttpResponse response = callout.send(req);
                responseText = response.getBody();
                system.debug('responseText:'+responseText);
                Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(responseText) ;  
                String token =  String.valueOf(responseMap.get('access_token'));
                system.debug('token:'+token);
                return token;
    }

}