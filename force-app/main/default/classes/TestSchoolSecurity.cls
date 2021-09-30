@isTest
public class TestSchoolSecurity {

    	@isTest static void testConstructorIsAdmin() {
        
        	User u = TestSchoolDummyData.generateUser();
        	insert u;
        	PermissionSetAssignment per = TestSchoolDummyData.getPermissionSetAssignment('SchoolAdmin',u.id);
      	 	insert per;
        
            System.runAs(u) {
                SchoolSecurity3_SC school = new SchoolSecurity3_SC();
                System.assertEquals(school.isAdmin,true, 'Admin is not recognized as admin');
            }
        }	
        
        @isTest static void testConstructorIsStudent() {
        
        	User u = TestSchoolDummyData.generateUser();
        	insert u;
        	PermissionSetAssignment per = TestSchoolDummyData.getPermissionSetAssignment('Student',u.id);
      	 	insert per;
        
            System.runAs(u) {
                SchoolSecurity3_SC school = new SchoolSecurity3_SC();
                System.assertEquals(school.isStudent,true, 'Student is not recognized as student');
                 }
   		}
    
        @isTest static void testConstructorIsTeacher() {
        
        	User u = TestSchoolDummyData.generateUser();
        	insert u;
        	PermissionSetAssignment per = TestSchoolDummyData.getPermissionSetAssignment('Teacher',u.id);
      	 	insert per;
        
            System.runAs(u) {
                SchoolSecurity3_SC school = new SchoolSecurity3_SC();
                System.assertEquals(school.isTeacher,true, 'Teacher is not recognized as teacher');
            }
    }
}