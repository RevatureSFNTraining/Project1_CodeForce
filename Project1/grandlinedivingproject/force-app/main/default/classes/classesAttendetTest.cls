@isTest
public class classesAttendetTest {

    @TestSetup
    static void makeData(){
        List<Instructor__c> testInstructors = new List<Instructor__c>();
        List<Account> testAccts = new List<Account>();
        List<Class_Reservation__C> resv = new List<Class_Reservation__C>();
        
        for(Integer i=0;i<5;i++) {
            testInstructors.add(new Instructor__c(Name = 'TestAcct'+i));   
        }

        insert testInstructors;

        List<Diving_Class__c> Dclass = HelperClass.createClasses(1, 1, datetime.newInstance(2022, 9, 15, 12, 30, 0), 0);

        insert Dclass;

        Diving_Class__c oneClass = [Select Id FROM Diving_Class__c LIMIT 1];

        for(Integer x=0;x<5;x++) {
            testAccts.add(new Account(Name = 'Test Account', Courses_Taken__C = 0));
            
        }

        insert testAccts;

        for (Account i : [SELECT Id FROM Account]) {
            resv.add(new Class_Reservation__C(Students__C = i.Id, Classes__C = oneClass.Id));
        }

        insert resv;
    }

    @isTest
    public static void positiveTest() {
        /* creates a SINGLE class at the same time as another */

        Class_Reservation__C positiveTest = [SELECT Id,Students__c FROM Class_Reservation__c LIMIT 1];

        Test.startTest();
        Database.DeleteResult result = Database.delete(positiveTest, false);
        Test.stopTest();

        Account testing = [SELECT Courses_Taken__c FROM Account WHERE Id = :positiveTest.Students__c ];

        System.assertEquals(1, testing.Courses_Taken__c);

    }

    @isTest
    public static void bulkTest() {

        List<Class_Reservation__C> positiveTest = [SELECT Students__c FROM Class_Reservation__c LIMIT 3];

    
        Test.startTest();
        Database.DeleteResult[] results = Database.delete(positiveTest, false);
        Test.stopTest();

        Integer total = 0;

        for (Account accs : [SELECT Courses_Taken__c FROM Account]) {
            if (accs.Courses_Taken__c == 1) {
                total += 1;
            }
        }

        System.assertEquals(3, total);

      }
}
