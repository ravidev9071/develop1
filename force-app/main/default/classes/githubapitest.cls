public with sharing class githubapitest {
    @AuraEnabled
    public static void createRep(String rname,String rdes,Boolean opt){
       // System.debug('Name:::'+rname+'Descrip:::'+rdes+'sfflafla'+opt);
        String endpoint='https://api.github.com/orgs/myAPI9071/repos';
        String token=System.label.gitapitest;
        String body='{"name":'+'"'+rname +'"'+','+'"description":'+'"'+rdes+'"'+','+'"private":'+''+opt+'}';
        //System.debug(body);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization','Bearer '+token);
        request.setBody(body);
        HttpResponse response = http.send(request);
       //System.debug('response'+response);
    }
    @AuraEnabled
    public static void UpdateRep(String rname,String rdes,Boolean opt,String dele){
        String endpoint='https://api.github.com/repos/'+dele;
        String token=System.label.gitapitest;
        String body='{"name":'+'"'+rname +'"'+','+'"description":'+'"'+rdes+'"'+','+'"private":'+''+opt+'}';
       // System.debug(body);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('PATCH');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization','Bearer '+token);
        request.setBody(body);
        HttpResponse response = http.send(request);

    }

//....................................................................................
   @AuraEnabled(cacheable=true)
    public static List<String> getPathNameMethod(){

        String endpoint='https://api.github.com/repos/myAPI9071/My-all-data-here/git/trees/master?recursive=1';
        String token=System.label.gitapitest;
        HttpRequest req1=new HttpRequest();
        req1.setEndpoint(endpoint);
        req1.setMethod('GET');
        req1.setHeader('Authorization','Bearer '+token);
        Http http1=new Http();
        HttpResponse response1=new HttpResponse();
        response1=http1.send(req1);
        List<String> listObj =new list<String>();

        Map < String, Object > results1 = (Map < String, Object >) JSON.deserializeUntyped(response1.getBody());
        List<Object> dataTargetOrg = (List<Object>)results1.get('tree');
        for(object data:dataTargetOrg){
            Map<String, Object> a2 = (Map<String, Object>)data;
            listObj.add(String.valueOf(a2.get('path')));
           
       
        }
        System.debug(listObj);
    return listObj;
        
    }    
    
    
        
//.........................................................................................

@AuraEnabled
public static String getContent(String path){
    String endpoint='https://api.github.com/repos/myAPI9071/My-all-data-here/contents/'+path;
    String token=System.label.gitapitest;
    HttpRequest req1=new HttpRequest();
    req1.setEndpoint(endpoint);
    req1.setMethod('GET');
    req1.setHeader('Authorization','Bearer '+token);
    Http http1=new Http();
    HttpResponse response1=new HttpResponse();
    response1=http1.send(req1);
    List<String> listObj =new list<String>();

    String result=response1.getBody();
            Object fieldList = JSON.deserializeUntyped(result);   
            Map<String,Object> data = (Map<String,Object>)fieldList;
            String base64Content=String.valueOf(data.get('content'));
            Blob blobContent = EncodingUtil.base64Decode( base64Content );
            
           String final12= blobContent.toString();
    
    return final12;
}







    @AuraEnabled
    public static void DeleteRepo(String deleterep){
    String endpoint='https://api.github.com/repos/'+deleterep;
    String token=System.label.gitapitest;
    HttpRequest req1=new HttpRequest();
    req1.setEndpoint(endpoint);
    req1.setMethod('DELETE');
    req1.setHeader('Authorization','Bearer '+token);
    Http http1=new Http();
    HttpResponse response1=new HttpResponse();
    response1=http1.send(req1);
   // System.debug('Github data:::'+response1.getBody());
    }



    @AuraEnabled(cacheable=true)
    public static List<githubapitest.wrapper> Getgithub(){

        String endpoint='https://api.github.com/orgs/myAPI9071/repos';
        String token=System.label.gitapitest;
        HttpRequest req1=new HttpRequest();
        req1.setEndpoint(endpoint);
        req1.setMethod('GET');
        req1.setHeader('Authorization','Bearer '+token);
        Http http1=new Http();
        HttpResponse response1=new HttpResponse();
        response1=http1.send(req1);
        //System.debug('Github data:::'+response1.getBody());
 
    list<githubhandledata.test> res=(list<githubhandledata.test>)JSON.deserialize(response1.getBody(), list<githubhandledata.test>.class);

        List<wrapper> wrapperlist=new List<wrapper>();
        //System.debug('res data:::'+res);
        for(githubhandledata.test a:res){
        wrapper wpr =new wrapper();
            wpr.id=a.id;
            wpr.name=a.name;
            wpr.description=a.description;
            wpr.language=a.language;
            wpr.default_branch=a.default_branch;
            wpr.login=a.owner.login;
            wpr.full_name=a.full_name;
            wrapperlist.add(wpr);

      }
        //System.debug('wrapperlist data:::'+wrapperlist);
       return wrapperlist;
    }    
    public class wrapper{
    @AuraEnabled public String id { get; set; }
    @AuraEnabled public String name { get; set; }        
    @AuraEnabled public string description;
    @AuraEnabled public string language; 
    @AuraEnabled public String default_branch;
    @AuraEnabled public String login;
    @AuraEnabled public String full_name;
    

    }
}