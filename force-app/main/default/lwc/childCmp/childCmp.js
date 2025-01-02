import { LightningElement , api} from 'lwc';

export default class ChildCmp extends LightningElement {

@api messageFromParent; 
@api cData='Congratulations, Message successfully retrieve from Child component';
@api input;

        handleClick(){
        /*const event=new CustomEvent('messagetochild', {
        detail: this.cData
        });
        this.dispatchEvent(event);*/

      }
      onchange(event){
          this.input= event.target.value;
          const event1=new CustomEvent('messagetochild', {
            detail: this.input
            });
            this.dispatchEvent(event1);
      }
 }