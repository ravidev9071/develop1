public with sharing class pageurlclass{
    public  String  headerdata{get;set;}
    public string urlvalue{get;set;}
    public string url{get;set;}
        
    public pageurlclass(){
        
         headerdata= ApexPages.currentPage().getHeaders().get('Host');
        
         urlvalue=Apexpages.currentPage().getUrl();
        
         url='https://' + headerdata+ urlvalue;
    }
  

}