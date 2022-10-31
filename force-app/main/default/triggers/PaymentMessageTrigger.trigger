trigger PaymentMessageTrigger on Payment__c (after insert) {
    if (Trigger.isInsert) {
        for (Payment__c p: Trigger.new) {
            Id paymentId = [SELECT Id FROM Payment__c WHERE Id = :p.Id].Id;
            PaymentMessageHandler.sendEmail(paymentId);
        }
    }
}