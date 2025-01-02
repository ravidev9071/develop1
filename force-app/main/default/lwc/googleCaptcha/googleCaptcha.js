import { LightningElement } from 'lwc';

export default class GoogleCaptcha extends LightningElement {

    connectedCallback() {

        console.log( 'Inside Google Captcha Connected Callback' );
        document.addEventListener( "grecaptchaVerified", ( e ) => {

            console.log( 'Captcha Response from Verification is ' + e.detail.response );
            let detailPayload = { value : false, response : e.detail.response };
            this.dispatchEvent( new CustomEvent( 'captcha', { detail : detailPayload } ) );

        });

        document.addEventListener( "grecaptchaExpired", () => {

            console.log( 'Listener Expired' );
            this.dispatchEvent( new CustomEvent( 'captcha', { detail : { value : true } } ) );

        } );
        
    }

    renderedCallback() {

        console.log( 'Inside Google Captcha Rendered Callback' );
        let divElement = this.template.querySelector( 'div.recaptchaCheckbox' );
        console.log( 'Div Element is ' + JSON.stringify( divElement ) );
        let payload = { element: divElement };
        document.dispatchEvent(new CustomEvent( "grecaptchaRender",  { "detail": payload } ) );
        
    }

}