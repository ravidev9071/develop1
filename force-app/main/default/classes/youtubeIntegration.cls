public class youtubeIntegration {
    @AuraEnabled
    public static List<Wrapperclass> YoutubeandSalesforce(){
        String SEARCH_URL='https://www.googleapis.com/youtube/v3/search';
        String API_KEY='AIzaSyBjzYAhLt_Lbbhk0B3wzcvksC_mFSWY4sw';
        String token='ya29.a0AbVbY6Mi-6T-x8wgK6mRSNagv5b5IY8HuUca48v92DbhnL4JrovtUx_BVSukKQR5xwmYxEziyRkUtTvQXPeFCVAVRnr_t-JSIDJ5cvcEOS_wUfPKMVIqDnbVIL-_paxfwiMk2gay0H7fCIClVezRkZDSPGWMZwaCgYKARQSARESFQFWKvPlxlzLWRbv5-EnlXPs8bl7IA0165';
        String searchKey='Bollywood silver screen';
        String endpoint  = SEARCH_URL+'?part=snippet'+'&maxResults=20'+'&type=video'+'&q='+EncodingUtil.urlEncode(searchKey,'UTF-8')+'&key='+API_KEY;
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
        for (YouTubeResult.Item itemObj : items) {
            Wrapperclass abc=new Wrapperclass();
            abc.videoId=itemObj.id.videoId;
            abc.title=itemObj.snippet.title;
            abc.description=itemObj.snippet.description;
            abc.thumbnails=itemObj.snippet.thumbnails.medium.url;
            abc.channelTitle=itemObj.snippet.channelTitle;
            wrapperlist.add(abc);
        }
        return wrapperlist;
    }
    public class Wrapperclass{
        @AuraEnabled public string channelTitle{get;set;}
        @AuraEnabled public string videoId{get;set;}
        @AuraEnabled public string snippet{get;set;}
        @AuraEnabled public string title{get;set;}
        @AuraEnabled public string description{get;set;}
        @AuraEnabled public String thumbnails{get;set;}
    }
}