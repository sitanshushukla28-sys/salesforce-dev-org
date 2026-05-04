trigger AccountTrigger on Account (before insert, after insert) {
    
    if(trigger.isBefore){
        if(trigger.isInsert && AccountTriggerHandler.isExceuteTrigger == true){
            // update rating
            AccountTriggerHandler.ratingUpdate(trigger.new);
        }
    }
    
    if(trigger.isAfter){
        //Create 10 contact on account insert
        if(trigger.isInsert && AccountTriggerHandler.isExceuteTrigger == true){
            AccountTriggerHandler.createTenContacts(trigger.new);
        }
    }
 
}