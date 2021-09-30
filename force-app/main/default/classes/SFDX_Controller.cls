public class SFDX_Controller {
    
    public String name {get;set;}
    public String lastName {get;set;} 
    public integer age {get;set;}
    public String merged {get;set;}   
    
    public SFDX_Controller(){ }
    
    public void mergeString(){
         merged = name + ' - '+ lastName+' - ' + String.valueOf( age );     
    }
    
     public PageREference mergeString2(){
         merged =  String.valueOf( age ) + name + ' - '+ lastName+' - ';      
         return null;
    }

}