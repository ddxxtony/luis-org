global class ScheduleClass implements Schedulable {
    global void execute(SchedulableContext ctx) {
        AccoutBatchProcess x = new AccoutBatchProcess();
 		Database.executeBatch(x, 100);
    }
}