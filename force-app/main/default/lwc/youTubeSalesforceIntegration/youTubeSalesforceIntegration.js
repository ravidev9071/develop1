import { LightningElement, track, wire } from 'lwc';
import YoutubeandSalesforce from '@salesforce/apex/YouTubeSalesforceIntegration.YoutubeandSalesforce';
import IMAGES from "@salesforce/resourceUrl/static_images";
export default class YouTubeSalesforceIntegration extends LightningElement {
    torontoImage = IMAGES + '/static_images/images/toronto-city-CN-tower.png';

    @track change;
    @track onlick;
    @track videodata=[];
    @track url;
    @track property=false;
    handleOnChange(event){
        this.change=event.target.value;
    }
    handleOnClick(event){
        if(this.change!=null){
        this.property=true;
        this.onlick=this.change;
        const search=this.onlick;
        
    YoutubeandSalesforce({search}).then(result => {
    this.videodata=result;
    this.property=false;
    })    }
}
    anchor(videoId){
    this.url = 'https://www.youtube.com/embed/'+videoId;


   // https://www.youtube.com/watch?v=fZCe_JY8oUI


}

}