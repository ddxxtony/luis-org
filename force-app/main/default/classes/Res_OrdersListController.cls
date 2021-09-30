public class Res_OrdersListController {
	public  List<Res_Order1__c> ordersList {get;set;}	
    
    public Res_OrdersListController(){
        ordersList = [select name,city__c,status__c,  Scheduled_Time__c, id, total__c  from Res_Order1__c ];
    } 
}