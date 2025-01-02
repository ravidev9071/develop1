import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import pageUrl from '@salesforce/resourceUrl/recaptchaV2';
//import fetchPODetails from '@salesforce/apex/STP_POHistoryCallout.fetchPODetails';
import STP_pageTitle from '@salesforce/label/c.STP_POHistoryPageTitle';
import STP_poNumberLabel from '@salesforce/label/c.STP_WebCasePONumber';
import STP_invoiceNumberLabel from '@salesforce/label/c.STP_WebCaseInvoiceNumber';

import fetchPODetails from '@salesforce/apex/STP_POHistoryController.fetchPODetails';

export default class STP_POHistoryInterface extends LightningElement {
    @track poNo = '';
    @track invoiceNo = '';
    @track searchDisabled = false;
    @track showTable = false;
    @track searchData = [];
    @track isDisabled = true;
    @track recaptcha = false;
    @track showiframeandbtn=true;
    @track InvoiceTitle;
    @track outerCustomStyle = 'height:379px; width:1200px;display: grid;';
    
    
     @track searchData = []; // Holds the data to be displayed in the table
    @track columns = [
        { label: 'INVOICE #', fieldName: 'Invoice' },
        { label: 'DUE DATE', fieldName: 'DocumentDate' },
        { label: 'INVOICE STATUS', fieldName: 'Status' },
        { label: 'PAYMENT STATUS', fieldName: 'Status' },
       // { label: 'PO Number', fieldName: 'PONumber' },
        //{ label: 'Vendor ID', fieldName: 'VendorID' },
        //{ label: 'Company Code', fieldName: 'CompanyCode' },
       // { label: 'Payment Term', fieldName: 'Paymentterm' },
       // { label: 'Total Value', fieldName: 'TotalValue' },
       // { label: 'Currency Code', fieldName: 'CurrencyCode' },
        
       // { label: 'Remarks', fieldName: 'Remarks' },
        
         // Added Invoice as a column
    ];
    @track searchStr = 'Search';

    @track navigateTo = pageUrl;
    @track isCaptchaVerified = false;

    label = {
        STP_pageTitle,
        STP_poNumberLabel,
        STP_invoiceNumberLabel,
    };

    connectedCallback() {
        window.addEventListener('message', this.listenForMessage.bind(this));
    }

    disconnectedCallback() {
        window.removeEventListener('message', this.listenForMessage.bind(this));
    }

    captchaLoaded(event) {
        if (event.target.getAttribute('src') === this.navigateTo) {
            console.log('Google reCAPTCHA is loaded.');
        }
    }

    listenForMessage(event) {
        console.log('Event origin:', event.origin); // Debugging log
        console.log('Event data:', event.data); // Debugging log

if (event.origin === 'https://ravidev2023-dev-ed.develop.my.site.com') {
    try {
        console.log('Raw Event Data:', event.data);
        console.log('Type of Event Data:', typeof event.data);

        // Sanitize the data
        const sanitizedData = (event.data || '').trim();
        console.log('Sanitized Data:', sanitizedData);

        if (sanitizedData) {
    console.log('Sanitized Data:', sanitizedData);

    // Check if the data matches the expected format
    if (sanitizedData === 'captcha success') {
        console.log('Captcha verified successfully.');
        this.isCaptchaVerified = true;
        this.recaptcha=true;
          if (this.recaptcha) {
        // Create synthetic events or directly set values
        const poEvent = { target: { id: 'STP_WebCasePONumber', value: this.poNo } };
        const invoiceEvent = { target: { id: 'STP_WebCaseInvoiceNumber', value: this.invoiceNo } };

        // Simulate user input to ensure handleChange processes the data
        this.handleChange(poEvent);
        this.handleChange(invoiceEvent);
    }
        this.searchDisabled = false;
    } else if (sanitizedData === 'captcha failure') {
        console.log('Captcha verification failed.');
        this.isCaptchaVerified = false;
        this.searchDisabled = true;
        this.showToast('Error', 'Captcha verification failed', 'error');
    } else {
        console.warn('Unexpected data format:', sanitizedData);
        this.showToast('Error', 'Invalid response format from CAPTCHA', 'error');
    }
} else {
    console.warn('Event data is empty or only whitespace.');
}
    } catch (error) {
        console.error('Error parsing event data:', error, 'Sanitized Data:', sanitizedData);
        this.showToast('Error', 'Failed to process captcha verification', 'error');
    }
} else {
    console.warn('Unexpected event origin:', event.origin);
}



    }

    handleChange(event) {
      
        const field = event.target.id;
        if (field.includes('STP_WebCasePONumber')) {
            this.poNo = event.target.value;
        } else if (field.includes('STP_WebCaseInvoiceNumber')) {
            this.invoiceNo = event.target.value;
        }
          //  this.isDisabled = !(this.poNo && this.invoiceNo);
            if(this.poNo && this.invoiceNo && this.recaptcha === true){
              this.isDisabled=false;
              
            }else{
               
               this.isDisabled=true;
 
            }

    }
  
    handleSearch() {
        if (!this.isCaptchaVerified) {
            this.showToast('Error', 'Please complete the CAPTCHA verification', 'error');
            return;
        }
                // Search for matching record in mock data
       
    


        fetchPODetails({ poNumber: this.poNo, invoiceNumber: this.invoiceNo })
            .then((result) => {
                if (result) {
                    console.log(JSON.stringify(result));
                    if (result && result.length > 0)     {
                    this.InvoiceTitle = 'INVOICE ' + result[0].Invoice;
                    this.searchData = result[0].PurchaseOrder.map(po => {
                return {
                    PONumber: po.PONumber,
                    VendorID: po.VendorID,
                    CompanyCode: po.CompanyCode,
                    Paymentterm: po.Paymentterm,
                    TotalValue: po.TotalValue,
                    CurrencyCode: po.CurrencyCode,
                    Status: po.Status,
                    Remarks: po.Remarks,
                    DocumentDate: po.DocumentDate,
                    Invoice: result[0].Invoice // Adding Invoice to each record
                };
            });
                    this.showTable = true;
                    this.showiframeandbtn=false;
                    this.searchStr = 'Search Again';
                     this.showToast('Success', 'Record found!', 'success');
                     this.outerCustomStyle = 'height:224px; width:1200px;display: grid;';
                    }
                    else {
                    this.searchData = [];
                    this.showTable = false;
                    this.showToast('Error', 'No matching records found!', 'error');
                  }
                } else {
                    this.showToast('Error', 'Invalid PO or Invoice Number', 'error');
                }
            })
            .catch((error) => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}