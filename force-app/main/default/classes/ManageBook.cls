@RestResource(urlMapping ='/v1/manageBook/')
global class ManageBook {
    @HttpGet
    global static Book__c doGetBook(){
        Book__c book = new Book__c();
        Map<String, String> paramsMap = RestContext.request.params;
        String bookId =  paramsMap.get('Id');
        book = [Select Name, Id from Book__c where Id = :bookId ];
        return book;
    }
    
    @HttpDelete
    global static String doDeleteBook(){
        Book__c book = new Book__c();
        Map<String, String> paramsMap = RestContext.request.params;
        String bookId =  paramsMap.get('Id');
        book = [Select Name, Id from Book__c where Id = :bookId ];
        delete book;
        return 'Successful';
    }
    
    @HttpPost
    global Static Book__c doCreateBook(String name){
        Book__c book = new Book__c(Name = name);
        insert book;
        return book;
    }
    
    @HttpPut
    global Static Book__c doUpdateBook(String name){
        Map<String, String> paramsMap = RestContext.request.params;
        String bookId =  paramsMap.get('Id');
        Book__c book = new Book__c(Name = name, Id = bookId);
        Update book;
        return book;
    }
}