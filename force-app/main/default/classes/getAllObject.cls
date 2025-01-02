public with sharing class getAllObject {
    @AuraEnabled(cacheable=true)
public static Map<String, String> getObjectList()
{
    Map<String,String> returnObjectMap = new Map<String,String>();

//Schema.getGlobalDescribe() => return a Map of type Map<String, Schema.SObjectType>
Map<String, Schema.SObjectType> objectMap = Schema.getGlobalDescribe();

//get List of all sObject
List<Schema.SObjectType> objectMapValues = objectMap.Values();
System.debug('All Objects '+ objectMapValues);

//prepare a Map to send Data from Server to Client Side

for(Schema.SObjectType objType : objectMapValues){
String key = objType.getDescribe().getName();
String value = objType.getDescribe().getLabel();
returnObjectMap.put(key,value);
}

if(returnObjectMap != null && returnObjectMap.size() > 0){
return returnObjectMap;
}else{
return null;
}
  
}
@AuraEnabled(cacheable=true)
public static List<String> getContactFields(String objName){

    //System.debug('Object Name::'+objName);
    
    List<String> allFields = new List<String>();

    Map<String, Schema.SObjectType> objectMap = Schema.getGlobalDescribe();
    SObjectType objType = objectMap.get(objName);

    Map<String,Schema.SObjectField> objTypeFields = objType.getDescribe().fields.getMap();

    if(!objTypeFields.isEmpty()){
        for (String fieldName: objTypeFields.keySet()) {
        //getting labels of the fields
        String fieldLabel = objTypeFields.get(fieldName).getDescribe().getName();
        allFields.add(fieldLabel);
        }
        }
       // System.debug(allFields);
        return allFields;

}
@AuraEnabled(cacheable=true)
public static List<sObject> getRecord(List<String> fieldName,String myobjectName){
string abc = string.join(fieldName,',');

    String aaa=abc.replace('(','').replace(')', '');


    
    String query;
    query='Select '+aaa+' From '+myobjectName;
    List < sObject > listdata=Database.query(query);

    System.debug('data'+listdata);
    return listdata;
    }


}