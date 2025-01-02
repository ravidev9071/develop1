public class STP_POHistoryController {

    // Apex method to fetch details by PONumber and Invoice
    @AuraEnabled(cacheable=true)
    public static List<STP_POHistoryHelper.PurchaseOrderWrapper> fetchPODetails(String poNumber, String invoiceNumber) {
        return STP_POHistoryHelper.fetchPODetailsHelper(poNumber, invoiceNumber);
    }
}