public class IndiaPostCallout {

    // Unique label corresponding to the continuation
    public String requestLabel;
    public String result {get;set;}
    public List<Object> postalCode {get;set;}
    
    public IndiaPostCallout(){ 
        postalCode =new List<Object>();
    }

    
    public Object  makeGetCallout() {
        Continuation con = new Continuation(40);
        con.continuationMethod='processResponse';
    
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
    
        // Add callout request to continuation
        this.requestLabel = con.addHttpRequest(request);
        // Return the continuation
        return con; 
    }
    
    public Object processResponse() {  
        HttpResponse response = Continuation.getResponse(this.requestLabel);

        // Set the result variable that is displayed on the Visualforce page
        if (response.getStatusCode() == 200) {
            this.result = response.getBody();
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            postalCode = (List<Object>) results.get('postalCode');
        }
        return null;
    }
        
}