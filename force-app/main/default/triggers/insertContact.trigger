trigger insertContact on Account (after insert) {
    
    contact cont = new contact();
    cont.LastName = Trigger.new[0].name;
    system.debug('what it contains--->'+Trigger.new);
    cont.AccountId = Trigger.new[0].ID; 
    insert cont; 
}