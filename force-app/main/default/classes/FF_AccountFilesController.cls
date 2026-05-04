public with sharing class FF_AccountFilesController {

    @AuraEnabled(cacheable=true)
    public static List<ContentDocumentLink> getAccountFiles(Id accountId) {
        if (accountId == null) return new List<ContentDocumentLink>();

        return [
            SELECT Id,
                   ContentDocumentId,
                   ContentDocument.Title,
                   ContentDocument.FileType,
                   ContentDocument.CreatedDate,
                   ContentDocument.CreatedBy.Name,
                   ContentDocument.LatestPublishedVersionId
            FROM ContentDocumentLink
            WHERE LinkedEntityId = :accountId
            ORDER BY ContentDocument.CreatedDate DESC
        ];
    }
}