import { LightningElement, track ,wire} from 'lwc';
import GetdatafromDrive from '@salesforce/apex/getDataGoogleDrive.GetdatafromDrive';
import IMAGES from "@salesforce/resourceUrl/googledriveimage";
import { CurrentPageReference } from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';
import  { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getAccessTokendrive from '@salesforce/apex/getDataGoogleDrive.getAccessTokendrive';


export default class GetAlldatafromGoogleDrive  extends NavigationMixin(LightningElement) {
    driveImage = IMAGES + '/driveimage/images/drive.png';
    @track drivedata;
    @track code;
    @track token;
    @track token1;
    @track spinner=false;
    progress = 0;
    isProgressing = false;
    butshow=false;

/* connectedCallback(){
       // alert('init');
        GetdatafromDrive().then(result=>{
            this.drivedata=result;
        
            
        })
    
    }
    */
    oAuth(){
        window.location.replace('https://accounts.google.com/o/oauth2/v2/auth?client_id=316642208420-3s2fqlso98qkd2ijc0qmiqqvh2eondv8.apps.googleusercontent.com&response_type=code&scope=https://www.googleapis.com/auth/drive&access_type=offline&prompt=consent&redirect_uri=https://ravidev2023-dev-ed--c.develop.vf.force.com/apex/vfpageexternalsite?core.apexpages.request.devconsole=1');
        
        //console.log('-----code-----'+code);      
    
    
    }
    getcode(){
            this.butshow=true;
            this.spinner=true;
            this.isProgressing = true;
            this._interval = setInterval(() => {
            this.progress = this.progress === 100 ? 0 : this.progress + 5;
            }, 105);
        GetdatafromDrive().then(result=>{
                this.drivedata=result.map((abc,index) => {return {...abc,index: index+1};});;
                console.log('wow this done:::'+result);
            })
            this.spinner=false;
            this.isProgressing = false;
            clearInterval(this._interval);

        // this.butshow=true;
        // this.spinner=true;
        // this.isProgressing = true;
        //     this._interval = setInterval(() => {
        //         this.progress = this.progress === 100 ? 0 : this.progress + 5;
        //     }, 105);
        // const queryString = window.location.search;
        // this.qs=queryString;
        // const urlParams = new URLSearchParams(queryString);
        // this.code = urlParams.get('code')
        // const authcode=this.code;
        // getAccessTokendrive({authcode}).then(result=>{
        // this.token=result;
        // this.token1=this.token.slice(0, 80)
        // const tkn=this.token;
    
        // GetdatafromDrive({tkn}).then(result=>{
        //     this.drivedata=result;
        //     const evt = new ShowToastEvent({
        //         title: 'Toast Success',
        //         message: 'Congrutulation, Data successfully fetched from Google drive',
        //         variant: 'success',
        //         mode: 'dismissable'
        //     });
        //     this.dispatchEvent(evt);
        //     this.spinner=false;
        //     this.isProgressing = false;
        //     clearInterval(this._interval);
            
      //  })


//})



    }

}