public class Objects_Account_Controller {
    
    public ObjectA_Account__c accountRecord {get;set;}
    public List<ObjectA_Account__c> accountsList {get;set;}
    
    public ObjectoB_Contact__c contactRecord {get;set;}
    public Map<String, List<ObjectoB_Contact__c>> contactsByAccount {get;set;} 
    public List<ObjectoB_Contact__c> contactList  {get;set;}
    public string AccountIdToshowDetails {get;set;}
    
    
    public   Objects_Account_Controller (){
        
        System.debug('Constructor');
        accountRecord = new ObjectA_Account__c(); 
        contactsByAccount = new Map<String, List<ObjectoB_Contact__c>>();
        contactList = new List<ObjectoB_Contact__c> ();
        contactRecord = new ObjectoB_Contact__c();
        getAccountRecords();
    }
    
    public List<ObjectA_Account__c> getAccountRecords (){
        accountsList = [select Name__c, name, Active__c, Annual_Revenue__c, Web_site__c, Creation_Date__c from ObjectA_Account__c order by name desc];
        return accountsList;
    }
    
    public void getRelatedContacts(){
        System.debug('Getting reated list');
        AccountIdToshowDetails = Apexpages.currentPage().getParameters().get('AccountIdToshowDetails');
        System.debug(contactList);
        if(AccountIdToshowDetails!='')
         contactList = [select Email__c , Gender__c, Name__c, ObjectA_Account__c, Occupation__c, Phone__c from ObjectoB_Contact__c where ObjectA_Account__c =: AccountIdToshowDetails ];
        System.debug(contactList);
    }   
    
   public PageReference clearAccountFields(){
        accountRecord = new ObjectA_Account__c();
        system.debug('cleaning Account');
      
        return null;
    }
    
    public PageReference clearContactFields(){
        contactRecord = new ObjectoB_Contact__c();
        system.debug('cleaning Contact');
        
        return null;
    }
    
    public PageReference saveContact (){
        
        Database.SaveResult dRes;
        dRes = Database.insert(contactRecord, false);
        
        system.debug('After save database'); 
        system.debug(dRes);
        
        if(dRes.isSuccess()){
            clearContactFields();
             PageReference myVFPage = new PageReference('/apex/objects_Acount_Page');  
            myVFPage.setRedirect(true);
            return myVFPage;
        }else {
            for (Database.Error err : dRes.getErrors()){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,err.getMessage(),''));
            }
        }
        
        system.debug('Return ');
        return null;
    }    
    
    public PageReference saveAccount (){
        
        Database.SaveResult dRes;
        dRes = Database.insert(accountRecord, false);
        
        system.debug('After save database');
        system.debug(dRes);
        
        if(dRes.isSuccess()){
            clearAccountFields();
          	 PageReference myVFPage = new PageReference('/apex/objects_Acount_Page');  
            myVFPage.setRedirect(true);
            return myVFPage;
        }else {
            for (Database.Error err : dRes.getErrors()){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,err.getMessage(),''));
            }
        }
        
        system.debug('Return ');
        return null;
    }
    
}