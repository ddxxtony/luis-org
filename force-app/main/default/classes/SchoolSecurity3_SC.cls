public class SchoolSecurity3_SC {
    public boolean isStudent {get;set;}
    public boolean isTeacher {get;set;}
    public boolean isAdmin {get;set;}
    
    public SchoolSecurity3_SC(){
        isStudent=false; 
        isTeacher=false;
        isAdmin=false;
       List<PermissionSetAssignment> lpsa =  [SELECT Id, PermissionSet.Name,AssigneeId 
                                              FROM PermissionSetAssignment 
                                              WHERE AssigneeId = :Userinfo.getUserId() ];

      for (PermissionSetAssignment psa: lpsa)
        {
            if(psa.PermissionSet.Name.equals('SchoolAdmin'))
                        isAdmin = true;
            
           else if(psa.PermissionSet.Name.equals('Student'))
                    	isStudent = true;
                        
           else if(psa.PermissionSet.Name.equals('Teacher'))
                       isTeacher = true;
        }
    
    }
    
    
    
     
}