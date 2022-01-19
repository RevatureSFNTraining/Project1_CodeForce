public class CustomerTrigger_Helper {
    
    public static void existingCustomerCheck (List<Customer> customer) {
       
        //Defining Variables    
    	List<String> cEmail = new List<String>();
        
        //put emails in a list to use in SOQL statement
        for(Customer c : customer) {
            cEmail.add(c.E_mail_address__c);
    	}  
        
        //looking to see if any existing customers have same email
    Customer existingCustomer = [SELECT E_mail_address__c FROM Customer WHERE E_mail_address__c IN :cEmail LIMIT 1];
        
        //if existingCutomer is populated then an error message is displayed
        if(existingCustomer != null){
            for(Customer c : customer){
                c.E_mail_address__c.addError('Email address is already in use');
            }
        }
    }
}