// lwcinputs.js
import { LightningElement, wire, track } from 'lwc'
import deserialized from '@salesforce/apex/deserializedApexTest.deserialized'
export default class Lwcinputs extends LightningElement {
  @track allcountrydata
  @track local
  @track c
  arrayvar = []
  @wire(deserialized) countrydata ({ data }) {
    if (data) {
      this.c = data
      this.allcountrydata = data.map((name, index) => {
        return { name, sno: index + 1 }
      })
    }
  }
}