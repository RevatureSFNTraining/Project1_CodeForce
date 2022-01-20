trigger CustomerBeforeInsert on Customer (before insert) {
    // Trigger.New hold new version of Contacts
    CustomerBeforeInsertHelper.trig(Trigger.new);
}