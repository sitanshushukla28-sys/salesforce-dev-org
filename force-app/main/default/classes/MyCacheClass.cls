public class MyCacheClass {
    private static Map<String, Object> cache = new Map<String, Object>();

    public static Object getCachedData() {
        if (!cache.containsKey('myCacheKey')) {
            // If not in the cache, query the data and put it in the cache
            cache.put('myCacheKey', [SELECT Id, Name FROM Account LIMIT 10]);
        }

        return cache.get('myCacheKey');
    }
}