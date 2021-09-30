public class SchoolController_SC {

   School__c schoolRecord {get;set;}
   School__c schoolRecordBackUp {get;set;}
   public String keyIn {get;set;}
   public String recordId {get;set;}
   public List<School__c> recordsList {get;set;}
   public List<SelectOption> recordTypeOptions {get; set;}
   public String selectedRecordType {get;set;}
   public SchoolSecurity3_SC  schoolSecurity {get;set;}
         
   public SchoolController_SC () { 
       
       schoolRecord = new School__c(); 
       schoolRecordBackUp= new School__c(); 
       recordId = ApexPages.currentPage().getParameters().get('id');
       recordsList = new List<School__c>();
       recordTypeOptions = new List<SelectOption>();
System.debug('HEre');
       schoolSecurity = new SchoolSecurity3_SC();
       
       recordsList =  [ SELECT User_Name__c, Last_Name__c,Subject__c,RecordType.name,  Department__c, Salary__c, User__c,Password__c, Age__c,Comments__c, email__c, is_scholarship_applied__c, Currency__c, 
                       id From School__c where id = :recordId limit 1 ];
       if(recordsList.size()>0){
           
            schoolRecord =  recordsList.get(0);
           
         	schoolRecordBackUp.Department__c= schoolRecord.Department__c;
            schoolRecordBackUp.Currency__c= schoolRecord.Currency__c;
            schoolRecordBackUp.is_scholarship_applied__c = schoolRecord.is_scholarship_applied__c;
            schoolRecordBackUp.Subject__c = schoolRecord.Subject__c ;
            schoolRecordBackUp.Salary__c = schoolRecord.Salary__c;
           
           	selectedRecordType = schoolRecord.RecordType.name;
           
       }else{
           recordId = null;
       }
       

      recordTypeOptions.add(new SelectOption(' ', '-Seleccione-'));
       
       for(RecordType option:   [SELECT Name, id FROM RecordType WHERE sObjectType='School__c' and isActive=true]){
           
         	if(option.Name.equals('Students') && (schoolSecurity.isStudent || schoolSecurity.isAdmin )  )
           		recordTypeOptions.add(new SelectOption(option.Name, option.Name)); 
           
           else if(option.Name.equals('Teachers') && (schoolSecurity.isTeacher || schoolSecurity.isAdmin ) )
               	recordTypeOptions.add(new SelectOption(option.Name, option.Name));   
       }
      

       
    }

    public List<SelectOption> getRecordTypeOptions() {
        return recordTypeOptions;
    }    
    
    public School__c getSchoolRecord () { 
        return schoolRecord;
    }
    
    public void cleanFields(){
        if(recordId == null)
            return;   
       
        if(schoolRecord.RecordType.name.equals(selectedRecordType) ) {
            
            schoolRecord.Department__c= schoolRecordBackUp.Department__c;
            schoolRecord.Currency__c= schoolRecordBackUp.Currency__c;
            schoolRecord.is_scholarship_applied__c = schoolRecordBackUp.is_scholarship_applied__c;
            schoolRecord.Subject__c = schoolRecordBackUp.Subject__c ;
            schoolRecord.Salary__c = schoolRecordBackUp.Salary__c;
            
        }else{
            
            schoolRecord.Department__c= '';
            schoolRecord.Currency__c=null;
            schoolRecord.is_scholarship_applied__c = false;
            schoolRecord.Subject__c = '';
            schoolRecord.Salary__c = null;
        }    
    }
    
    public String getRecordId(){
        return recordId;
    }

   public PageReference saveRecords() {
       
       	PageReference myVFPage =null;
       
           
        Database.UpsertResult dRes;
        schoolRecord.RecordTypeId = [ SELECT Id, SobjectType, Name From RecordType where RecordType.Name =: selectedRecordType and SobjectType = 'School__c'  limit 1 ].Id;
        dRes = Database.upsert(schoolRecord, false);
       
       if(dRes.isSuccess()){
            myVFPage = new PageReference('/apex/PageSchoolConfirmation_SC?id='+schoolRecord.id);
            myVFPage.setRedirect(true);
       }else {
            for (Database.Error err : dRes.getErrors()){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,err.getMessage(),''));
              }
    
       }
        
       
        return myVFPage;
     } 
    
    
    public Void onlyCleanFields() {
           schoolRecord = new School__c(); 
    }
    
    public PageReference goToDetails() {
        PageReference myVFPage = new PageReference('/apex/PageSchoolDetails_SC?id=' + recordId);
        myVFPage.setRedirect(true);
        return myVFPage;
     }

    
    
}