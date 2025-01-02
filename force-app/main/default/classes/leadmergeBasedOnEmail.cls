public class leadmergeBasedOnEmail {
    public static void mergeTest(){
        List<Lead> leadRecord=[Select Id,Name,LastModifiedDate ,Email from lead where IsConverted = false ];
       set<String> leaddata=new set<String>();
        for(lead l:leadRecord){
            leaddata.add(l.Email);
            leaddata.add(l.Id);
                
            
        }
     List<lead> lds=  [Select Id,Name,LastModifiedDate ,Email from lead where IsConverted = false AND Id IN :leaddata];
        System.debug(lds);
    }

}