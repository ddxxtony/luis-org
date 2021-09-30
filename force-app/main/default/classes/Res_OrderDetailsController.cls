public class Res_OrderDetailsController {
    public Res_Order1__c order {get;set;}    
    public List<Note> notesList {get;set;} 
    public List<Res_OrderDetails__c> ordersDetails {get;set;} 
    String orderId {get;set;}
    
    public Res_OrderDetailsController(){
        orderId = ApexPages.currentPage().getParameters().get('id');     
        order = [Select name,city__c, street__c, suburb__c, state__c,status__c,  Scheduled_Time__c from  Res_Order1__c where id =: orderId  limit 1  ];
        ordersDetails = [Select Description__c, name, id,   Menu_Item__c, Quantity__c, Total__c  from Res_OrderDetails__c where Order1__c =: orderId];
        notesList = [ SELECT Id, Title,body, parentId, owner.name, createdDate FROM Note where parentId =: orderId ];
    } 
}