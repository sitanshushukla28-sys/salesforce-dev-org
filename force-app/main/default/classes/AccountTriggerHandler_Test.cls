@isTest
private class AccountTriggerHandler_Test {

    @isTest
    static void testTriggerLogicWithoutDML() {
        // Create mock Accounts
        List<Account> newAccList = new List<Account>{
            new Account(Name = 'Test Account 1'),
            new Account(Name = 'Test Account 2')
        };

        // Simulate the same condition the trigger uses
        AccountTriggerHandler.isExceuteTrigger = true;

        // Call BEFORE INSERT logic
        AccountTriggerHandler.ratingUpdate(newAccList);

        // Call AFTER INSERT logic
        AccountTriggerHandler.createTenContacts(newAccList);
  }
}