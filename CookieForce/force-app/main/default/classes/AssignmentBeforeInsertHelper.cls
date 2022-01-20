public with sharing class AssignmentBeforeInsertHelper {
    public AssignmentBeforeInsertHelper() {
        public static void trig(List<Assignment__c> assignmentList) {
            Employee__c employee = [SELECT Name FROM Employee__c];
    
            for(Assignment__c assignment: assignmentList){
                assignment.Employee__c = employee.Name;
             }
        }
        }
    }
}
