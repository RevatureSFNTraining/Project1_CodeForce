@isTest
public class StoreLocTriggerTest {

    @isTest
    public static void testFieldUpdate() {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'cF_Employee' LIMIT 1];
        User u = new User(
			Alias = 'TestUser',
			Email = '123@test.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Test',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'BaileyKTestUser@codeForce.com'
		);
        List<cF_StoreLocation__c> loc = new List<cF_StoreLocation__c>();
        loc.add(new cF_StoreLocation__c(Name = 'TestLoc'));
        
        System.runAs(u) {
            try {
                StoreLocTriggerHelper.handleTrigger(loc);
            }catch(Exception e) {
                System.debug('Invalid User for Record Creation');
            }            
        }
    }
}