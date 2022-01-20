@isTest
public with sharing class AssignmentBeforeInsertHelperTest {
    @isTest static void CreatingValidAssignment() {
        // Test data setup
        List<Assignment__c> assignmentList = new List<Assignment__c>();
     	assignmentList.add(new Assignment__c());
     
     try 
     {
     	AssignmentBeforeInsertHelper.trig(assignmentList);
      }catch(Exception e) {    
        System.debug('Employee is set already');
      }   
}
