trigger classValidation on Diving_Class__c (before insert) {
    /* SOQL query for every meeting time, divide list by instructor */

    List<Diving_Class__c> currentClasses = [SELECT Instructor__c,Meeting_Time__c FROM Diving_Class__c];
    Map<Id, List<Diving_Class__c>> mCurrent = new Map<Id, List<Diving_Class__c>>();

    for (Instructor__c instructor : [SELECT Id FROM Instructor__c]) {

        List<Diving_Class__c> appendMap = new List<Diving_Class__c>();

        for (Diving_Class__c currentClass : currentClasses) {
            if (instructor.Id == currentClass.Instructor__c) {
                appendMap.add(currentClass);
            }
        }
        mCurrent.put(instructor.Id, appendMap);
    }


    for (Diving_Class__c newClass : trigger.new) {
        /* if there is NO class at the same time, append it to the mC map! if there is, do NOT append it and addError. This ensures the other classes being added also don't cause trouble */
        Boolean ErrorAdded = false;


        for (Diving_Class__c Match : mCurrent.get(newClass.Instructor__c)) {
            if (newClass.Meeting_Time__c == Match.Meeting_Time__c) {
                newClass.addError('There is already a class with this meeting time in the system!');
                ErrorAdded = true;
                break;
            }
        }

        if (ErrorAdded == false) {
            List<Diving_Class__c> newAppend = mCurrent.get(newClass.Instructor__c);
            newAppend.add(newClass);
            mCurrent.put(newClass.Instructor__c, newAppend);
        }
    }

}