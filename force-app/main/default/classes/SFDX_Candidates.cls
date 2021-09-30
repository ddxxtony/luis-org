public class SFDX_Candidates {
 
    public List<wrapCandidate> wrapCandidateList {get; set;}
    public List<SFDX_Candiate__c> selectedCandidates{get;set;}
     
    public SFDX_Candidates(){ 
        if(wrapCandidateList == null) {
            wrapCandidateList = new List<wrapCandidate>();
            for(SFDX_Candiate__c a: [select Id, Name, Full_Name__c from SFDX_Candiate__c limit 10]) {
                wrapCandidateList.add(new wrapCandidate(a));
            }
        }
    }
 
    public void processSelected() {
    selectedCandidates = new List<SFDX_Candiate__c>();
 
        for(wrapCandidate wrap : wrapCandidateList) {
            if( wrap.selected == true ) { 
                selectedCandidates.add(wrap.candidate);
            }
        }
    }
  
 
    // This is our wrapper/container class. A container class is a class, a data structure, or an abstract data type whose instances are collections of other objects. In this example a wrapper class contains both the standard salesforce object Account and a Boolean value
    public class wrapCandidate {
        public SFDX_Candiate__c candidate {get; set;}
        public Boolean selected {get; set;}
 
        //This is the contructor method. When we create a new wrapAccount object we pass a Account that is set to the acc property. We also set the selected value to false
        public wrapCandidate(SFDX_Candiate__c a) {
            candidate = a;
            selected = false;
        }
    }

    

}