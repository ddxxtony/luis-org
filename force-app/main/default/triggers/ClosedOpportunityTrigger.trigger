trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
	List<task> tasks=New List<task>();

  for(opportunity opp:Trigger.new){
   if(opp.stagename=='Closed Own'){
    task t=new task(
        whatid=opp.id, 
        Status = 'Active',
        Subject = 'Follow Up Test Task',
        ActivityDate = system.today()
     );
    tasks.add(t); 
    }
   }
     insert tasks;

 }