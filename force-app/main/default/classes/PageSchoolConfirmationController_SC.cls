public class PageSchoolConfirmationController_SC {

   public String id {get;set;}
        
   public PageSchoolConfirmationController_SC () {
     id = ApexPages.currentPage().getParameters().get('id');
    }
  
   public String getId () {
        return id;
   }
}