public with sharing class tournamentTriggerHelperTest {
    public tournamentTriggerHelperTest() {
        @TestSetup
    static void MakeTestData() {
	Partner__c partner = new Partner__c(Name = 'Phil', Partner_Email__c = 'foolishsamuriwarriorjeck@fools.com', Partner_Phone__c = '202-555-1234');
        insert partner;
    }
    
    
	@isTest
    public static void negativeTestCase() {
        Partner__c part = [SELECT id FROM partner__c WHERE Name = 'Phil' LIMIT 1];
        Tournament__c t = new Tournament__c(name = '5th Annual Halo Tournament', Partner__c= part.id, Tournament_Type__c = 'Halo');
        Database.saveResult save = Database.insert(T, false);
        system.assert(!save.isSuccess());
    }
    @isTest
    public static void positiveTestCase() {
        Partner__c part = [SELECT id FROM partner__c WHERE Name = 'Phil' LIMIT 1];
        Date myDate = Date.newInstance(2022, 2, 17);
        Tournament__c t = new Tournament__c(name = '5th Annual Halo Tournament', Partner__c= part.id, Tournament_Type__c = 'Halo', Start_date__c=myDate);
        Database.saveResult save = Database.insert(T, false);
        system.assert(save.isSuccess());
    }
    @isTest
    public static void bulkNegativeTestCase() {
        Partner__c part = [SELECT id FROM partner__c WHERE Name = 'Phil' LIMIT 1];
        Integer expected = 10;
        List<Tournament__c> tournamentList = new List <Tournament__c>();
        for(Integer i = 0; i < expected; i++) {
            Tournament__c t = new Tournament__c(name = '5th Annual Halo Tournament', Partner__c= part.id, Tournament_Type__c = 'Halo');
            tournamentList.add(t);
        }

        List<Database.saveResult> saveList = Database.insert(tournamentList, false);
        Integer failCounter = 0;
        for(Database.SaveResult save : saveList) {
            if(!save.isSuccess()) {
                failCounter += 1;
            }
        }

        system.assertEquals(expected, failCounter);
    }
    @isTest
    public static void bulkPositiveTestCase() {
        Partner__c part = [SELECT id FROM partner__c WHERE Name = 'Phil' LIMIT 1];
        Date myDate = Date.newInstance(2022, 2, 17);
        Integer expected = 10;
        List<Tournament__c> tournamentList = new List <Tournament__c>();
        for(Integer i = 0; i < expected; i++) {
            Tournament__c t = new Tournament__c(name = '5th Annual Halo Tournament', Partner__c= part.id, Tournament_Type__c = 'Halo', Start_date__c=myDate);
            tournamentList.add(t);
        }

        List<Database.saveResult> saveList = Database.insert(tournamentList, false);
        Integer SucessCounter = 0;
        for(Database.SaveResult save : saveList) {
            if(save.isSuccess()) {
                SucessCounter += 1;
            }
        }
        system.assertEquals(expected, SucessCounter);
    }
    }
}
