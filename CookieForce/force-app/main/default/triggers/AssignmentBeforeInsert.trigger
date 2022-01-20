trigger AssignmentBeforeInsert on Assignment__c (before insert) {
    // Trigger.New hold new version of Assignments
    AssignmentBeforeInsertHelper.trig(Trigger.new);
}