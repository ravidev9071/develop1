public with sharing class YouTubeSalesforceIntegration {
    @AuraEnabled
    public static List<Wrapperclass> YoutubeandSalesforce(String search){
        system.debug('search:::'+search);
        String SEARCH_URL='https://www.googleapis.com/youtube/v3/search';
        String API_KEY='AIzaSyBjzYAhLt_Lbbhk0B3wzcvksC_mFSWY4sw';
        String token='ya29.a0AbVbY6NIkYCQaHXc696b1lWbmTgsFenu9TIrXlt6HqhBE_dgVWhS7uxCDuk0G1neYmmG-dpS_8ns8vG2qJrt2Y9QPQE15ucCgrB9qBhPFPCYLr2dbfJtvI1K5PJocofnV93AjErzHkiojoPVGcWqIMhi4A1sFwaCgYKAasSARESFQFWKvPlUB3M6rfvyk7Ofvisrf9PdA0165';
        String endpoint  = SEARCH_URL+'?part=snippet'+'&maxResults=20'+'&type=video'+'&q='+EncodingUtil.urlEncode(search,'UTF-8')+'&key='+API_KEY;
        HttpRequest req1=new HttpRequest();
        req1.setEndpoint(endpoint);
        req1.setMethod('GET');
        req1.setHeader('Authorization','Bearer '+token);
        Http http1=new Http();
        HttpResponse response1=new HttpResponse();
        response1=http1.send(req1);
        //  System.debug(response1.getBody());
        List<Wrapperclass> wrapperlist=new List<Wrapperclass>();        
        YouTubeResult.Response response = (YouTubeResult.Response)JSON.deserialize(response1.getBody(), YouTubeResult.Response.class);
        List<YouTubeResult.Item> items  =  response.items;
        String urlnew='https://www.youtube.com/embed/';
        for (YouTubeResult.Item itemObj : items) {
            Wrapperclass abc=new Wrapperclass();
            abc.videoId=itemObj.id.videoId;
            abc.title=itemObj.snippet.title;
            abc.description=itemObj.snippet.description;
            abc.thumbnails=itemObj.snippet.thumbnails.medium.url;
            abc.channelTitle=itemObj.snippet.channelTitle;
            abc.myTest=urlnew+''+abc.videoId;
            
            wrapperlist.add(abc);
        }
        System.debug('wrapperlist::--'+wrapperlist);
        return wrapperlist;
        
        
    }
    public class Wrapperclass{
        @AuraEnabled public string channelTitle{get;set;}
        @AuraEnabled public string videoId{get;set;}
        @AuraEnabled public string snippet{get;set;}
        @AuraEnabled public string title{get;set;}
        @AuraEnabled public string description{get;set;}
        @AuraEnabled public String thumbnails{get;set;}
        @AuraEnabled public String myTest{get;set;}
        
        
    }
}