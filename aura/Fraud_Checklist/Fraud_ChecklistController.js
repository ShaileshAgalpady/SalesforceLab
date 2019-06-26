({
    getChecklist : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Fraud Checklist Name', fieldName: 'Name', type: 'text'},
            {label: 'Created Date', fieldName: 'CreatedDate', type: 'date'}
        ]);
        
        var action = component.get("c.getFraudChecklist");
        action.setParams({
            "accountId": component.get("v.recordId")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.checklist", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})