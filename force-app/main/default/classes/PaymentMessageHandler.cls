public with sharing class PaymentMessageHandler {

    @future(callout=true)
    public static void sendEmail(String paymentId) {
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        Id oppId = [SELECT Opportunity__c FROM Payment__c WHERE Id = :paymentId].Opportunity__c;
        System.debug(oppId);
        OpportunityContactRole oppContact = [SELECT Contact.Id FROM OpportunityContactRole WHERE OpportunityId = :oppId LIMIT 1];
        PageReference pdfPage = Page.PaymentPage;
        System.debug('Payment Id: ' + paymentId);
        pdfPage.getParameters().put('payment', paymentId);
        Blob pdfBlob;
        if (!Test.isRunningTest()) {
            pdfBlob = pdfPage.getContent();
        }else{
            pdfBlob = Blob.valueOf('test');
        }
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setContentType('application/pdf');
        efa.setFileName('receipt.pdf');
        efa.setBody(pdfBlob);
        efa.setInline(false);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(oppContact.Contact.Id);
        mail.setSubject('RECEPEIT');
        mail.setPlainTextBody('Thank you for the payment.');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        mailList.add(mail);
        Messaging.sendEmail(mailList);
    }
}