public class AccountTriggerHandler {
    
    public static boolean isExceuteTrigger = true;
    
    //For updating the rating 
    public static void ratingUpdate(List<Account> account){
        for(Account acc: account){
            if (acc.Site == 'India'){
                acc.Rating ='Hot';
            }
        }
        isExceuteTrigger = false;
    }
    
    // For creating 10 contacts on account Insert 
    public static void createTenContacts(List<Account> account){
        list<contact> contactUpdate = new list<Contact>();
        
        for (Account acc : account){
            for(integer i=1; i<11 ; i++){
                contact con = new contact();
                con.lastname = acc.Name +' '+i;
                con.AccountId = acc.Id;
                contactUpdate.add(con);
            }
        }
        
        if(contactUpdate.size()>0){
            insert contactUpdate;
        }
        isExceuteTrigger = false;
    }
}