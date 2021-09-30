public class StudentsController {
    public List<School__c> stdSchool {get;set;}
    
       
   	public StudentsController (){

    }
    
    public List <School__c>  getStudents (){
        stdSchool = new List<School__c>();
        stdSchool = [ SELECT 
                                   User_Name__c,
                                   Name,
                                   Last_Name__c,
                                   User__c, 
                                   Age__c,
                                   Class__c,
                                   Comments__c, 
                                   Registered_Date__c 
                                   FROM School__c where RecordType.Name = 'Students'];
        
        return stdSchool;
    }
}