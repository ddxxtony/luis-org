({
    callbackMethod : function(cmp, response) {
        var state = response.getState();
        if (state === "SUCCESS") {
            // Alert the user with the value returned 
            // from the server
            alert("From server: " + response.getReturnValue());

            cmp.set('v.accounts',  response.getReturnValue());

            // You would typically fire a event here to trigger 
            // client-side notification that the server-side 
            // action is complete
        }
        else if (state === "INCOMPLETE") {
            // do something
        }
        else if (state === "ERROR") {
            var errors = response.getError();
            if (errors) {
                if (errors[0] && errors[0].message) {
                    console.log("Error message: " + 
                             errors[0].message);
                }
            } else {
                console.log("Unknown error");
            }
        }
    }
})