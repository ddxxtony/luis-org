({
	getResult : function(cmp, event, helper) {
        var op1 =Number(cmp.find("op1").get("v.value"));
        var op2 = Number(cmp.find("op2").get("v.value"));
        
        cmp.set("v.result", op1+op2);
		
	}
})