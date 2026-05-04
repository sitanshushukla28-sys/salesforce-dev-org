public class dupTest {
    list<Account> acc = [Select Id, AccountNumber FROM Account WHERE AccountNumber = '12'];
    map<string, Account> unique = new map<string, Account>();
}