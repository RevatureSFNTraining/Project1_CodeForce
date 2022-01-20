trigger classesAttendet on Class_Reservation__c (before delete) {

    List<Id> IdList = new List<Id>();

    for ( Class_Reservation__c r : trigger.old) {
        IdList.add(r.Students__c);
    }


    List<Account> UpdateAcc = [SELECT Courses_Taken__c FROM Account WHERE Id IN :IdList];

    for (Account acc : UpdateAcc){

        acc.Courses_Taken__C += 1;
    }

    update UpdateAcc;

}