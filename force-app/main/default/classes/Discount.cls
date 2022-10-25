global class Discount implements Database.Batchable<sObject> {
    global Discount() {}

    global Database.QueryLocator start(Database.BatchableContext bc) {
        Date tday = System.today();
        String query = 'SELECT Id, Amount, (SELECT UnitPrice FROM OpportunityLineItems) FROM Opportunity WHERE Id IN (SELECT OpportunityId From OpportunityContactRole WHERE Contact.Birthdate = 2022-10-25)';
        return Database.getQueryLocator(query);       
    }

    global void execute(Database.BatchableContext bc, List<Opportunity> records) {
        Decimal discount = 0.9;
        System.debug('records: ' + records);
        List<OpportunityLineItem> items = new List<OpportunityLineItem>();
        for(Opportunity opp: records) {
            for(OpportunityLineItem item: opp.OpportunityLineItems) {
                item.UnitPrice = item.UnitPrice * discount;
                System.debug(item.UnitPrice);
                items.add(item);
            }
        }     
        update items;
    }

    global void finish(Database.BatchableContext bc) {}
}
