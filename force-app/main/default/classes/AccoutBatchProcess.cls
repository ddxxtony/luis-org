public class ExtensionController {
 
    private final Account acct;
     
     
    public ExtensionController (ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
    }
 
    public String getGreeting() {
        return 'Hello ' + acct.name + ' (' + acct.id + ')';
    }
}