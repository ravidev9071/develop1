import { LightningElement, wire} from 'lwc';
import getAccounts from '@salesforce/apex/getRecordDataController123.getAccounts';

export default class GetDataDisplayData extends LightningElement {
     @wire(getAccounts) wiredAccounts;
}