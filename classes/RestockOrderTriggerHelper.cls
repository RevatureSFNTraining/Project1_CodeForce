public class RestockOrderTriggerHelper {

    public static void handleTrigger(List<cF_RestockOrder__c> updateList) {
        Boolean allOrdersFulfilled = true;
        for (cF_RestockOrder__c r : updateList) {
            if (!r.Fulfilled__c) {
                allOrdersFulfilled = false;
                break;
            }
        }
        if (allOrdersFulfilled) {
            List<cF_Product__c> verifyStock = [SELECT Id, OwnerId FROM cF_Product__c WHERE Stock_Amount__c = 0];
            if (verifyStock.size() != 0) {
                List<Task> taskList = new List<Task>();
                for (cF_Product__c p : verifyStock) {
                	taskList.add(new Task(
                        Subject = 'No Active Restock', 
                        WhatId = p.Id, 
                        OwnerId = p.OwnerId, 
                        Priority = 'Normal', 
                        Status = 'Open'
                    ));
            	}
                insert taskList;
            } 
        }
    }
    
}