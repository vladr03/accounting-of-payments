global class DiscountSchedule implements Schedulable {
    global void execute(SchedulableContext sc) {
        Discount d = new Discount();
        Database.executeBatch(d);
    }
}