@isTest
public class AccountTriggerTest {

    @isTest
    public static void testUpdateValidationSingle() {
        List<Account> a = new List<Account>();
        a.add(new Account(Name = 'MrTest', cF_ActiveTransaction__c = true));
        
        try {
            AccountTriggerHelper.handleTrigger(a);
        }catch(Exception e) {
            System.debug('Validation Failed: No Billing Address');
        }        
    }
    
    @isTest
    public static void testUpdateValidationBulk() {
        List<Account> a = new List<Account>();
        Boolean toggle = true;
        for (Integer i = 0; i < 20; i++) {
            a.add(new Account(Name = 'MrTest' + i, cF_ActiveTransaction__c = toggle));
            toggle = !toggle;
        }
        
		try {
            AccountTriggerHelper.handleTrigger(a);
        }catch(Exception e) {
            System.debug('Validation Failed: No Billing Address');
        }        
    }
    
}