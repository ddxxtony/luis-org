({
    getAcc: function(component) {
        component.set("v.spinnerRender", true);
        // Create the action
        

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