public class StoreLocTriggerHelper {

    public static void handleTrigger(List<cF_StoreLocation__c> newInput) {
        User u = [SELECT Id, Name FROM User WHERE Name = 'Scott Scott' LIMIT 1];
        List<cF_StoreLocation__c> defaultManagerList = new List<cF_StoreLocation__c>();
        for (cF_StoreLocation__c s : newInput) {
            if (s.StoreManagerName__c == null) {
                s.StoreManagerName__c = u.Name;
                defaultManagerList.add(s);
            }
        }
        //insert defaultManagerList;
    }
}
