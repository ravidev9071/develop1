import { LightningElement,track,wire,api } from 'lwc';
import getAccounts from '@salesforce/apex/WrapperClassTest.getAccounts';
import createAccount from '@salesforce/apex/WrapperClassTest.createAccount';
export default class GetAccountDetail extends LightningElement {
@track accList;
@api acc;
@track accRec;
@track name;
@track secname;
connectedCallback(){
getAccounts()
.then(result=>{
        this.accList= result;
        console.log('dfgdfgfd',this.accList);
    })
}
handleclick(event) {
    var inp=this.template.querySelectorAll("lightning-input");
    inp.forEach(function(element){
        if(element.name=="input1"){ this.name=element.value;
           // createAccount({accName:this.name})
           // window.alert(this.name);
   }
   else if(element.name=="input2"){
            this.secname=element.value;
//createAccount({secName:this.name})
           }
    },this);

    createAccount({accName:this.name,secName:this.secname})
     
}




}