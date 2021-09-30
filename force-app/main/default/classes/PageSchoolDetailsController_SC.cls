public class PageSchoolDetailsController_SC {

   School__c schoolRecord {get;set;}
   public String recordId {get;set;}
    public List<School__c> recordsList {get;set;}
     public SchoolSecurity3_SC  schoolSecurity {get;set;}
    
        
   public PageSchoolDetailsController_SC () {
        schoolSecurity = new SchoolSecurity3_SC();
       System.debug('Getting recors');
        recordId = ApexPages.currentPage().getParameters().get('id');
		recordsList = new List<School__c>();
        recordsList =  [ SELECT User_Name__c, Last_Name__c, User__c,Subject__c , Department__c,Salary__c ,  Age__c,Comments__c, RecordType.name, email__c, is_scholarship_applied__c, Currency__c,  id From School__c where id = :recordId ];
       if(recordsList.size()>0){
            schoolRecord =  recordsList.get(0);
       }
    }
    
    public School__c getSchoolRecord () {
        return schoolRecord;
    }
    
    
}