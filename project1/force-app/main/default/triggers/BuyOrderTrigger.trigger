trigger BuyOrderTrigger on Buy_Order__c (before update, after update) {
    
    Switch on Trigger.OperationType {
        
        when AFTER_UPDATE {
			BuyOrderTrigger_Helper.inventoryUpdate(trigger.new);
        }
	}
}