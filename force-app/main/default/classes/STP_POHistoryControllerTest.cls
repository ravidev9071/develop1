@isTest
public class STP_POHistoryControllerTest {
    
    @isTest
    public static void testFetchPODetails() {
        // Test data setup
        String poNumber = 'PO12345';
        String invoiceNumber = 'INV12345';
        
        // Mock the method in STP_POHistoryHelper to test if it returns the correct PurchaseOrderWrapper
        Test.startTest();
        
        // Call the fetchPODetails method from the STP_POHistoryController
        List<STP_POHistoryHelper.PurchaseOrderWrapper> result = STP_POHistoryController.fetchPODetails(poNumber, invoiceNumber);
        
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(result, null, 'Result should not be null');
        System.assertEquals(result.size(), 1, 'Result should contain 1 matching record');
        
        STP_POHistoryHelper.PurchaseOrderWrapper wrapper = result[0];
        
        // Check if the wrapper contains the correct PO number
        System.assertEquals(wrapper.PurchaseOrder.size(), 1, 'PurchaseOrder list should have 1 record');
        
        STP_POHistoryHelper.PurchaseOrder po = wrapper.PurchaseOrder[0];
        System.assertEquals(po.PONumber, 'PO12345', 'Purchase Order number should match');
        System.assertEquals(wrapper.Invoice, 'INV12345', 'Invoice number should match');
        
        // Test with non-existing PO number
        String nonExistentPONumber = 'PO99999';
        List<STP_POHistoryHelper.PurchaseOrderWrapper> resultNotFound = STP_POHistoryController.fetchPODetails(nonExistentPONumber, invoiceNumber);
        System.assertEquals(resultNotFound.size(), 0, 'Result should be empty for non-existing PO number');
    }
    
    @isTest
    public static void testFetchPODetailsNoMatch() {
        // Test scenario where invoice number doesn't match
        String poNumber = 'PO12345';
        String wrongInvoiceNumber = 'INV99999';
        
        Test.startTest();
        
        List<STP_POHistoryHelper.PurchaseOrderWrapper> result = STP_POHistoryController.fetchPODetails(poNumber, wrongInvoiceNumber);
        
        Test.stopTest();
        
        // Assertions
        System.assertEquals(result.size(), 0, 'Result should be empty when invoice number does not match');
    }
}