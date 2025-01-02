import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class AccountEditButton extends NavigationMixin(LightningElement) {
    @api recordId; // Record ID passed dynamically to the component

    // Navigate to the standard Edit page for the account record
    handleEdit() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: 'Knowledge__kav', // Object name
                actionName: 'edit' // Redirect to the Edit page
            }
        });
    }
}