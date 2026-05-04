public class TestOpenURLAction {
    @InvocableMethod
    public static void openURL(List<String> urls) {
        for (String url : urls) {
            System.PageReference pageRef = new System.PageReference(url);
            pageRef.setRedirect(true);
            pageRef.getHeaders().put('X-OpenUrl', 'true');
            throw new System.CalloutException(pageRef.getUrl());
        }
    }
}