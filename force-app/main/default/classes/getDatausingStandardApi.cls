public class getDatausingStandardApi {
    public static String getData(){
        String token='';
        token=getAccessToken.getToken();
        if(token!=null){
            HttpRequest req1=new HttpRequest();
            req1.setEndpoint('https://umeshupadhyay-dev-ed.my.salesforce.com/services/data/v42.0/query/?q=SELECT+Name,Type+FROM+Account');
            req1.setMethod('GET');
            req1.setHeader('Authorization','Bearer '+token);
            Http http1=new Http();
            HttpResponse response1=new HttpResponse();
            response1=http1.send(req1);
            List<Account> accinsertapi=new List<Account>();
            List<Object> listObj =new list<object>();
            
            Map < String, Object > results1 = (Map < String, Object >) JSON.deserializeUntyped(response1.getBody());
            List<Object> dataTargetOrg = (List<Object>)results1.get('records');
            
            for(object data:dataTargetOrg){
                Map<String, Object> a2 = (Map<String, Object>)data;
                listObj.add(a2.get('Name'));
                Account acc=new account();
                acc.Name=String.valueOf(a2.get('Name'));
                acc.Type=String.valueOf(a2.get('Type'));
                accinsertapi.add(acc);
                //System.debug('---:::Account Name---:::: '+a2.get('Name')+'---::: Type   ---::::  '+a2.get('Type'));
            }
            insert accinsertapi;
        }
        return 'Data successfully get using standard api';
        
    }
}