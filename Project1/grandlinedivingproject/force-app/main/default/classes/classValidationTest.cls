@isTest
public class classValidationTest {
    /* notes: Instructor and Class Time are required f ields before Class Creation
    Test Coverage: 100% */ 

    @TestSetup
    static void makeData(){
        /* create Instructors, 5
        create Classes per Instructor, 20 */
        List<Instructor__c> testInstructors = new List<Instructor__c>();
        List<Diving_Class__c> testClasses = new List<Diving_Class__c>();

        for(Integer i=0;i<5;i++) {
            testInstructors.add(new Instructor__c(Name = 'TestAcct'+i));   
        }
        insert testInstructors;

        /* creates 5 classes per instructor each 2 hours apart */ 
        for (Instructor__c instructor : [SELECT Id,Name FROM Instructor__c]) {
            Datetime classTime = datetime.newInstance(2022, 9, 15, 12, 30, 0);

            for(Integer x=0;x<5;x++) {
                testClasses.add( new Diving_Class__c( Instructor__c = instructor.id, Meeting_Time__c = classTime, Equipment_Needed__c = 'Dive Bag' ));
                classTime = classTime.addHours(2);
            }
        }
        
        insert testClasses;

    }

    /*Class not at the same time*/ 
    @isTest
    public static void positiveTest() {
        /* creates a SINGLE class at the same time as another */

        List<Diving_Class__c> Dclass = HelperClass.createClasses(1, 1, datetime.newInstance(2022, 9, 15, 12, 30, 0), 0);

        Diving_Class__c positiveTest = Dclass[0];
        
        Test.startTest();
        Database.SaveResult result = Database.insert(positiveTest, false);
        Test.stopTest();

        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('There is already a class with this meeting time in the system!',
                             result.getErrors()[0].getMessage());

    }

     /* Class not at the same time */ 
     @isTest
     public static void negativeTest() {

        List<Diving_Class__c> Dclass = HelperClass.createClasses(1, 1, datetime.newInstance(2022, 9, 16, 12, 30, 0), 0);

        Diving_Class__c positiveTest = Dclass[0];
        
        Test.startTest();
        Database.SaveResult result = Database.insert(positiveTest, false);
        Test.stopTest();

        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);

     }

     @isTest
     public static void bulkTest() {

        List<Diving_Class__c> Dclass = HelperClass.createClasses(5, 5, datetime.newInstance(2022, 9, 15, 12, 30, 0), 2);
    
        Test.startTest();
        Database.SaveResult[] results = Database.insert(Dclass, false);
        Test.stopTest();

        Integer Counter = 1;

        for (Database.SaveResult sr : results) {
                System.assert(!sr.isSuccess());
                System.assert(sr.getErrors().size() > 0);
                System.assertEquals('There is already a class with this meeting time in the system!',
                                         sr.getErrors()[0].getMessage());

        }

     }

    // @isTest
    // public static void permissionTest() {

    // }



}
