public class TeachersController {
   List <School__c> teachers {get;set;}
   
    public TeachersController (){

    }
    
    public List <School__c>  getTeachers (){
        teachers = new List<School__c>();
        teachers = [SELECT User_Name__c, Name, Last_Name__c, User__c, Age__c, Department__c, Subject__c, Salary__c,Comments__c, Registered_Date__c  FROM School__c where RecordType.Name = 'Teachers'];
        return teachers;
    }
}