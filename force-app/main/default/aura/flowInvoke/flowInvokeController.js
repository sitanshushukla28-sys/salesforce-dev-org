({
    init : function (component) {
        // Find the component whose aura:id is "flowId"
        var flow = component.find("New_Lead")
        flow.startFlow("New_Lead");
    },
})