public class Copy_BasicSecurity {
    public boolean isStudent {get;set;}
    public boolean isTeacherA {get;set;}
    public boolean isAdmin {get;set;}
    
    public Copy_BasicSecurity(){
        isStudent=false; 
        isTeacherA=false;
        isAdmin=false;
      	UserRole roleAssignedToUSer =  [select Id, name from UserRole  WHERE Id = : Userinfo.getUserRoleId() limit 1 ];

            if(roleAssignedToUSer.Name.equals('SchoolAdmin'))
                        isAdmin = true;
            
           else if(roleAssignedToUSer.Name.equals('Student'))
                    	isStudent = true;
                        
           else if(roleAssignedToUSer.Name.equals('Teacher A'))
                       isTeacherA = true;      

    }
    
}