public class MyFlowApexClass {
    @InvocableMethod
    public static void myMethod(List<String> inputStrings) {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
   message.setTargetObjectId('003Ig0000048ahVIAQ'); 
   
   message.setReplyTo('no-reply@company.com');
   message.setUseSignature(false); 
   message.setBccSender(false); 
   message.setSaveAsActivity(false); 
  EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where developerName = 'SOP_template_1728478241471'];
  message.setTemplateID(emailTemplate.Id); 
  message.setWhatId('00QIg000001h88RMAQ'); //This is important for the merge fields in template to work
  message.toAddresses = new String[] { 'ravi907171@gmail.com'};
  Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
  Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
 
 if (results[0].success) 
 {
   System.debug('The email was sent successfully.');
 } else {
   System.debug('The email failed to send: ‘ +  results[0].errors[0].message');
 }
    }
}