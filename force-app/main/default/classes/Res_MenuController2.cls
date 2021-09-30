public class Res_MenuController2 {
	public List<Res_Menu__c> menuElements {get;set;} 
    
    public Res_MenuController2(){
        menuElements = new List<Res_Menu__c>();
        menuElements = [Select Name__c, Beverage__c, Complement__c, Description__c, Main_Plate__c, Price__c from Res_Menu__c]; 
    } 
}