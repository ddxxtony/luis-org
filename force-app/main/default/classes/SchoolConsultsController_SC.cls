public class SchoolConsultsController_SC {
    
    public List<School__c> stdSchool {get;set;}	 //store the records to show on the table
   	public List<SelectOption> recordTypeOptions {get; set;} //store all the record types that user has access to
    public String selectedRecordType {get;set;} //store the selected recordType
    public SchoolSecurity3_SC  schoolSecurity {get;set;} // Contains the security info.
    
    
   	public String searchName {get;set;}
   	public String searchLastName {get;set;} 
    public String startDate  {get;set;} 
    public String endDate  {get;set;} 
    public String hasNext  {get;set;} 
    public String hasPrevious  {get;set;} 
    
    private integer pageOffset=0;
    public integer pageNumber {get;set;}
    public integer listTotalSize {get;set;}
   	public List<SelectOption> recordsToShowOptions {get; set;}
    public String selectedRecordsToShow {get;set;}
        
         
   	public SchoolConsultsController_SC (){
        
        	startDate = '';
        	endDate = '';
        	pageNumber=1;
        	listTotalSize=0;
            schoolSecurity = new SchoolSecurity3_SC();  
            stdSchool = new List<School__c>();
            recordTypeOptions = new List<SelectOption>();
        
        	recordsToShowOptions= new List<SelectOption>();
        	recordsToShowOptions.add(new SelectOption('3', '3'));
       		recordsToShowOptions.add(new SelectOption('10', '10'));
        	recordsToShowOptions.add(new SelectOption('20', '20'));
         	recordsToShowOptions.add(new SelectOption('50', '50'));
        	recordsToShowOptions.add(new SelectOption('100', '100'));
       		selectedRecordsToShow = '3';
        
        
      	 for(RecordType option:   [SELECT Name, id FROM RecordType WHERE sObjectType='School__c' and isActive=true]){
           
         	if(option.Name.equals('Students') && (schoolSecurity.isStudent || schoolSecurity.isAdmin )  )
           		recordTypeOptions.add(new SelectOption(option.Name, option.Name)); 
           
           else if(option.Name.equals('Teachers') && (schoolSecurity.isTeacher || schoolSecurity.isAdmin ) )
               	recordTypeOptions.add(new SelectOption(option.Name, option.Name));  
           
       	}
        
        if(recordTypeOptions.size()>0){
             selectedRecordType = recordTypeOptions.get(0).getLabel();
        }
       
    }
    
    
    public void filterSchoolRecords () {
        pageOffset = 0;
       queryDB();
    } 
    

        
    public void onRecordsToShowChange () {
        if(pageOffset<=getListSize()){
            pageOffset = 0;
        }
       queryDB();
    } 
    
    
    public void queryDB (){
               
       String [] dateParts;
       String totalSizeQuery = ' Select count() from School__c ' +
           				     'where RecordType.Name =: selectedRecordType '+
							'and User_Name__c like \'%' + searchName + '%\' ' +
           				   'and Last_Name__c like \'%' + searchLastName + '%\' ';
           					
        
       String query = ' SELECT '+ 
                                   'User_Name__c, '+
                                   'Name, '+
                                   'Last_Name__c, '+
                                   'User__c, '+
                     				'Subject__c, '+
                     				'Department__c, '+
                                   'Age__c, '+
                                   'Class__c, '+
                                   'Comments__c, '+
                                   'Registered_Date__c '+
                                   'FROM School__c '+
                     			   'where RecordType.Name =: selectedRecordType '+
								   'and User_Name__c like \'%' + searchName + '%\' ' +
           						   'and Last_Name__c like \'%' + searchLastName + '%\' ';
        
        
        if(!startDate.equals('') && startDate!=null){
            dateParts   =  startDate.split('/');
            query = query + ' and Registered_Date__c >= ' +  
                dateParts[2]+ '-'+
                dateParts[0] + '-'+
                dateParts[1];
            totalSizeQuery = totalSizeQuery + ' and Registered_Date__c >= '+  
                dateParts[2]+ '-'+
                dateParts[0] + '-'+
                dateParts[1];
        }
       
        if(!endDate.equals('') && endDate!=null){
            dateParts   =  endDate.split('/');
            
              // Add one day to the end date
             Date auxDate =date.valueOf(dateParts[2]+ '-'+dateParts[0] +'-'+dateParts[1]);
             String dateToCompare =	String.valueOf(auxDate.addDays(1));
                        
            query = query + ' and Registered_Date__c < '+ dateToCompare;
            totalSizeQuery = totalSizeQuery + ' and Registered_Date__c < '+dateToCompare; 
        }
         
        query = query + ' ORDER BY Name limit ' + getListSize() + ' offset :pageOffset'; 
       
       listTotalSize = Database.countQuery(totalSizeQuery);  
       stdSchool =  Database.query(query);
       			
       pageNumber = pageOffset/getListSize() + 1;
    }
    
    public void clearFilterField() {
        
        searchName = '';
        searchLastName = '';
        startDate=''; 
        endDate=''; 
        if(recordTypeOptions.size()>0){
             selectedRecordType = recordTypeOptions.get(0).getLabel();
        }
        queryDB();
    }

     public integer getListSize() {
      	return integer.valueof(selectedRecordsToShow);
    }
    
    public void Firstbtn() {
        pageOffset = 0;
        queryDB();
    }
    
    public void previousbtn() {
        pageOffset -= getListSize();
        	queryDB();
    }
    public PageReference  Nextbtn() {
        pageOffset += getListSize();
  		queryDB();
        return null;
    }
    
    public PageReference onPageNumberChanged () {
        if( pageNumber <= getTotalPages() && pageNumber >0  ){
           pageOffset = getListSize() * (pageNumber-1); 
        }
 		queryDB();
       
        return null;
   } 
    
    public void Lastbtn () {
      pageOffset = listTotalSize - math.mod(listTotalSize, getListSize());
      queryDB();
    }
    
   public Boolean getDisablePrevious() { 
      if (pageOffset>0) return false; else return true;
   }

   public Boolean getDisableNext() {
      if (pageOffset + getListSize() < listTotalSize) return false; else return true;
   }
    
   
   public Integer getTotalPages() {
       Integer total = 0;
       total =listTotalSize/getListSize();
       
      if (math.mod(listTotalSize, getListSize()) > 0) {
         return total + 1;
      } 
       
      return total==0?1:total;
      
   }
    
            
       
}