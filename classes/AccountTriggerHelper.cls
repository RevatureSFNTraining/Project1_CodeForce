public class AccountTriggerHelper {

    public static void handleTrigger(List<Account> updateList) {
        for (Account a : updateList) {
            if (a.cF_ActiveTransaction__c && a.BillingAddress == null) {
                a.addError('Cannot have empty Billing Address for Transactions');
            }
        }
    }
    
}