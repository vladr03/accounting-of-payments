import { LightningElement, wire } from 'lwc';
import getFullyPaidOpportunities from '@salesforce/apex/OpportunityController.getFullyPaidOpportunities'

export default class PaymentStatistics extends LightningElement {
    fullyPaidOpportunities;

    @wire(getFullyPaidOpportunities)
    wiredOpportunities({ data }) {
        if (data) {
            this.fullyPaidOpportunities = data;
            console.log(this.fullyPaidOpportunities);
        }
    }
}