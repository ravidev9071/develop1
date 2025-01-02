public class STP_POHistoryHelper {

    public class PurchaseOrder {
        @AuraEnabled public String PONumber { get; set; }
        @AuraEnabled public String VendorID { get; set; }
        @AuraEnabled public String CompanyCode { get; set; }
        @AuraEnabled public String Paymentterm { get; set; }
        @AuraEnabled public Decimal TotalValue { get; set; }
        @AuraEnabled public String CurrencyCode { get; set; }
        @AuraEnabled public String Status { get; set; }
        @AuraEnabled public String Remarks { get; set; }
        @AuraEnabled public String DocumentDate { get; set; }
    }

    public class PurchaseOrderWrapper {
        @AuraEnabled public List<PurchaseOrder> PurchaseOrder { get; set; }
        @AuraEnabled public String POLineItem { get; set; }
        @AuraEnabled public String Invoice { get; set; }
        @AuraEnabled public String GoodsReceipts { get; set; }

        public PurchaseOrderWrapper() {
            PurchaseOrder = new List<PurchaseOrder>();
        }
    }

    public static PurchaseOrderWrapper getMockData() {
        PurchaseOrderWrapper wrapper = new PurchaseOrderWrapper();

        PurchaseOrder po1 = new PurchaseOrder();
        po1.PONumber = 'PO12345';
        po1.VendorID = 'VEND001';
        po1.CompanyCode = 'CC123';
        po1.Paymentterm = 'NET30';
        po1.TotalValue = 5000.00;
        po1.CurrencyCode = 'USD';
        po1.Status = 'Open';
        po1.Remarks = 'Urgent order';
        po1.DocumentDate = '2025-01-02';

        PurchaseOrder po2 = new PurchaseOrder();
        po2.PONumber = 'PO67890';
        po2.VendorID = 'VEND002';
        po2.CompanyCode = 'CC456';
        po2.Paymentterm = 'NET60';
        po2.TotalValue = 7500.50;
        po2.CurrencyCode = 'EUR';
        po2.Status = 'Approved';
        po2.Remarks = 'Regular order';
        po2.DocumentDate = '2025-01-01';

        wrapper.PurchaseOrder.add(po1);
        wrapper.PurchaseOrder.add(po2);

        wrapper.POLineItem = 'Sample POLineItem Data';
        wrapper.Invoice = 'INV12345';  // Ensure Invoice is set
        wrapper.GoodsReceipts = 'Sample GoodsReceipts Data';

        return wrapper;
    }

    public static List<PurchaseOrderWrapper> fetchPODetailsHelper(String poNumber, String invoiceNumber) {
        PurchaseOrderWrapper mockData = getMockData();
        
        List<PurchaseOrderWrapper> result = new List<PurchaseOrderWrapper>();

        if (String.isNotEmpty(invoiceNumber) && invoiceNumber == mockData.Invoice) {
            List<PurchaseOrder> matchingOrders = new List<PurchaseOrder>();

            for (PurchaseOrder po : mockData.PurchaseOrder) {
                if (String.isNotEmpty(po.PONumber) && po.PONumber == poNumber) {
                    matchingOrders.add(po);
                }
            }

            if (!matchingOrders.isEmpty()) {
                PurchaseOrderWrapper wrapper = new PurchaseOrderWrapper();
                wrapper.PurchaseOrder = matchingOrders;
                wrapper.Invoice = mockData.Invoice; // Ensure Invoice is included
                result.add(wrapper);  // Add the wrapper to the result list
            }
        }

        return result;
    }
}