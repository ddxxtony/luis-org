trigger UpdateSkills on SFDX_Candiate__c ( before insert, before update, before delete, after insert ) {
    
    if(Trigger.isInsert && Trigger.isBefore){
        if( Trigger.new[0].YOE__c > 40 ){ 
           Trigger.new[0].addError('This person is too old.');  
        }
    }
     
}