trigger leadTrigger on Lead(before insert, before update){
    set<Decimal> mapNub = new set<Decimal>();
    for(lead newLeads : trigger.new){
        if(newLeads.Mat_Code__c != null){
            mapNub.add(newLeads.Mat_Code__c);
        }
    }
    Map<Decimal, Speaker__c> mapSpeaker = new Map<Decimal, Speaker__c>();
    if(mapNub.size() > 0){
        for(Speaker__c sp : [SELECT Id, Mat_Code__c, Mat_Nub__c FROM Speaker__c WHERE Mat_Code__c IN :mapNub]){
            mapSpeaker.put(sp.Mat_Code__c, sp);
        }
    }
    for(lead leadUpdate: trigger.new){
        if((trigger.isInsert || trigger.oldMap.get(leadUpdate.Id).Mat_Code__c != leadUpdate.Mat_Code__c) && mapSpeaker.containsKey(leadUpdate.Mat_Code__c)){
            leadUpdate.Mat_Numb__c = mapSpeaker.get(leadUpdate.Mat_Code__c).Mat_Nub__c;
        }
    }
}