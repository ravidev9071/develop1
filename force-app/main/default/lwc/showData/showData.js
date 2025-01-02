import { LightningElement, track, wire } from 'lwc'
import getAccountandContacts from '@salesforce/apex/AccountWithContact.getAccountandContacts'
import ShowContact from '@salesforce/apex/AccountWithContact.ShowContact';
import { NavigationMixin } from 'lightning/navigation';
export default class ShowData extends NavigationMixin(LightningElement) {
  @track xyz=[];
  @track accId;
  @track refUrl;
  @track refUrlcon;
  
  connectedCallback() {
    this.loadAccountData();
    
    }
    loadAccountData() {
      getAccountandContacts()
          .then((result) => { 
          this.xyz=result.map((account) => {
            return {
                ...account,
                messgage:'',
                isExpanded: false
            };
          });
        })
    }

  hancleclick (event) {
    const accId = event.target.dataset.accountId;
    ShowContact({ accId })
    .then((result) => {
      
      if(result!=''){
      //console.log('if::'+result);
      const updatedAccounts = [...this.xyz];
      const accountIndex = updatedAccounts.findIndex((account) => account.Id === accId);
      updatedAccounts[accountIndex].Contacts = result.map((contact,index) => {return {...contact,index: index+1};});
      updatedAccounts[accountIndex].isExpanded = true;
      this.xyz = updatedAccounts;
      
      }
      else{
        const updatedAccounts = [...this.xyz];

        const accountIndex = updatedAccounts.findIndex((account) => account.Id === accId);
        updatedAccounts[accountIndex].messgage = 'No Contacts found for this Account!!!';
        updatedAccounts[accountIndex].isExpanded = true;
        this.xyz = updatedAccounts;
        console.log('test'+this.xyz[accountIndex].isExpanded);
      }
    })
}
  hancleclickCollpase(event){
    const updatedAccounts = [...this.xyz];
    const accId = event.target.dataset.accountId;
    const accountIndex = updatedAccounts.findIndex((account) => account.Id === accId);
    updatedAccounts[accountIndex].Contacts = undefined;
    updatedAccounts[accountIndex].isExpanded = false;
    this.xyz = updatedAccounts;
  }
  handleNavigationClick(event){
    const accIdsnew=event.target.title;
    this.refUrl='https://ravidev2023-dev-ed.develop.lightning.force.com/lightning/r/Account/'+accIdsnew+'/view';
  
  }
  handleNavigationClickcontact(event){
    const conId=event.target.title;
    this.refUrlcon='https://ravidev2023-dev-ed.develop.lightning.force.com/lightning/r/Contact/'+conId+'/view';
   
  }
  
}