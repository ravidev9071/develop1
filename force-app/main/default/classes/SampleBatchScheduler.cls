global class SampleBatchScheduler implements Schedulable{
    global void execute(SchedulableContext ctx){
        LeadConversionBatch batch=new LeadConversionBatch();
              Database.executebatch(batch, 200);

    }
}