@isTest
public class TelephoneTest {
    static testMethod void test (){
        Account a = new Account(name='Sam', phone = '123');  
        insert a;
        Account my=[select id, phone from Account Where name = 'Sam'];
        Contact c = new Contact(lastname = 'Kumar', AccountId = a.Id, phone = '456');
        insert c;
        Account acc = [select id,phone from Account Where id =:c.AccountId limit 1];
        acc.Phone = c.Phone;
        update acc;
        system.assertEquals(acc.Phone, c.Phone);
    }

}