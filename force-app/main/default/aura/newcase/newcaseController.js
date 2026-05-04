({
    callScreenFlow : function(component, event, helper) {
        var flow = component.find("myFlow");
        flow.startFlow("Flow_Test"); // Replace with your flow's API name
    }
})