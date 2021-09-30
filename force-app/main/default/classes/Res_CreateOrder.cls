public class Res_CreateOrder {
    public Res_Order1__c order {get;set;}
    public List<Res_OrderDetails__c> selectedMenuItems {get;set;} 
    public List<Res_Menu__c> menuItems {get;set;} 
    public List<Note> notesList {get;set;}
     public Note note {get;set;}
    
    public string serializedMenuItems {get;set;} 
    public string serializedNewMenuItem {get;set;} 
    public Decimal totalToPay {get;set;} 
    public string selectedCombo {get;set;}
    public string selectedMainPlate {get;set;}
    public string selectedBeverage {get;set;}
    public string selectedComplement {get;set;} 
     
    public Res_CreateOrder () { 
       totalToPay = 0;
       note = new Note();
       note.title = 'Order created commets';
       order = new Res_Order1__c();  
       selectedMenuItems = new List<Res_OrderDetails__c>();
       menuItems = [ select Beverage__c, Complement__c, Description__c, Main_Plate__c, Name__c, Price__c from Res_Menu__c ];
       
       serializedMenuItems = JSON.serialize(menuItems);  
    }
    
    public Res_Order1__c getOrder () { 
        return order; 
    }
     
    public PageReference addNewItemToMenuItemsList () {
        Res_OrderDetails__c  newMenuItem = (Res_OrderDetails__c) System.JSON.deserialize(serializedNewMenuItem, Res_OrderDetails__c.class);
        selectedMenuItems.add(newMenuItem);
        totalToPay = totalToPay + newMenuItem.Total__c;
        return null;
    }
    
    public PageReference createNewOrder () {
        order.total__c = totalToPay;
        insert order;
        if(note.body!=null && note.body!=''){
            note.ParentId = order.id;
        	insert note;
        }

        for (integer i=0;i<selectedMenuItems.size();i++){
           selectedMenuItems.get(i).Order1__c = order.id;
        }
        
        insert selectedMenuItems;
        
        PageReference myVFPage = new PageReference('/apex/Res_Congratulations?id=' + order.id);
        myVFPage.setRedirect(true);
        return myVFPage;
    }
    
}