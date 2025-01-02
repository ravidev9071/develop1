import { LightningElement,wire,api } from 'lwc';
import Id from '@salesforce/user/Id';
import { getRecord } from 'lightning/uiRecordApi';
import accId from '@salesforce/schema/Account.Id';

import uName from '@salesforce/schema/User.Name';
import uEmail from '@salesforce/schema/User.Email';
import uMobilePhone from '@salesforce/schema/User.MobilePhone';
import uCompanyName from '@salesforce/schema/User.CompanyName';
import uTitle from '@salesforce/schema/User.Title';
const usrfield=[uName,uEmail,uMobilePhone,uCompanyName,uTitle];
export default class SchemaINLWC extends LightningElement {
    @api
    recordId;
    userIds=Id;
    usrName;
    usrEmail;
    usrMobile;
    userCmpy;
    userAdd;

    
    @wire(getRecord, { recordId: Id, fields: usrfield})
    usrdata({data}){
        if(data){
            this.usrName=data.fields.Name.value;
            this.usrEmail=data.fields.Email.value;
            this.usrMobile=data.fields.MobilePhone.value;
            this.userCmpy=data.fields.CompanyName.value;
            this.userAdd=data.fields.Title.value;
 console.log(data);

        }
    }
    

}