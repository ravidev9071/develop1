public class deserializedApexTest {
@AuraEnabled(Cacheable=true)
public static List<wrapper> deserialized(){
    Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://restcountries.com/v3.1/all');
        HttpResponse response = h.send(req);
        List<Object> deserialized = (List<Object>)JSON.deserializeUntyped(response.getBody());
        
        List<object> keys=new List<object>();
        List<object> names=new List<object>();
        List<object> flag=new List<object>();
        List<String> capital=new List<String>();
        for(Object o:deserialized){
            Map<String, Object> a2 = (Map<String, Object>)o;
            Map<String, Object> a3 = (Map<String, Object>)a2.get('currencies');
            Map<String, Object> a4 = (Map<String, Object>)a2.get('name');
            Map<String, Object> a7 = (Map<String, Object>)a2.get('flags');
            List<Object> a8 = (List<Object>)a2.get('capital');
            
            keys.add(a3);
            names.add(a4);
            flag.add(a7);
            capital.add(String.valueOf(a8));
            
        }
        list<String> mykeys=new list<String>();
        list<String> common=new list<String>();
        list<String> official=new list<String>();
        list<String> flaglist=new list<String>();
        
        for(Object o1:keys){
            if(o1!=null){ 
                Map<String, Object> a3 = (Map<String, Object>)o1;
                mykeys.add(String.valueOf(a3.keySet()).replaceAll('[{}]', ''));
            }
            
        }
       // List<Account> acclist=new List<Account>();
        
        for(Object asa:names){
            if(asa!=null){
                Map<String, Object> a5 = (Map<String, Object>)asa;
                
                common.add(String.valueOf(a5.get('common')));
                official.add(String.valueOf(a5.get('official')));
                Account ac=new Account();
              /*  ac.Name=String.valueOf(a5.get('common'));
                ac.Description=String.valueOf(a5.get('official'));
                ac.Site=String.valueOf(a5.get('official'));
                acclist.add(ac);*/
            }
        }
        //System.debug('my new list::'+acclist);
        //insert acclist;
        map<String,string> mymap=new map<string,string>();
        
        
      // System.debug(mymap);
        List<Account> acclist=[Select Name from Account];
        
        map<String,Account> accmap=new Map<String,Account>();
        for(Account ac:acclist){
           accmap.put(ac.Name,ac); 
        }
        
        list<Account> acclistnew =new list<Account>();
        for(String abc:common){
            if(accmap.containskey(abc)){
                acclistnew.add(accmap.get(abc));
                
            }
            
        }System.debug(acclistnew); 
        
        
        
        
        for(Object flg:flag){
            Map<String, Object> a6 = (Map<String, Object>)flg;
            
            flaglist.add(String.valueOf(a6.get('png')));
        }
        List<String> str2=new List<String>();
        for(String str:capital){
            if(str!=null){
                str2.add(str.replaceAll('[()]', ''));
            }
            
        }
        List<String> capital1=new List<String>();
        
        for(String str3:str2){
            capital1.add(str3);
        }
        
        List<wrapper> wrapperlist=new List<wrapper>(); 
        
        for(Integer i=0;i<mykeys.size()-1;i++){
            wrapperlist.add(new wrapper(common[i],official[i],mykeys[i],flaglist[i],capital1[i],acclistnew[i]));
        }
        
        System.debug('wrapperlist:::'+wrapperlist);        
        return wrapperlist;
    }
    
    public class wrapper{
        @AuraEnabled public String common;
        @AuraEnabled public String official;
        @AuraEnabled public String currencies;
        @AuraEnabled public String flags;
        @AuraEnabled public String capital1;
        @AuraEnabled public Account acclistnew;

        public wrapper(String common,String official,String currencies,String flags,String capital1,Account acclistnew){
            this.common=common;
            this.official=official;
            this.currencies=currencies;
            this.flags=flags;
            this.capital1=capital1;
            this.acclistnew=acclistnew;
        }
    
}

}