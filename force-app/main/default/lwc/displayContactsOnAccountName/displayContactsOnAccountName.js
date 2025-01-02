import { LightningElement, api, wire,track } from 'lwc';
import getRelatedFilesByRecordId from '@salesforce/apex/lwcAppExampleApex.getRelatedFilesByRecordId';
import getRelatedFilesByRecordId1 from '@salesforce/apex/lwcAppExampleApex.getRelatedFilesByRecordId1';
import {NavigationMixin} from 'lightning/navigation'

export default class DisplayContactsOnAccountName extends NavigationMixin(LightningElement) {
filesList = [];
    @track resourcesList = [];

 async connectedCallback(){
  const relatedFileResponse = await getRelatedFilesByRecordId();
  if (relatedFileResponse) {
                    console.log('hey',this.relatedFileResponse);

            this.filesList = Object.keys(relatedFileResponse).map(item => ({
                "label": relatedFileResponse[item].Name,
                "value": item,
                "url": relatedFileResponse[item].ContentDownloadUrl,
                "previewurl":relatedFileResponse[item].DistributionPublicUrl
                
            }));
            this.isDisplayFiles = true;

        }
        this.filesList.forEach((element)=>{
           
                this.resourcesList.push(element);
            
        });
 }

 @api recordId='001Ig000003lgzhIAA'
    filesList =[]
    @wire(getRelatedFilesByRecordId1, {recordId: '$recordId'})
    wiredResult({data, error}){ 
        if(data){ 
            console.log(data)
            this.filesList = Object.keys(data).map(item=>({"label":data[item],
             "value": item,
             "url":`/sfc/servlet.shepherd/document/download/${item}`
            }))
            console.log(this.filesList)
        }
        if(error){ 
            console.log(error)
        }
    }
    previewHandler(event){
        console.log(event.target.dataset.id)
        this[NavigationMixin.Navigate]({ 
            type:'standard__namedPage',
            attributes:{ 
                pageName:'filePreview'
            },
            state:{ 
                selectedRecordId: event.target.dataset.id
            }
        })
    }


//    @track currentAccountName;
//    @track searchAccountName;
//     handleChangeAccName(event){
//       this.currentAccountName = event.target.value;      
//     }

//     handleAccountSearch(){
//        this.searchAccountName = this.currentAccountName;
//        retrieveContactData({keySearch:this.searchAccountName}).then(result=>{this.records=result});
//     }
   
//     @track records;
//     @track dataNotFound;
//    // @wire (retrieveContactData,{keySearch:'$searchAccountName'})
//    /* wireRecord({data,error}){
//         if(data){           
//             this.records = data;
//             this.error = undefined;
//             this.dataNotFound = '';
//             if(this.records == ''){
//                 this.dataNotFound = 'There is no Contact found related to Account name';
//             }

//            }else{
//                this.error = error;
//                this.data=undefined;
//            }
//     }*/
}