import { LightningElement,track,wire,api } from 'lwc';
import showMessagefromchatGPT from '@salesforce/apex/chatGPT.chatGPTshowdata';

export default class ChatGPTLWCpage extends LightningElement {
    
//@wire(showMessagefromchatGPT) showdata;
@track change;
@track onlick;
@track showdata;
@track property=false;
handleOnChange(event){
this.change=event.target.value;
//alert(this.change);
}
handleOnClick(event){
this.onlick=this.change;
if(this.onlick!=null){
const mydata=this.onlick;
this.property=true;

//alert(mydata);

showMessagefromchatGPT({ mydata }).then(result => {
    

    this.showdata=result;
    this.property=false;

})


}
}
}