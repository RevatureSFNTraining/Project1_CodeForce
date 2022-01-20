@isTest
public with sharing class PartnerTriggerHelper2Test {
    @TestSetup
    static void MakeTestData() {
    }
    
    
	@isTest
    public static void negativeTestCase() {
	    Partner__c partner = new Partner__c(Name = 'Phil');
        Database.saveResult save = Database.insert(partner, false);
        system.assert(!save.isSuccess());
    }
    @isTest
    public static void positiveTestCase() {
        Partner__c partner = new Partner__c(Name = 'Phil', Partner_Email__c = 'foolishsamuriwarriorjeck@fools.com', Partner_Phone__c = '202-555-1234');
        Database.saveResult save = Database.insert(partner, false);
        system.assert(save.isSuccess());
    }
    @isTest
    public static void bulkNegativeTestCase() {
        Integer expected = 5;
        List<Partner__c> PartnerList = new List <Partner__c>();
        for(Integer i = 0; i < expected; i++) {
            Partner__c partner = new Partner__c(Name = 'Phil', Partner_Phone__c = '202-555-1234');
            PartnerList.add(partner);
            partner = new Partner__c(Name = 'Phil', Partner_Email__c = 'foolishsamuriwarriorjeck@fools.com');
            PartnerList.add(partner);
        }
		
        List<Database.saveResult> saveList = Database.insert(PartnerList, false);
        Integer failCounter = 0;
        expected*=2;
        for(Database.SaveResult save : saveList) {
            if(!save.isSuccess()) {
                failCounter += 1;
            }
        }

        system.assertEquals(expected, failCounter);
    }
    @isTest
    public static void bulkPositiveTestCase() {
        Integer expected = 10;
        List<Partner__c> PartnerList = new List <Partner__c>();
        for(Integer i = 0; i < expected; i++) {
            Partner__c partner = new Partner__c(Name = 'Phil', Partner_Email__c = 'foolishsamuriwarriorjeck@fools.com', Partner_Phone__c = '202-555-1234');
            PartnerList.add(partner);
        }

        List<Database.saveResult> saveList = Database.insert(PartnerList, false);
        Integer SucessCounter = 1;
        for(Database.SaveResult save : saveList) {
            if(!save.isSuccess()) {
                SucessCounter += 1;
            }
        }

        system.assertEquals(expected, SucessCounter);
    }
}
}
