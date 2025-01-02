import { LightningElement, track, wire } from 'lwc';
import getCerifiedPharmacies from '@salesforce/apex/AccountController.getAccounts';
import getContactsByAccountId from '@salesforce/apex/AccountController.getContactsByAccountId';
import aveed_logo from "@salesforce/resourceUrl/aveed_logo";
import { CurrentPageReference } from 'lightning/navigation';

export default class PiaSky_PharmacyLookup extends LightningElement {
    @track records = [];
    @track noRecordMessage = '';
    @track showError = false;
    @track variable=false;
    @track logo = aveed_logo;
    @track showPagination = false;
    @track visibleContacts = [];
    @track sortedDirection = 'asc';
    @track sortarrow = 'utility:arrowup';
    @track sortedBy = 'Name'
    @track textget;
    @track testArray=[];
        filesMap = new Map();

    @wire(getCerifiedPharmacies, { direction: '$sortedDirection' })
    wiredPicklistValues({ error, data }) {
        if (data) {
              this.records = data.map(caseRecord => {
                return {
                    ...caseRecord,
                    formattedCreatedDate: this.convertISOToDateFormat(caseRecord.CreatedDate),
                    Name: caseRecord.Name + ' Modified by JS'
                };
            });
        //    this.records.forEach((element)=>{
                   //         this.filesMap.set(element.label,element);

        //     if(element.Name!='Blaze Modified by JS'){
        //     this.testArray.push(element);

        //     }
        //    })


             if (this.records.length == 0) {
                this.showError = true;
                this.noRecordMessage = 'No Accounts available for selected search criteria';
            } else {
                this.showPagination = true;
            }
        } 
    }
    @wire(getContactsByAccountId,{searchkey:'$textget'}) srch({data}){
        if (data) {
              this.records = data.map(caseRecord => {
                return {
                    ...caseRecord,
                    formattedCreatedDate: this.convertISOToDateFormat(caseRecord.CreatedDate),
                    Name: caseRecord.Name + ' Modified by JS'
                };
            });
            //  if (this.records.length == 0) {
            //     this.showError = true;
            //     this.noRecordMessage = 'No Accounts available for selected search criteria';
            // } else {
            //     this.showPagination = true;
            // }
        } 
    }

       convertISOToDateFormat(isoDateTime) {

            const date = new Date(isoDateTime);
            //date.setFullYear(date.getFullYear() + 3);

            const day = String(date.getUTCDate()).padStart(2, '0');
            const month = String(date.getUTCMonth() + 1).padStart(2, '0'); // Months are zero-indexed
            const year = date.getUTCFullYear();

            let hours = date.getUTCHours();
            const minutes = String(date.getUTCMinutes()).padStart(2, '0');
            //const seconds = String(date.getUTCSeconds()).padStart(2, '0');

            const ampm = hours >= 12 ? 'PM' : 'AM';

            hours = hours % 12;
            hours = hours ? hours : 12; 

            const formattedHours = String(hours).padStart(2, '0');
            const formattedDate = `${month}/${day}/${year} ${formattedHours}:${minutes} ${ampm}`;


        return formattedDate;
    }
    updateRecords(event) {
        this.visibileContacts = [];
        this.visibleContacts = [...event.detail.records]

    }
    sortByColumn(event) {
        const clickedColumn = event.target.dataset.title; // Extract the column header text
        if (this.sortedBy === clickedColumn) {


            // Toggle sorting direction if the same column header is clicked again
            this.sortedDirection = this.sortedDirection === 'asc' ? 'desc' : 'asc';
            this.sortarrow = this.sortarrow === 'utility:arrowup' ? 'utility:arrowdown' : 'utility:arrowup';


        }

    }
    textfind(event) {
        this.textget = event.target.value;
        
       
    }
    btnclick(){
       // this.variable=true;
       let acc = this.refs.accNameRef.value;
    }
    @wire(CurrentPageReference)
    getCurrentPageRef(pageRef) {
        if (pageRef) {
            // Get the current URL
            this.currentPageName = 'HCP_resources__c';
        }
    }
     get manage_hcs_CSS() {
        return this.currentPageName === 'Home' ? 'highlightpanel' : 'aveedcss';
    }
    get formsandResourcesCSS() {
        return this.currentPageName === 'HCP_resources__c' ? 'highlightpanel ' : 'aveedcss';
    }
    get myprofileCSS() {
        return this.currentPageName === 'myprofile__c' ? 'highlightpanel' : 'aveedcss';
    }
   
   

}