public class BuyOrderTrigger_Helper {

    //method used to update our inventory when an order is marked as delivered
    public static void inventoryUpdate (List<Buy_Order__C> orderList){
        
       //Need to pull our current inventory values
       Inventory__c inventory = [SELECT X4_ft_duct__c, X8_ft_duct__c, Plastic_Bird_Guard__c, Steel_Bird_Guard__c, transition_duct__c FROM Inventory__C];
        
        //cycle through our updated buy orders
        for(Buy_Order__c b : orderList) {

            //this will execute when the Delivered field is checked off
            if (b.Delivered__c == true){
                
                //Set up variables to use in our switch statement
                String product = b.Product_Name__c;
                Decimal quantity = b.Quantity__c;
                
                //now we check which picklist value the Buy Order had and update the corresponding Inventory field
                switch on product {
                    when '4 ft duct' {
                        inventory.X4_ft_duct__c += b.Quantity__c;
                    }
                    when '8 ft duct' {
                        inventory.X8_ft_duct__c += b.Quantity__c;
                    }
                    when 'transition duct' {
                        inventory.transition_duct__c += b.Quantity__c;
                    }
                    when 'Plastic bird guard' {
                        inventory.Plastic_Bird_Guard__c += b.Quantity__c;
                    }
                    when 'Metal bird guard' {
                        inventory.Steel_Bird_Guard__c += b.Quantity__c;
                    }
                }
                
            }
        }
        //inventory values are updated in a single transaction
        update inventory;
    }
}