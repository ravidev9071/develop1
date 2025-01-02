import { LightningElement } from 'lwc'
import qrcode from './qrcode.js'

export default class QrCodeGeneration extends LightningElement {
  renderedCallback () {
    const qrCodeGenerated = new qrcode(0, 'H')
    let hey = 'Hey , Good Morning friends. \n'
    let ravi = 'Ravi this side.\n'
    let create =
      'Today , I have created qr scanner using lwc component in salesforce.\n'
    qrCodeGenerated.addData(hey)
    qrCodeGenerated.addData(ravi)
    qrCodeGenerated.addData(create)

    qrCodeGenerated.make()
    let element = this.template.querySelector('.qrcode2')
    element.innerHTML = qrCodeGenerated.createSvgTag({})
  }
}