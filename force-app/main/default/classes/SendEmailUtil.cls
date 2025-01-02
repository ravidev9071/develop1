public without sharing class SendEmailUtil {
    
    public static void sendEmail(List<Account> accounts) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        // Loop through each Account and create an email message
        for (Account acc : accounts) {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setTargetObjectId('00QIg000001h83QMAQ'); 
            
            message.setReplyTo('no-reply@company.com');
            message.setUseSignature(false); 
            message.setBccSender(false); 
            message.setSaveAsActivity(false); 
            EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where developerName = 'PiaSky_Pharmacy_Staff_Invitation_VF'];
            message.setTemplateID(emailTemplate.Id); 
            message.setWhatId(acc.Id); //This is important for the merge fields in template to work
            message.toAddresses = new String[] { acc.Email__c};
                Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            
            
        }
        

    }}