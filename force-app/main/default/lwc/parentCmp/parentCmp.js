import { LightningElement, track } from 'lwc';

export default class ParentCmp extends LightningElement {
        xyz;
//value='This is data from Parent cmp';

        handlemessage(event)
        {
          
            this.xyz=event.detail;
            
        } 
}