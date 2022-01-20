public with sharing class PartnerTriggerHelper2 {
    public static void CheckFields(List<Partner__c> partnerList) {
        for (Partner__c p : partnerList) {
            if (p.Partner_Email__c == null) {
                p.addError('E-mail address Required');
            }
        if (p.Partner_Phone__c == null) {
            p.addError('Phone number is Required');
            }
        }
    }
}
