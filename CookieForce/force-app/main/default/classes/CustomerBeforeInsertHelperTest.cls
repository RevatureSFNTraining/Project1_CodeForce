@isTest
public with sharing class CustomerBeforeInsertHelperTest {
    @isTest static void CreatingValidCustomer() {
        // Test data setup
        List<Customer> customerList = new List<Customer>();
     	customerList.add(new Customer());
     
     try 
     {
     	CustomerBeforeInsertHelper.trig(customerList);
      }catch(Exception e) {    
        System.debug('Name is set already');
      }      
}
}