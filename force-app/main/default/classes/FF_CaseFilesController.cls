public with sharing class FF_CaseFilesController {

    @AuraEnabled(cacheable=true)
    public static List<ContentDocumentLink> getCaseFiles(Id caseId) {
        if (caseId == null) return new List<ContentDocumentLink>();

        // Get all ContentDocumentLinks related to the Case
        return [
            SELECT Id,
                   ContentDocumentId,
                   ContentDocument.Title,
                   ContentDocument.FileType,
                   ContentDocument.CreatedDate,
                   ContentDocument.CreatedBy.Name,
                   ContentDocument.LatestPublishedVersionId
            FROM ContentDocumentLink
            WHERE LinkedEntityId = :caseId
            ORDER BY ContentDocument.CreatedDate DESC
        ];
    }
}