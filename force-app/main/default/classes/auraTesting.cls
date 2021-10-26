public with sharing class auraTesting {

    @AuraEnabled
    public static List<Account> getAccounts(  ){

        return [ Select id, name from Account ];
    }

    @AuraEnabled
    public static TestinW getWrapper2(  TestinW x ){
        Integer p = 0;
        if(p == 0){
            throw new AuraHandledException('error'); 
        }

        return x;
    }

    public class TestinW {
        @AuraEnabled
        public string name {get;Set;}
        
 
    }
   
}
 