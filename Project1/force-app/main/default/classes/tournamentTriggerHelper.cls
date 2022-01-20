public with sharing class tournamentTriggerHelper {
    public static startDate(List<tournament__c> tournamentList) {
        for(Tournament__c t : tournamentList ) {
            if(t.Start_Date__c == null) {
                t.Start_Date__c.addError('Must have a Start Date!');
            }
        }
    }
}
