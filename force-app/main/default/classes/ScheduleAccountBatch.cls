global class ScheduleAccountBatch implements Schedulable {
    global void execute(SchedulableContext sc){
        AccountNameUpdateBatch bc = new AccountNameUpdateBatch();
        database.executeBatch(bc);
    }

}