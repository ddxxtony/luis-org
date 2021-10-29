public with sharing class HomeworkController {
    
    // public HomeworkController() {
        
    // }
        
    @AuraEnabled
    public static List<Account> getAccounts(){
        List<Account> accList = new List<Account>();
        accList = [SELECT name, Site, Description, CreatedDate FROM Account ORDER BY CreatedDate DESC limit 10  ];
        return accList;
    }
}
