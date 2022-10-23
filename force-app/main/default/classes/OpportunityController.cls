public with sharing class OpportunityController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getFullyPaidOpportunities() {
        return [SELECT Id, Name, Invoice_Number__c, (SELECT Id, Amount__c, FirstName__c, LastName__c, Payment_Time__c FROM Payments__r) 
        FROM Opportunity WHERE Payment_Status__c = 'Fully Paid'];
    }
}
