import { LightningElement, track, wire, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getRecordNames from '@salesforce/apex/MultiPicklistController.getRecordNames';
import getSelectedValues from '@salesforce/apex/MultiPicklistController.getSelectedValues';
import saveSelectedValues from '@salesforce/apex/MultiPicklistController.saveSelectedValues';
import EditSelectedValues from '@salesforce/apex/MultiPicklistController.EditSelectedValues';
import getBooleanField from '@salesforce/apex/MultiPicklistController.getBooleanField';
import getUserAccessLevel from '@salesforce/apex/MultiPicklistController.getUserAccessLevel';

import searchRecords from '@salesforce/apex/STP_POHistoryController.searchRecords';


export default class DualListboxWithSave extends NavigationMixin(LightningElement) {
    @track options = [];
    @track selectedValues = [];
    @track selectedValuesForDisplay = [];
    @track error;
    @track showSection = true;
    @track ServiceOrder = true;
    @track paginatedRecords = [];
    @track currentPage = 1;
    @track totalPages = 0;
    @track pageData = []; 
    @track refreshKey = 0;
    @api recordId;
    recordsPerPage = 10;
    accessLevel = 'Read-Only';
    objectName = 'Service_Order_Template__c';
  
   @wire(getUserAccessLevel)
    wiredUserAccess({ error, data }) {
        if (data) {
            this.accessLevel = data;
        } else if (error) {
            console.error('Error fetching user access level:', error);
        }
    }

    get isFullAccess() {
        return this.accessLevel === 'Full';
    }

    get isReadOnly() {
        return this.accessLevel === 'Read-Only';
    }
  
   @wire(getRecordNames, { objectName: '$objectName' })
    wiredRecords({ error, data }) {
        if (data) {
            this.options = data.map(record => ({
                label: record.Name,
                value: JSON.stringify({ Id: record.Id, Name: record.Name, IsActive: record.Is_Active__c })
            }));
            //alert();
            console.log(JSON.stringify(this.options));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.options = [];
        }
    }

    @wire(getSelectedValues, { recordId: '$recordId', refreshKey: '$refreshKey' })
    wiredSelectedValues({ error, data }) {
        if (data) {
            this.processSelectedValues(data);
            this.updatePaginatedRecords();
        } else if (error) {
            this.error = error;
        }
    }

    processSelectedValues(data) {
        this.selectedValues = data.map(record => JSON.stringify({
        Id: record.Id, 
        Name: record.UpdatedName || record.Name, 
        
    }));
        this.selectedValuesForDisplay = data.map(record => {
            const name = record.Name || '';
            const updatedName = record.UpdatedName || '';
            const isNameUpdated = updatedName && updatedName !== name;
            const isActive = record.IsActive === 'Active';
            return {
                ...record,
                Name: name,
                UpdatedName: updatedName,
                status: record.Exists
                    ? isNameUpdated
                        ? isActive
                            ? 'Updated/Active'
                            : 'Updated/Inactive'
                        : isActive
                        ? 'Active'
                        : 'Inactive'
                    : 'Deleted',
                computedStyle: record.Exists
                    ? isNameUpdated
                        ? isActive
                            ? 'status-updated-active'
                            : 'status-updated-inactive'
                        : isActive
                        ? 'status-active'
                        : 'status-inactive'
                    : 'status-deleted',
                IsNameUpdated: isNameUpdated,
                statusText: isNameUpdated ? 'Yes' : 'No'
            };
        });

        this.selectedValuesForDisplay.sort((a, b) => (a.Name || '').localeCompare(b.Name || ''));
        this.selectedValuesForDisplay = this.selectedValuesForDisplay.map((record, index) => ({
            ...record,
            index: index + 1
        }));

        this.totalPages = Math.ceil(this.selectedValuesForDisplay.length / this.recordsPerPage);
            this.updatePageData();
    }

    updatePageData() {
    this.pageData = Array.from({ length: this.totalPages }, (_, index) => {
        const page = index + 1;
        return {
            page,
            variant: page === this.currentPage ? 'brand' : 'neutral'
        };
     });
  }

  handleNextPage() {
    if (this.currentPage < this.totalPages) {
        this.currentPage += 1;
        this.updatePaginatedRecords();
        this.updatePageData(); // Update the page data
     }
   }

  handlePreviousPage() {
    if (this.currentPage > 1) {
        this.currentPage -= 1;
        this.updatePaginatedRecords();
        this.updatePageData(); // Update the page data
    }
  }

  handlePageClick(event) {
    const selectedPage = parseInt(event.target.dataset.page, 10);
    if (selectedPage !== this.currentPage) {
        this.currentPage = selectedPage;
        this.updatePaginatedRecords();
        this.updatePageData(); // Update the page data
    }
 }

  updatePaginatedRecords() {
    if (this.selectedValuesForDisplay && this.selectedValuesForDisplay.length > 0) {
        const start = (this.currentPage - 1) * this.recordsPerPage;
        const end = this.currentPage * this.recordsPerPage;
        this.paginatedRecords = this.selectedValuesForDisplay.slice(start, end);
    } else {
        this.paginatedRecords = [];
    }
 }

    @wire(getBooleanField, { recordId: '$recordId' })
    wiredBooleanField(result) {
        this.wiredBooleanData = result; // Save the wire result for refreshing
        if (result.data !== undefined) {
            this.showSection = result.data;
        } else if (result.error) {
            console.error('Error fetching Boolean field:', result.error);
        }
    }

   handleChange(event) {
      this.selectedValues = event.detail.value;
     }
      handleSave() {
         if (this.isFullAccess) {
          this.ServiceOrder = false;
           if (!this.recordId) {
               this.showToast('Error', 'Record ID is missing. Cannot save values.', 'error');
               return;
            }

        const parsedValues = this.selectedValues.map(value => JSON.parse(value));
        saveSelectedValues({ recordId: this.recordId, selectedValues: parsedValues, isActive: this.ServiceOrder })
            .then(() => {
                this.showToast('Success', 'Selected values saved successfully!', 'success');
                this.refreshKey++;
                return refreshApex(this.wiredBooleanData);
            })
            .catch(error => {
                this.showToast('Error', 'Failed to save selected values.', 'error');
                console.error(error);
            });
         }
         else{
             console.log('Read-only: Cannot save.');
         }
    }
   handleEdit() {
     if (this.isFullAccess) {
        this.showSection=true;
        this.ServiceOrder = true;
        EditSelectedValues({ recordId: this.recordId, isActive: this.ServiceOrder })
            .then(() => {
                // Refresh the Boolean field value after editing
                return refreshApex(this.wiredBooleanData);
            })
            .catch(error => {
                this.showToast('Error', 'Failed to edit selected values.', 'error');
                console.error(error);
            });
          }
          else{
            console.log('Read-only: Cannot edit.');
          }
    }

    handleRedirect(event) {
        const recordId = event.target.dataset.id;
        this[NavigationMixin.GenerateUrl]( {
            type: 'standard__recordPage',
            attributes: {
                recordId,
                objectApiName: 'Service_Order_Template__c',
                actionName: 'view'
            }
        }).then(generatedUrl => {
            window.open(generatedUrl);
        });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }

    get hasRecords() {
        return this.selectedValuesForDisplay && this.selectedValuesForDisplay.length > 0;
    }
    get isServiceOrderChanged() {
    return this.selectedValuesForDisplay.some(record => record.IsNameUpdated);
 }
  
  handleExit(){
    this.showSection=false;
      this.ServiceOrder = false;
         EditSelectedValues({ recordId: this.recordId, isActive: this.ServiceOrder })
            .then(() => {
                return refreshApex(this.wiredBooleanData);
            })
            .catch(error => {
                this.showToast('Error', 'Failed to edit selected values.', 'error');
                console.error(error);
            });
    }
}