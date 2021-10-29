({
     // Method to fire application event
	fireApplicationEvent: function(component, event, helper) {
        var appEvent = $A.get("e.c:LightningApplicationEvent");
        appEvent.setParams({
            message: "Hello"
        });
        appEvent.fire();
	},
    handleApplicationEventInDEfault: function(component, event, helper) {
        
        alert('Application event in app ');
    }
    
})