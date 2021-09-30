public class res_MenuController {
     public List<Res_Menu__c> menuElements {get;set;} 
    
    public res_MenuController(){
        menuElements = new List<Res_Menu__c>();
        menuElements = [Select
                        Name__c, Beverage__c, Complement__c, Description__c, Main_Plate__c, Price__c
                        from Res_Menu__c];
        
    }
}