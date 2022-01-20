trigger AccountTrigger on Account (before update) {

    if (Trigger.isBefore && Trigger.isUpdate) {
        AccountTriggerHelper.handleTrigger(Trigger.new);
    }
    
}