@isTest
public class RestockOrderTriggerTest {

    @isTest
    public static void testTaskCreationPositive() {
        Contact c = new Contact(FirstName = 'Mr', LastName = 'Test');
        List<cF_RestockOrder__c> r = new List<cF_RestockOrder__c>();
        r.add(new cF_RestockOrder__c(Name = 'RestockTest', Contact__c = c.Id, Fulfilled__c = true));
        
        RestockOrderTriggerHelper.handleTrigger(r);
        Integer t = [SELECT COUNT() FROM Task];
        System.AssertEquals(t, 0);
    }
    
    @isTest
    public static void testTaskCreationNegative() {
        Contact c = new Contact(FirstName = 'Mr', LastName = 'Test');
        List<cF_RestockOrder__c> r = new List<cF_RestockOrder__c>();
        r.add(new cF_RestockOrder__c(Name = 'RestockTest', Contact__c = c.Id, Fulfilled__c = true));
        
        cF_Product__c p = new cF_Product__c(Name = 'TestGame', Stock_Amount__c = 0);
        insert p;
        
        RestockOrderTriggerHelper.handleTrigger(r);
        Integer t = [SELECT COUNT() FROM Task];
        System.AssertNotEquals(t, 0);
    }
    
}