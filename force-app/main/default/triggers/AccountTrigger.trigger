trigger AccountTrigger on Account (before insert, before update) {
    if (TriggerControl.isTriggerDisabled) {
        // Skip the trigger logic
        return;
    }

    // Trigger logic here
    for (Account acc : Trigger.new) {
        acc.Description = 'Updated by Trigger';
    }
}