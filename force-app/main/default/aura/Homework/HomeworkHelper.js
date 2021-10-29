({
    getAcc: function(component) {
        component.set("v.spinnerRender", true);
        // Create the action
        let action = component.get("c.getAccounts");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let list = response.getReturnValue().map((a) => ({ label: a.Name, value: a.Id }));
                component.set("v.account", list);

            } else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);

        component.set("v.actionName", '');
        setTimeout(function() {
            console.log("Ready")
            component.set("v.spinnerRender", false);
        }, 500);

        component.set("v.displayList", false);
        component.set("v.actionName", '');
        component.set("v.showForm", false);

    }
})