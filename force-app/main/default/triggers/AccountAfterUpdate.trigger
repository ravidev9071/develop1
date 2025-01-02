trigger AccountAfterUpdate on Account (after update) {
    if(Trigger.isUpdate){
        if(Trigger.isAfter){
            AccountTriggerHandler1.handleAfterUpdate(Trigger.new);
        }
    }
}