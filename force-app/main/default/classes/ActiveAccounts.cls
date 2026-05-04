public class ActiveAccounts {
    public List<Account> acc {get; set;}
    public List<Contact> con {get; set;}
    
    public ActiveAccounts(){
        acc = [Select Id, Name, Active__c  From Account where Active__c  = 'Yes'] ;
        con = [Select Id, Name, Title From Contact where Name = 'abc'];
    }

}