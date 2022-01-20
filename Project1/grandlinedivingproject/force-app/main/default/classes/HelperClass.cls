public with sharing class HelperClass {
/*public createObjects (Number of Instructors, Number of Classes, Hour Class Interval) */
    @TestVisible public static List<Diving_Class__c> createClasses(Integer a, Integer b, Datetime z, Integer c) {
        List<Diving_Class__c> testClasses = new List<Diving_Class__c>();

        /* creates 5 classes per instructor each 2 hours apart */ 
        for (Instructor__c instructor : [SELECT Id,Name FROM Instructor__c LIMIT :a]) {

            Datetime classTime = z;

            for(Integer x=0;x<b;x++) {
                testClasses.add( new Diving_Class__c( Instructor__c = instructor.id, Meeting_Time__c = classTime, Equipment_Needed__c = 'Dive Bag' ));
                classTime = classTime.addHours(c);
            }
        }
        
        return testClasses;


    }
}
