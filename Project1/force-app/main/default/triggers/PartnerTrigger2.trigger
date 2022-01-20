trigger PartnerTrigger2 on SOBJECT (before insert, before update) {
    Switch on Trigger.OperationType {
        when BEFORE_INSERT {
            PartnerTriggerHelper2.CheckFields(Trigger.new);
            
        } 
        when BEFORE_UPDATE {
			PartnerTriggerHelper2.CheckFields(Trigger.new);
        }
    }
}