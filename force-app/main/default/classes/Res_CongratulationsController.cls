public class Res_CongratulationsController {
  public String id {get;set;}
        
   public Res_CongratulationsController () {
     id = ApexPages.currentPage().getParameters().get('id');
    }
   
   public String getId () {
         return id;
   }
    
}