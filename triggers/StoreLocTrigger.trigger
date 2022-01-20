trigger StoreLocTrigger on cF_StoreLocation__c (before insert) {

    if (Trigger.isBefore && Trigger.isInsert) {
        StoreLocTriggerHelper.handleTrigger(Trigger.new);
    }
    
}