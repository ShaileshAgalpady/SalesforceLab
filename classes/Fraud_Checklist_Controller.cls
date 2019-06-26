public class Fraud_Checklist_Controller {
    @AuraEnabled
    public static list<Fraud_checklist__c> getFraudChecklist(string accountId) {
        return [
            SELECT Name, CreatedDate
            FROM Fraud_checklist__c
            WHERE Opportunity__r.AccountId =: accountId
        ];
    }
}