public class chatGPT {
    @AuraEnabled(cacheable=true)
    public static String chatGPTshowdata(String mydata){
        

        String Endpoint='https://api.openai.com/v1/chat/completions';  
        String key=System.label.keyinfo;  
        
        
        String jsonstr='{"model": "gpt-3.5-turbo","messages": [{"role": "user", "content": "'+mydata+'"}],"temperature": 0.7}';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(Endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization','Bearer '+key);
        request.setTimeout(120000);
        request.setBody(jsonstr);
        HttpResponse response = http.send(request);
        
        Map < String, Object > results1 = (Map < String, Object >) JSON.deserializeUntyped(response.getBody());
        List<Object> dataTargetOrg = (List<Object>)results1.get('choices');
        List<Object> msg=new list<Object>();
        for(object data:dataTargetOrg){
            Map<String, Object> a2 = (Map<String, Object>)data;
            msg.add(a2.get('message'));
             
        }
        String finaldata;
        String afterfinal;
         for(object data1:msg){
             Map<String, Object> a3 = (Map<String, Object>)data1;
            finaldata=String.valueOf(a3.get('content'));
            afterfinal=finaldata.replace('\n', '<br/>');

         }
        System.debug(finaldata);
        return finaldata;
    }
}