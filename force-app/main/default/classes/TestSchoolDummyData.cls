@isTest
public class TestSchoolDummyData {

    public static User generateUser (){
        
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        
         Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
         User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
                        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                        LocaleSidKey='en_US',ProfileId = p.Id, 
                        TimeZoneSidKey='America/Los_Angeles',
                              UserName=uniqueUserName);
       

        return u;
    }
    
    public static PermissionSetAssignment getPermissionSetAssignment (String permissionName, String userId) {
        
        PermissionSetAssignment permission = [SELECT  PermissionSet.id
                                                  FROM PermissionSetAssignment 
                                                  WHERE PermissionSet.Name =: permissionName  limit 1 ];
       	if(permission==null)
            return null;
        
         PermissionSetAssignment per = new PermissionSetAssignment(AssigneeId=userId, PermissionSetId=permission.PermissionSet.id);
      	 return per;
    }
    
}