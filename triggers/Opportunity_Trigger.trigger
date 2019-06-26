trigger Opportunity_Trigger on Opportunity (after insert, after update) {
    list<Fraud_checklist__c> checklists = new list<Fraud_checklist__c>();
    Fraud_checklist__c checklistItem =  new Fraud_checklist__c();
    list<Opportunity> newOppList = trigger.new;
    Map<Id,Opportunity> OldOppMap = (Map<Id,Opportunity>)trigger.oldMap;
    Opportunity oldOpp = new Opportunity();
    
    for(opportunity opp : Trigger.new) {
        if(trigger.isUpdate) {
            oldOpp = OldOppMap.get(opp.Id);
        }
        
        if((trigger.isInsert && opp.Is_Fraud__c == TRUE)
            ||
            (trigger.isUpdate && opp.Is_Fraud__c == TRUE && oldOpp.Is_Fraud__c == False)) {
            checklists.add(new Fraud_checklist__c(name = 'Discrepancy with business address', Opportunity__c = opp.Id));
            checklists.add(new Fraud_checklist__c(name = 'Inconsistencies with bank statement', Opportunity__c = opp.Id));
        }
    }
    if(checklists.size()>0) {
        insert(checklists);
    }
}