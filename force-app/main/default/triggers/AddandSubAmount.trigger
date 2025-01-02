trigger AddandSubAmount on Opportunity (after insert,after update) {

    if((trigger.isAfter&&trigger.isInsert)||(trigger.isAfter&&trigger.isupdate)){
        OpportunityandAccount.AddAmount(trigger.new);
    }
    
    
}