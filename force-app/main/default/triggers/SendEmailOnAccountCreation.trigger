trigger SendEmailOnAccountCreation on Account (after insert) {
    // Call the utility class to send emails for the newly created Accounts
   // SendEmailUtil.sendEmail(Trigger.new);
}