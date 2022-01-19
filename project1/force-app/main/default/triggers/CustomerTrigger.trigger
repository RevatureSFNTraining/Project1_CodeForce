trigger CustomerTrigger on Customer (before insert) {
    
    Switch on Trigger.OperationType {
        
        when BEFORE_INSERT {
			CustomerTrigger_Helper.existingCustomerCheck(trigger.new);
        }
    }
}