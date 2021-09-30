public class AccoutBatchProcess implements Database.Batchable<Sobject>{
    
    public database.QueryLocator start(Database.BatchableContext ctx){
        return database.getQueryLocator('SELECT ID FROM Account');
    }
    
    public void execute(Database.BatchableContext ctx, List<Sobject> sList){
        
    }
    public void finish(Database.BatchableContext ctx){
        
    }
    
}