import { LightningElement, track,wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { CurrentPageReference } from 'lightning/navigation';


export default class LightningProjectTest extends NavigationMixin(LightningElement) {
 code;
    
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
    if (currentPageReference) {
        this.code = currentPageReference.state?.code;
        //.urlLanguage = currentPageReference.state?.lang;
        //this.urlType = currentPageReference.state?.type;
    }
    }
    currentPageReference;
        connectedCallback(){
        }
        
        oAuth() {
            this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url: 'https://login.salesforce.com/services/oauth2/authorize?client_id=3MVG9fe4g9fhX0E5qAgFxrkBE3nLUfBONavOxlof3ZQU9HWfK1e8.vCWjKmPtBtkTJDWFBqn.P0JzZJJhg3cB&redirect_uri=https://ravidev2023-dev-ed.develop.lightning.force.com/lightning/page/home&response_type=code'
                }
            });
            console.log('code::'+code); 

        }
        
        oGen(){
            alert('Token');
        }
}