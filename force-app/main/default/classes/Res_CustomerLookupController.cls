public with sharing class Res_CustomerLookupController {
  
  public List<User> results{get;set;} // search results
  public string searchString{get;set;} // search keyword
  
  public Res_CustomerLookupController() {
      
    // get the current search string
    searchString = System.currentPageReference().getParameters().get('lksrch');
    runSearch();  
      
  }
   
  // performs the keyword search
  public PageReference search() {
    runSearch();
    return null;
  }
  
  // prepare the query and issue the search command 
  private void runSearch() {
    // TODO prepare query string for complex serarches & prevent injections
    results = performSearch(searchString);               
  }  
  
  // run the search and return the records found. 
  private List<User> performSearch(string searchString) {
 
    String soql = 'select id, name from user where name LIKE \'%' + searchString +'%\' ' +
        ' and  id in (select AssigneeId from PermissionSetAssignment where PermissionSet.Name = \'Res_Client\' ) limit 40';
      
    return database.query(soql);  
  }
  
  // used by the visualforce page to send the link to the right dom element
  public string getFormTag() {
    return System.currentPageReference().getParameters().get('frm');
  }
    
  // used by the visualforce page to send the link to the right dom element for the text box
  public string getTextBox() {
    return System.currentPageReference().getParameters().get('txt');
  }
 
}