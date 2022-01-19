@isTest
public class CustomerTrigger_Helper_Test {
    
    //Could not figure out how to create a customer programmatically. Line 13 always shows an error
    //I decided to write the code anyway

    //creating data for testing
	@testSetup
    static void testData(){
        Individual individual = new Individual (lastName = 'test');
       	insert individual;
        Individual indi = [SELECT id FROM Individual WHERE Name = 'test'];
        Customer cust = new Customer (Party = indi, Name = 'test user', Phone_Number__c = '1234567890', Address__c = '123 test st testcity Illinois 12345', E_mail_address__c = 'test2@test.com');
        insert cust;
    }
    
    //testing if one record is successful
    @isTest
    public static void positiveTest() {
        //creating a list to hold test customer records
        List<Customer> cList = new List<Customer>();
        //creating the test records
        Individual ind = new Individual (lastName = 'test');
        insert ind; 
        Customer c = new Customer (Party = ind, Name = 'test user2', Phone_Number__c = '1234567890', Address__c = '123 test st testcity Illinois 12345', E_mail_address__c = 'test@test.com');
        cList.add(c);
        //running the trigger
        CustomerTrigger_Helper.existingCustomerCheck(cList);
        //Retrieving the number of customer records where the email address = test@test.com and checking it against the expected value
        List<Customer> customer = [SELECT name FROM Customer WHERE E_mail_address__c = 'test@test.com'];
        Integer check = customer.size();
        System.assertEquals(check, 1);
    }
    
    //testing to see if trigger runs unexpectedly
    @isTest
    public static void negativeTest() {
        //creating a list to hold test customer records
        List<Customer> cList = new List<Customer>();
        //creating the test records
        Customer c = new Customer (Name = 'test user2', Phone_Number__c = '1234567890', Address__c = '123 test st testcity Illinois 12345', E_mail_address__c = 'test@test.com');
        cList.add(c);
        //running the trigger
        CustomerTrigger_Helper.existingCustomerCheck(cList);
        //Retrieving the number of customer records where the email address = test@test.com and checking it against the expected value
        List<Customer> customer = [SELECT name FROM Customer WHERE E_mail_address__c = 'test@test.com'];
        Integer check = customer.size();
        System.assertNotEquals(check, 2);
    }
    
    //testing to see if 100 records can be processed and stopped
    @isTest
    public static void positiveBulkTest() {
        //create a list to hold all the customers
        List<Customer> cList = new List<Customer>();
        //trying to create 100 customer records with the same email address
        for (Integer i = 0; i < 100; i++) {
            String s = 'test user' + i;
            Customer cust = new Customer (Name = s, Phone_Number__c = '1234567890', Address__c = '123 test st testcity Illinois 12345', E_mail_address__c = 'test@test.com');
            cList.add(cust);
        }
        //running the trigger
        CustomerTrigger_Helper.existingCustomerCheck(cList);
        //Retrieving the number of customer records where the email address = test@test.com and checking it against the expected value
		List<Customer> cList2 = [SELECT name FROM Customer WHERE E_mail_address__c = 'test@test.com'];
        Integer check = cList2.size();
        System.assertEquals(check, 1);
    }
    
    //User privilege test
    @isTest
    public static void userTest() {
        // Create a unique UserName
        String uniqueTestName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        Profile p = [SELECT Id FROM Profile WHERE Name='Chatter External User'];
        User u = new User(Alias = 'test', Email='testuser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Chicago',
         UserName=uniqueTestName);
        
        //test to check whether an unauthorized user can access Customer
        System.runAs(u) {
            try {
            List<Customer> customer = [SELECT name FROM Customer WHERE E_mail_address__c = 'test@test.com'];
            }
            catch (exception e) {
                System.debug('User test failed successfully');
            }
        }
    }
}