import { LightningElement,api,wire } from 'lwc';
import displayAccounts from '@salesforce/apex/AccountController.displayAccounts';
import updateRecord from '@salesforce/apex/AccountController.updateRecord';
import { refreshApex } from '@salesforce/apex';
export default class UpdateAccount extends LightningElement {
	@api currentRecordId;
	@api errorMessage;
    @wire(displayAccounts) accounts;
    handleUpdate(event){
        this.currentRecordId=event.target.value;
        console.log('@@currentRecordId@@@'+this.currentRecordId);
        updateRecord({
            accId:this.currentRecordId
        })
        .then(() => {
            console.log('SUCCESS');
            return refreshApex(this.accounts);
        })
        .catch((error) => {
            this.errorMessage=error;
			console.log('unable to update the record due to'+JSON.stringify(this.errorMessage));
        });
    }
}