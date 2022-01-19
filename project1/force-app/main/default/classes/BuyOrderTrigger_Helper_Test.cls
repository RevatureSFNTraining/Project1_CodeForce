@isTest
public class BuyOrderTrigger_Helper_Test {

	//creating data for testing
	@testSetup
    static void testData() {
        Buy_Order__c order = new Buy_Order__c (Product_Name__c = '4 ft duct', Product_Cost__c = 1, Quantity__c = 5, Delivered__c = true);
    	insert order;
        
        //initialize our inventory
        Inventory__c i = new Inventory__c (name = 'test', X4_ft_duct__c = 5, X8_ft_duct__c = 6, Plastic_Bird_Guard__c = 7, Steel_Bird_Guard__c = 8, transition_duct__c = 9);
        insert i;
        }  
    
    //testing if one record is successful
    @isTest
    public static void positiveTest() {
        //creating a record from test data
        Buy_Order__c o = new Buy_Order__c (Product_Name__c = '4 ft duct', Product_Cost__c = 1, Quantity__c = 5, Delivered__c = false);
        //running the trigger
        insert o;
        o.Delivered__c = true;
        update o;
        //retrieving the new inventory after the trigger is done
        Inventory__c inv = [SELECT X4_ft_duct__c FROM Inventory__c WHERE name = 'test'];
        //variable used to store the new inventory value
        Double q = inv.X4_ft_duct__c;
        //testing our inventory value against the expected value
        System.assertEquals(q, 10);
        }
    
    //testing if 400 records with different picklist values are successful
    @isTest
    public static void positiveBulkTest() {
        //creating our records
        List<Buy_Order__c> bList = new List<Buy_Order__c>();
            for (Integer i = 0; i < 100; i++) {
            Buy_Order__c b = new Buy_Order__c (Product_Name__c = '8 ft duct', Product_Cost__c = 2, Quantity__c = 5, Delivered__c = true);
            bList.add(b);
        }
        for (Integer i = 0; i < 100; i++) {
            Buy_Order__c b = new Buy_Order__c (Product_Name__c = 'transition duct', Product_Cost__c = 2, Quantity__c = 5, Delivered__c = true);
            bList.add(b);
        }
        for (Integer i = 0; i < 100; i++) {
            Buy_Order__c b = new Buy_Order__c (Product_Name__c = 'Plastic bird guard', Product_Cost__c = 2, Quantity__c = 5, Delivered__c = true);
            bList.add(b);
        }
        for (Integer i = 0; i < 100; i++) {
            Buy_Order__c b = new Buy_Order__c (Product_Name__c = 'Metal bird guard', Product_Cost__c = 2, Quantity__c = 5, Delivered__c = true);
            bList.add(b);
        }
        //running the trigger
        BuyOrderTrigger_Helper.inventoryUpdate(bList);
        //retrieving the new inventory after the trigger is done
        Inventory__c inv = [SELECT X8_ft_duct__c, Plastic_Bird_Guard__c, Steel_Bird_Guard__c, transition_duct__c FROM Inventory__c WHERE name = 'test'];
        //variable used to store the new inventory value
        Double q = inv.X8_ft_duct__c;
        Double r = inv.Plastic_Bird_Guard__c;
        Double s = inv.Steel_Bird_Guard__c;
        Double t = inv.transition_duct__c;
        //testing our inventory value against the expected value
        System.assertEquals(q, 506);
        System.assertEquals(r, 507);
        System.assertEquals(s, 508);
        System.assertEquals(t, 509);
    }
    
    //testing to see if trigger runs unexpectedly
    @isTest
    public static void negativeTest() {
        //creating test data
        Buy_Order__c o = new Buy_Order__c (Product_Name__c = 'transition duct', Product_Cost__c = 1, Quantity__c = 5, Delivered__c = false);
        List<Buy_Order__c> oList = new List<Buy_Order__c>();
        oList.add(o);
        //running the trigger
        BuyOrderTrigger_Helper.inventoryUpdate(oList);
        //retrieving the new inventory after the trigger is done
        Inventory__c inv = [SELECT transition_duct__c FROM Inventory__c WHERE name = 'test'];
        //variable used to store the new inventory value
        Double q = inv.transition_duct__c;
        //testing our inventory value against the expected value
        System.assertEquals(q, 9);
    }
    
    
    //User privilege test
    @isTest
    public static void userTest() {
        // Create a unique UserName
        String uniqueTestName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        Profile p = [SELECT Id FROM Profile WHERE Name='Customer Service'];
        User u = new User(Alias = 'test', Email='testuser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Chicago',
         UserName=uniqueTestName);
		
        //test to check whether an unauthorized user can access Inventory__c
   			System.runAs(u) {
                List<Buy_Order__c> o = [SELECT ID, Product_Name__c, Quantity__c, Delivered__c FROM Buy_Order__c WHERE Product_Cost__c = 1];
            try {
            	upsert o;
            }
            catch (exception e) {
                System.debug('User test failed successfully');
            }
        }     
	}
}