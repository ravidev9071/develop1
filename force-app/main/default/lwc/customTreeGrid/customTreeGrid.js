import { LightningElement, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import getContactsByAccountId from '@salesforce/apex/AccountController.getContactsByAccountId';

export default class CustomTreeGrid extends LightningElement {
    @track accounts = [];

    connectedCallback() {
        // Load the initial account data
        this.loadAccountData();
       
    }

    loadAccountData() {
        // Call an Apex method to retrieve account data
        getAccounts()
            .then((result) => {
                // Assign the retrieved account data to the component property
                this.accounts = result.map((account) => {
                    return {
                        ...account,
                        isExpanded: false
                    };
                });console.log('Account data fetch ::::--> '+this.accounts[0].isExpanded);
            })
            .catch((error) => {
                // Handle any errors
                console.error(error);
            });
            
    }
   
    refreshData() {
        // Call the loadAccountData() method to refresh the data
        this.loadAccountData();
    }

    handleExpandContacts(event) {
        const accountId = event.target.dataset.accountId;
        const isExpanded = event.target.dataset.isExpanded === 'true';
        console.log('accountId ::::--> '+accountId);
        console.log('isExpanded ::::--> '+isExpanded);
        if (!isExpanded) {
            // Call an Apex method to retrieve contact data for the account
            getContactsByAccountId({ accountId })
                .then((result) => {
                    const updatedAccounts = [...this.accounts];
                    console.log('updatedAccounts ::::--> '+updatedAccounts[0].Id+''+updatedAccounts[0].Name+''+updatedAccounts[0].isExpanded);
                    const accountIndex = updatedAccounts.findIndex((account) => account.Id === accountId);
                    console.log('accountIndex ::::--> '+accountIndex);
                    if (accountIndex !== -1) {
                        updatedAccounts[accountIndex].Contacts = result;
                        updatedAccounts[accountIndex].isExpanded = true;
                        this.accounts = updatedAccounts;
                        console.log('updatedAccounts After ::::--> '+updatedAccounts[accountIndex].Contacts);
                        console.log('updatedAccounts After ::::--> '+updatedAccounts[accountIndex].isExpanded);

                        console.log('updatedAccounts After ::::--> '+this.accounts);
                    }
                })
                .catch((error) => {
                    // Handle any errors
                    console.error(error);
                });
        } else {
            // Collapse the contacts for the account
            const updatedAccounts = [...this.accounts];
            console.log('updatedAccounts After else::::--> '+updatedAccounts);
            const accountIndex = updatedAccounts.findIndex((account) => account.Id === accountId);
            console.log('accountIndex After else::::--> '+accountIndex);

            if (accountIndex !== -1) {
                updatedAccounts[accountIndex].Contacts = undefined;
                updatedAccounts[accountIndex].isExpanded = false;
                this.accounts = updatedAccounts;
                console.log('this.accounts After else::::--> '+this.accounts);

            }
        }
    }
}