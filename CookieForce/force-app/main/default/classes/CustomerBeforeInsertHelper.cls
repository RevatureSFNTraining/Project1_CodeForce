public with sharing class CustomerBeforeInsertHelper {
    public CustomerBeforeInsertHelper() {
        
        public static void trig(List<Customer> customerList) {
            for(Customer customer: customerList){
                customer.Name = 'Set Name';
                }
        }
    }
}
