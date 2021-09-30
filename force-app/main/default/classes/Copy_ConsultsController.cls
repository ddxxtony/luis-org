public class Copy_ConsultsController {
    
    public List<School__c> stdSchool {get;set;}
   	public List<SelectOption> recordTypeOptions {get; set;}
    public String selectedRecordType {get;set;}
    public SchoolSecurity3_SC  schoolSecurity {get;set;}
    public Copy_BasicSecurity shcoolRole { get;set; }
    
   	public String searchName {get;set;}
   	public String searchLastName {get;set;}
   	public String searchUser {get;set;}
    public String startDate  {get;set;} 
    public String endDate  {get;set;} 
    public String hasNext  {get;set;} 
    public String hasPrevious  {get;set;} 
    
    private integer pageOffset=0;
    public integer pageNumber {get;set;}
    public integer listTotalSize {get;set;}
   	public List<SelectOption> recordsToShowOptions {get; set;}
    public String selectedRecordsToShow {get;set;}
        
         
    //owner.id
    ////Userinfo. 
    //getUserId()
    
   	public Copy_ConsultsController (){
        
        	startDate = '';
        	endDate = '';
        	searchUser= '';
            schoolSecurity = new SchoolSecurity3_SC();  
        	shcoolRole = new Copy_BasicSecurity();
            stdSchool = new List<School__c>();
            recordTypeOptions = new List<SelectOption>();
        

        	recordsToShowOptions= new List<SelectOption>();
        	recordsToShowOptions.add(new SelectOption('5', '5'));
       		recordsToShowOptions.add(new SelectOption('10', '10'));
        	recordsToShowOptions.add(new SelectOption('20', '20'));
         	recordsToShowOptions.add(new SelectOption('50', '50'));
        	recordsToShowOptions.add(new SelectOption('100', '100'));
       		selectedRecordsToShow = '5';
        
        
      	 for(RecordType option:   [SELECT Name, id FROM RecordType WHERE sObjectType='School__c' and isActive=true]){
           
         	if(option.Name.equals('Students'))
           		recordTypeOptions.add(new SelectOption(option.Name, option.Name)); 
           
           else if(option.Name.equals('Teachers'))
               	recordTypeOptions.add(new SelectOption(option.Name, option.Name));  
           
       	}
        
        if(recordTypeOptions.size()>0){
             selectedRecordType = recordTypeOptions.get(0).getLabel();
        }
        
        this.getStdSchool(); 
       
    }
    
    
    public void filterSchoolRecords () {
        pageOffset = 0;
       getStdSchool();
    } 
    
    public void onPageNumberChanged () {
        if( pageNumber <= getTotalPages() && pageNumber >0  ){
           pageOffset = getListSize() * (pageNumber-1); 
        }
        
 		getStdSchool();
   } 
    
        
    public void onRecordsToShowChange () {
        if(pageOffset<=getListSize()){
            pageOffset = 0;
        }
       getStdSchool();
    } 
    
    
    public void  getStdSchool (){
        
        
       String [] dateParts;
       
       String totalSizeQuery = ' select count() from School__c ' +
           				     'where RecordType.Name =: selectedRecordType '+
							'and User_Name__c like \'%' + searchName + '%\' ' +
           				   'and Last_Name__c like \'%' + searchLastName + '%\' ' +
          					'and User__c like \'%' + searchUser + '%\' ';
           					
        
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
           						   'and Last_Name__c like \'%' + searchLastName + '%\' ' +
          						   'and User__c like \'%' + searchUser + '%\' ';
        
        
        System.debug(startDate+ '  '+ endDate );
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
        
        //Check role
        
        if(shcoolRole.isStudent){
            query = query + ' and owner.id = \'' +  Userinfo.getUserId()+'\'';
        }
         
        if(shcoolRole.isTeacherA){
            query = query + ' and group__c = \'A\' ';
            if(selectedRecordType == 'Teachers'){
                query = query + ' and owner.id = \'' +  Userinfo.getUserId()+'\'';	
            }
        }
        
        
        query = query + ' ORDER BY Name limit ' + getListSize() + ' offset :pageOffset'; 
       
        System.debug(query );
       listTotalSize = Database.countQuery(totalSizeQuery);  
       stdSchool =  Database.query(query);
       			
       pageNumber = pageOffset/getListSize() + 1;
    }

    public void clearFilterField() {
        
        searchName = '';
        searchLastName = '';
       	searchUser= '';
        startDate=''; 
        endDate=''; 
        if(recordTypeOptions.size()>0){
             selectedRecordType = recordTypeOptions.get(0).getLabel();
        }
        getStdSchool();
    }

     public integer getListSize() {
      	return integer.valueof(selectedRecordsToShow);
    }
    
    public void Firstbtn() {
        pageOffset = 0;
        getStdSchool();
    }
    
    public void previousbtn() {
        pageOffset -= getListSize();
        	getStdSchool();
    }
    public PageReference  Nextbtn() {
        pageOffset += getListSize();
  		getStdSchool();
        return null;
    }
    
    public void Lastbtn () {
      pageOffset = listTotalSize - math.mod(listTotalSize, getListSize());
      getStdSchool();
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