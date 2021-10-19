public class UpdateContactAddresses implements
    Database.Batchable<sObject>, Database.Stateful {
    // instance member to retain state across transactions
    public Integer recordsProcessed = 0;
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        // get records to process
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of records
        //  increase this variable "recordsProcessed" every time a record is processed
    }
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        // call some utility to send email
        //EmailUtils.sendMessage(job, recordsProcessed);
    }
}