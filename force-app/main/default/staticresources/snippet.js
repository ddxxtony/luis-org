console.log('code loaded luis');
//case_fake_record_tpye__c, case fake record tpye, another_field__c, another field

//case_fake_record_tpye__c, case fake record tpye



/*embedded_svc.settings.extraPrechatInfo = [{
    "entityName":"Case",
    "showOnCreate":true,
    "entityFieldMaps":[{
            "isExactMatch":false,
            "fieldName":"Business_Unit__c",
            "doCreate":true,
            "doFind":false,
            "label":"Business Unit" 
        }]
    }];*/
   


    /*embedded_svc.snippetSettingsFile.extraPrechatFormDetails = [
        {
            "label": "Case Subject",
            "transcriptFields": ["CaseSubject__c"],
            "displayToAgent":true
        }
    ];*/
   embedded_svc.snippetSettingsFile.extraPrechatFormDetails = [
       {
         "label":"case fake record tpye",
         "transcriptFields":["case_fake_record_tpye__c"],
        },
        {
            "label":"another field",
            "transcriptFields":["another_field__c"],
           }
    ] ;


    document.addEventListener(
        "setCustomField",
        function(event) {
            embedded_svc.snippetSettingsFile.extraPrechatFormDetails[1].value = event.detail.customField;
            // Fire startChat callback.
            event.detail.callback();
        },
        false
    ); 