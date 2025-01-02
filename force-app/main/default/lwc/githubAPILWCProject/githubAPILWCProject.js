import { LightningElement, track, wire } from 'lwc'
import Getgithub from '@salesforce/apex/githubapitest.Getgithub'
import DeleteRepo from '@salesforce/apex/githubapitest.DeleteRepo'
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { refreshApex } from '@salesforce/apex'
import createRep from '@salesforce/apex/githubapitest.createRep'
import UpdateRep from '@salesforce/apex/githubapitest.UpdateRep'
import getPathNameMethod from '@salesforce/apex/githubapitest.getPathNameMethod'
import getContent from '@salesforce/apex/githubapitest.getContent'
export default class GithubAPILWCProject extends LightningElement {
  @track abc
  @track isShowModal = false
  @track namedata
  @track namedescri
  @track deleterep1
  @track option
  @track getpathname
  @track rdesr
  @track rnam
  @track finalcontent;
  @wire(getPathNameMethod) getPath ({ data, error }) {
    if (data) {
      this.getpathname = data
    }
  }

  showModalBox () {
    this.isShowModal = true
    this.showbutton = true
    this.rdesr='';
    this.rnam='';


  }

  hideModalBox () {
    this.isShowModal = false
  }
  @wire(Getgithub) gitdata
  handleOnClick (event) {
    // const deleterep = event.target.title
    const deleterep = this.deleterep1
    //alert(deleterep)
    if (deleterep != undefined) {
      DeleteRepo({ deleterep })
        .then(() => {
          const toastEvent = new ShowToastEvent({
            title: 'Success!',
            message: 'Record deleted successfully',
            variant: 'success'
          })
          this.dispatchEvent(toastEvent)
          this.isShowModal1 = false
          return refreshApex(this.gitdata)
        })
        .catch(error => {
          this.errorMsg = error
          window.console.log(
            'unable to delete the record due to ' +
              JSON.stringify(this.errorMsg)
          )
        })
    }
  }
  changeHandler (event) {
    if (event.target.value != undefined) this.option = event.target.value
    else this.option = false
  }
  namechange (event) {
    this.namedata = event.target.value
  }
  namedes (event) {
    this.namedescri = event.target.value
  }
  CreateRepo (event) {
    this.showbutton = true
    const rname = this.namedata
    const rdes = this.namedescri
    var opt
    if (this.option != undefined) {
      opt = this.option
    } else {
      opt = false
    }
    alert(opt)
    if (rname != null && rdes != null)
      createRep({ rname, rdes, opt }).then(() => {
        this.isShowModal = false

        return refreshApex(this.gitdata)
      })
  }

  @track isShowModal1 = false

  showModalBox1 (event) {
    //alert(this.deleterep1)
    this.deleterep1 = event.target.title
    this.isShowModal1 = true
  }

  hideModalBox1 () {
    this.isShowModal1 = false
  }
  Updatehandle (event) {
  
    this.deleterep1 = event.target.title
    this.rnam=event.target.name;
    this.rdesr=event.target.value;
//alert(this.rnam+'::::::test:::::'+this.rdesr);
    this.isShowModal = true
    this.showbutton = false
  }
  Updaterepohandle () {
    const rname = this.namedata
    const rdes = this.namedescri
    var opt
    if (this.option != undefined) {
      opt = this.option
    } else {
      opt = false
    }
    const dele = this.deleterep1
    if (rname != null && rdes != null)
      UpdateRep({ rname, rdes, opt, dele }).then(() => {
        this.isShowModal = false

        return refreshApex(this.gitdata)
      })
  }
  handleanchor (event) {
    //alert(event.currentTarget.dataset.name)
    const path = event.currentTarget.dataset.name
    getContent({ path }).then(result => {
      this.finalcontent=result;
    })
  }
}