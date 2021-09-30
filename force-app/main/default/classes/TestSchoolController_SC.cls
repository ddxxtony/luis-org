@isTest
public class TestSchoolController_SC {
    
   @isTest  static void TestCleanRecords(){
      SchoolController_SC sc = new SchoolController_SC();
       
     
       
        sc.getSchoolRecord().Currency__c= 25000;
        sc.getSchoolRecord().is_scholarship_applied__c = false;
        sc.getSchoolRecord().Subject__c = 'Test';
        sc.getSchoolRecord().Salary__c = 50000;
       sc.getSchoolRecord().User_Name__c = 'Test';
       sc.getSchoolRecord().Last_Name__c = 'Test';
       sc.getSchoolRecord().RecordType = [ SELECT Id, SobjectType, Name From RecordType where RecordType.Name = 'Teachers' and SobjectType = 'School__c'  limit 1 ];
       sc.getSchoolRecord().Department__c = 'Chemistry';
       sc.getSchoolRecord().User__c = 'test';
       sc.getSchoolRecord().Password__c = 'test123';
       sc.getSchoolRecord().Age__c = 65;
       sc.getSchoolRecord().Comments__c = 'Test test';
       sc.getSchoolRecord().email__c = 'Test@test.com';
       
       sc.onlyCleanFields();
       
       System.assertEquals(sc.getSchoolRecord().Currency__c, null, 'Payment Is not null');
       System.assertEquals(sc.getSchoolRecord().is_scholarship_applied__c, false, 'SchoolarShip Is not null');
       System.assertEquals(sc.getSchoolRecord().Salary__c, null, 'Salery Is not null');
       System.assertEquals(sc.getSchoolRecord().User_Name__c, null, 'User Name Is not null');
       System.assertEquals(sc.getSchoolRecord().Last_Name__c, null, 'Last Name Is not null');
       System.assertEquals(sc.getSchoolRecord().RecordType, null, 'RecordType Is not null');
       System.assertEquals(sc.getSchoolRecord().Department__c, null, 'Department Is not null');
       
       System.assertEquals(sc.getSchoolRecord().User__c, null, 'user Is not null');
       System.assertEquals(sc.getSchoolRecord().Password__c, null, 'Password Is not null');
       System.assertEquals(sc.getSchoolRecord().Age__c, null, 'Age Is not null');
       System.assertEquals(sc.getSchoolRecord().Comments__c, null, 'Commets Is not null');
       System.assertEquals(sc.getSchoolRecord().email__c, null, 'Email Is not null');
       
    }
    
    
    	
}