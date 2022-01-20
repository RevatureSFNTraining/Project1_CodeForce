trigger RestockOrderTrigger on cF_RestockOrder__c (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {
        RestockOrderTriggerHelper.handleTrigger(Trigger.new);
    }
    
}