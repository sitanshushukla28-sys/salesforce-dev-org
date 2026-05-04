global class emailBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Owner.Email FROM Lead WHERE CreatedDate < YESTERDAY ');
    }

    global void execute(Database.BatchableContext BC, list<sObject> scope) {
        for(sObject ld :scope){
            List<String> s = new List<String>();
            string a = String.valueOf(ld.id);
            s.add(a);
            OrgWideEmailAddress owa = [select id, DisplayName, Address from OrgWideEmailAddress limit 1];
            EmailTemplate templateId = [Select id from EmailTemplate where name = 'Approver'];
            List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTemplateID(templateId.Id);
            mail.setSaveAsActivity(false);
            mail.setOrgWideEmailAddressId(owa.id);
            mail.setToAddresses(s);
            allmsg.add(mail);
            Messaging.sendEmail(allmsg,false);
        }
    }

    global void finish(Database.BatchableContext BC) {

    }
}