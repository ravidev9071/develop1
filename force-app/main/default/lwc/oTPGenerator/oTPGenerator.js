import { LightningElement, track,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class OTPGenerator extends NavigationMixin (LightningElement) {
    @track otpdata;
    @track rdata;
    @track newdata;
    @track mytest=[];
    @track number;
    @track resendotp=false;
    @track increment=0;
    a=1;
    @track otpshow=true;
    @track verifiedbutton=false;
    @track countdownInterval;
    handleOnClick(){
        this.otpshow=false;
        this.resendotp=false;
        this.verifiedbutton=true;
        var count =10;
            this.mytest=[]
            for(var i=0;i<4;i++){
                this.mytest.push(Math.floor(Math.random() * 10));
            
            } this.otpdata=this.mytest.join("");
    
            this.countdownInterval = setInterval(() => {
            count < 1 && clearInterval(countdownInterval);
            if(count <= 10){
            this.number='0'+(--count);
            if(this.number==='00'){
                this.resendotp=true;
                this.otpdata='';
                this.verifiedbutton=false;
            }
            }

            else{
                this.number=(--count);
            }


            }, 1000);   
        }
            handleOnChange(event){
                this.rdata=event.target.value; 
            }
            Varified(){
            this.newdata=this.rdata;
            if((this.newdata===this.otpdata)&&(this.newdata!=undefined)){
                this.otpdata='';
                this.verifiedbutton=false;
                const evt = new ShowToastEvent({
                    title: 'Toast Success',
                    message: 'OTP verified successfully',
                    variant: 'success',
                    mode: 'dismissable'
                });
                this.dispatchEvent(evt);
                this[NavigationMixin.Navigate]({
                    "type": "standard__webPage",
                    "attributes": {
                        "url": "https://trailhead.salesforce.com/today"
                    }
                });
                clearTimeout(this.countdownInterval);
            }
            else if(this.newdata!=undefined){
                this.increment= this.increment+this.a;
                const evt = new ShowToastEvent({
                    title: 'Toast Warning',
                    message: 'You have enter ' +this.increment +' Incorrect OTP',
                    variant: 'warning',
                    mode: 'dismissable'
                });
                this.dispatchEvent(evt);
                
                if(this.increment>2){
                
                    this[NavigationMixin.Navigate]({
                        "type": "standard__webPage",
                        "attributes": {
                            "url": "https://www.atlassian.com/blog/statuspage/error-pages"
                        }
                    });
                    
                    this.otpdata='';
                    otpshow=true;
                    
                }
            }

    }
}