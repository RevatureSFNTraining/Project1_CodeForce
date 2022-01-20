trigger tournamentTrigger on SOBJECT (before insert, before update) {
    Switch on Trigger.OperationType {
        when BEFORE_INSERT {
            TournamentTriggerHelper.startDate(Trigger.new);
            
        } 
        when BEFORE_UPDATE {
			TournamentTriggerHelper.startDate(Trigger.new);
        }
    }
}