import { LightningElement, track, api } from 'lwc';
export default class PaiSky_PharmacyLookUpPagination extends LightningElement {
    currentPage = 1
    totalRecords
    @api recordSize
    totalPages = 0

    get records() {
        return this.visibleRecords
    }
    @api
    set records(data) {
        if (data) {
            console.log('data:::'+data);
            this.totalRecords = data
            this.recordSize = Number(this.recordSize)
            this.totalPages = Math.ceil(data.length / this.recordSize)
            this.updateRecords()
        }

    }

    get disablePrevious() {
        return this.currentPage <= 1
    }
    get disableNext() {
        return this.currentPage >= this.totalPages
    }
    previousHandler() {
        if (this.currentPage > 1) {
            this.currentPage = this.currentPage - 1
            this.updateRecords()
        }
    }
    nextHandler() {
        if (this.currentPage < this.totalPages) {
            this.currentPage = this.currentPage + 1
            this.updateRecords()
        }
    }
    lastHandler() {
        if (this.currentPage < this.totalPages) {
            this.currentPage = this.totalPages
            this.updateRecords()
        }
    }
    firstHandler() {
        if (true) {
            this.currentPage = 1;
            this.updateRecords()
        }
    }
    numberHandler(event) {
        if (true) {
            this.currentPage = event.target.label;
            console.log(this.currentPage)
            console.log(event.target.label)


            this.updateRecords()
        }
    }
    updateRecords() {
        const start = (this.currentPage - 1) * this.recordSize
        const end = this.recordSize * this.currentPage
        this.visibleRecords = this.totalRecords.slice(start, end)
        this.dispatchEvent(new CustomEvent('update', {
            detail: {
                records: this.visibleRecords
            }
        }))
    }
}