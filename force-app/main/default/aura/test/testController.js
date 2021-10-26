({
    getAccountsFromApex: function(cmp,e, h){
        var action = cmp.get("c.getAccounts");
        //action.setParams({ ids : cmp.get("v.ids") });

        action.setCallback(this, h.callbackMethod.bind(this, cmp)  );
        $A.enqueueAction(action);
    } 

    ,getWrapper: function (c,e,h){
        var action = c.get("c.getWrapper2"); 
        action.setParams({ x: { name: 'Lui' }  });

        action.setCallback(this, $A.getCallback(function(response){
         
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('Success');
                console.log(JSON.stringify(response.getReturnValue()));
            }
            else if (state === "INCOMPLETE") {
                console.log('incomplete');
            }
            else if (state === "ERROR") { 
                console.log('error'); 
                console.log(response.getError()); 
                /*c.find('notifLib').showNotice({
                    "variant": "error",
                    "header": "Something has gone wrong!",
                    "message": "Unfortunately, there was a problem updating the record.",
                    closeCallback: function() {
                        alert('You closed the alert!');
                    }
                });*/
            }
        }));
        $A.enqueueAction(action);
    }
})