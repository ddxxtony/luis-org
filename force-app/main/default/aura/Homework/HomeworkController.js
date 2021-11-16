({
    showFormAction: function(cmp, event) {
        cmp.set("v.showForm", true);
    },
    hideFormAction: function(cmp, event){
        cmp.set("v.showForm", false);
    },
    onLoadAction : function (){
        console.log('rec loaded');
    }



})