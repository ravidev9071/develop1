import { LightningElement, track, wire, api } from 'lwc'
import getObjectList from '@salesforce/apex/getAllObject.getObjectList'
import getContactFields from '@salesforce/apex/getAllObject.getContactFields'
import getRecord from '@salesforce/apex/getAllObject.getRecord'

export default class MultiSelectPickLIstInLWC extends LightningElement {
  @track options = []
  @track ObjName
  @api myobjectName
  @track option = []
  @wire(getObjectList) getObj ({ error, data }) {
    if (data) {
      let picklistOptions = [{ label: '--None--', value: '--None--' }]

      var conts = data
      for (var key in conts) {
        //console.log('key:::'+key+'value:::'+conts[key]);

        picklistOptions.push({
          label: key,
          value: conts[key]
        })
        this.options = picklistOptions
      }
      // console.log(picklistOptions);
    }
  }

  handleChange (event) {
    this.myobjectName = event.detail.value

    const objName = event.detail.value

    //  console.log(objName);

    getContactFields({ objName }).then(result => {
      console.log(result)
      let picklistOptions1 = [{ label: '--None--', value: '--None--' }]
      var abc = result
      for (var key in abc) {
        console.log(abc[key])
        picklistOptions1.push({
          label: abc[key],
          value: abc[key]
        })
        this.option = picklistOptions1
      }
    })
  }

  selectedVal = []

  /*get option() {
        return [
            { label: 'Salesforce LWC', value: 'Salesforce LWC' },
            { label: 'Aura Component', value: 'Aura Component' },
            { label: 'Visualforce Page', value: 'Visualforce Page' },
            { label: 'Apex Trigger', value: 'Apex Trigger' },
            { label: 'Javascript and JQuery', value: 'Javascript and JQuery' },
            { label: 'W3web Tutorial', value: 'W3web Tutorial' },
        ];
    }*/

  get selected () {
    return this.selectedVal.length ? this.selectedVal : 'none'
  }

  handleChange1 (e) {
    this.selectedVal = e.detail.value
    //alert(this.selectedVal);
  }
  employeeColumns = []
  employeeData = []
  handleOnClick () {
   /* this.employeeColumns = [
            { label: 'Id', fieldName: 'Id' },
            { label: 'Name', fieldName: 'Name' },
            { label: 'Phone', fieldName: 'Phone' },
            {label:'Website',fieldName:'Website'}
            
        ];*/
    const fieldName = this.selectedVal;
    // console.log(fieldName);

    let picklistOptions3 = [] // [{ label: '', value: ''}];
    var abc11 = fieldName
    for (var key in abc11) {
      // console.log(abc11[key]);
    picklistOptions3.push({
        label: abc11[key],
        fieldName: abc11[key]
    })
    }
    this.employeeColumns = picklistOptions3;
console.log('sher::'+JSON.stringify(this.employeeColumns));
    /*this.employeeData = [
            {
                employeeId: '1',
                firstName: 'Richard',
                lastName: 'Hendricks',
                employeePhone: '(158) 389-2794',
                employeeEmail: 'richard@piedpiper.com'
            },
            {
                employeeId: '2',
                firstName: 'Jared',
                lastName: 'Dunn',
                employeePhone: '(518) 390-2749',
                employeeEmail: 'jared@piedpiper.com'
            },
            {
                employeeId: '3',
                firstName: 'Erlich',
                lastName: 'Bachman',
                employeePhone: '(815) 391-2974',
                employeeEmail: 'erlich.bachman@piedpiper.com'
            }
        ];*/

    getRecord({ fieldName, myobjectName: this.myobjectName }).then(result => {
    console.log('--account data--'+JSON.stringify(result));
    console.log('--account data new--'+result[0].Name);
const mylwc=JSON.stringify(result);
        this.employeeData=result;

    })
}
}