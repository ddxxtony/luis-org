({
	fireEvent : function(c, e, h) {
		var event = c.getEvent('testingEvent');	
        event.setParams({ text2: 'Hello World!'});
        event.fire(); 
  	}
})