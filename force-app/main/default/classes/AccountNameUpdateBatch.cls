/*
 * I want to update all the account name appended with my name
 * 
 */

global class AccountNameUpdateBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        //collect the batches of records to be passed on execute method
        
        String query = 'Select Id, Name from Account';
        return database.getQueryLocator(query);
        
    }
    
    global void execute(Database.BatchableContext bc, list<Account> accList){
        list<Account> accupdate = new list<Account>();
        for(Account acc : accList){
            acc.Name = acc.Name + ' Sitanshu';
            //acc.Name = (acc.Name).remove('Sitanshu');
            accupdate.add(acc);
        }
        
        update accupdate;
    }
    
    global void finish(Database.BatchableContext bc){
        // execute post-processing operations
    }

}