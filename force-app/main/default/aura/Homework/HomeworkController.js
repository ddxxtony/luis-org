({
    showFormAction: function(cmp, event) {
        // This will contain the string of the "value" attribute of the selected option
        cmp.set("v.showForm", true);
        cmp.set("v.recordId", cmp.find("comboBoxAcc").get("v.value") );
    },
    onLoadAction: function(cmp, event) {
        // This will contain the string of the "value" attribute of the selected option
        console.log('edit loaded');
    },
    displayList: function(cmp, event) {
        cmp.set("v.displayList", true);
        cmp.set("v.recordId", null);
        cmp.set("v.showForm", false);
    },
    // Load expenses from Salesforce
    doInit: function(component, event, helper) {
        helper.getAcc(component);
    },
    handleSuccess: function(component, event, helper) {
        component.find('notifLib').showToast({
            "variant": "success",
            "title": "Account Created",
            "message": "Record ID: " + event.getParam("id")
        });
    },
    handleDeleteRecord: function(component, event, helper) {
        console.log("Reconoce el handleDeleteRecord ", component.find("comboBoxAcc").get("v.value"));
        console.log(component.find("comboBoxAcc").get("v.value").toString());
        var deleteResult = new Promise(function(resolve, reject) {

            component.find("recordHandler").reloadRecord(true, $A.getCallback(function() {
                component.find("recordHandler").deleteRecord($A.getCallback(function(deleteResult) {
                    resolve(deleteResult);
                }));
            }));
        }).then(function(deleteResult) {
            console.log("Entró a la funcion Delete");
            if (deleteResult.state === "SUCCESS" || deleteResult.state === "DRAFT") {
                // record is deleted
                console.log("Record is deleted.");
            } else if (deleteResult.state === "INCOMPLETE") {
                console.log("User is offline, device doesn't support drafts.");
            } else if (deleteResult.state === "ERROR") {
                console.log('Problem deleting record, error: ' + JSON.stringify(deleteResult.error));
            } else {
                console.log('Unknown problem, state: ' + deleteResult.state + ', error: ' + JSON.stringify(deleteResult.error));
            }
            helper.getAcc(component);
        })
    },
    handleRecordUpdated: function(component, event, helper) {
        console.log("Entra al metodo recordUpdated");
        var eventParams = event.getParams();
        if (eventParams.changeType === "CHANGED") {
            // record is changed
        } else if (eventParams.changeType === "LOADED") {
            // record is loaded in the cache
        } else if (eventParams.changeType === "REMOVED") {
            // record is deleted, show a toast UI message
            var resultsToast = $A.get("e.force:showToast");
            resultsToast.setParams({
                "title": "Deleted",
                "message": "The record was deleted."
            });
            resultsToast.fire();

        } else if (eventParams.changeType === "ERROR") {
            // there’s an error while loading, saving, or deleting the record
        }
    }


})