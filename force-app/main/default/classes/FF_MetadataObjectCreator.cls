public with sharing class FF_MetadataObjectCreator {

    public class CustomFieldDefinition {
        public String fieldName;
        public String label;
        public String type;
        public Integer length;

        public CustomFieldDefinition(String fieldName, String label, String type, Integer length) {
            this.fieldName = fieldName;
            this.label = label;
            this.type = type;
            this.length = length;
        }
    }

    public static void createCustomObjectAndFields(String objectName, String label, List<CustomFieldDefinition> fields) {
        MetadataService.MetadataPort service = createService();

        // Create Custom Object
        MetadataService.CustomObject customObject = new MetadataService.CustomObject();
        customObject.fullName = objectName + '__c';
        customObject.label = label;
        customObject.pluralLabel = label + 's';
        customObject.nameField = new MetadataService.CustomField();
        customObject.nameField.type_x = 'Text';
        customObject.nameField.label = label + ' Name';
        customObject.deploymentStatus = 'Deployed';
        customObject.sharingModel = 'ReadWrite';

        List<MetadataService.SaveResult> objectResults = service.createMetadata(
            new MetadataService.Metadata[] { customObject }
        );
        logResults(objectResults, 'Custom Object');

        // Add Fields
        List<MetadataService.Metadata> metadataFields = new List<MetadataService.Metadata>();

        for (CustomFieldDefinition f : fields) {
            MetadataService.CustomField field = new MetadataService.CustomField();
            field.fullName = objectName + '__c.' + f.fieldName + '__c';
            field.label = f.label;
            field.type_x = f.type;
            if (f.type == 'Text' && f.length != null) {
                field.length = f.length;
            }
            metadataFields.add(field);
        }

        if (!metadataFields.isEmpty()) {
            List<MetadataService.SaveResult> fieldResults = service.createMetadata(metadataFields);
            logResults(fieldResults, 'Custom Field(s)');
        }
    }

    private static MetadataService.MetadataPort createService() {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }

    private static void logResults(List<MetadataService.SaveResult> results, String label) {
        for (MetadataService.SaveResult result : results) {
            if (result.success) {
                System.debug(label + ' creation successful: ' + result.fullName);
            } else {
                for (MetadataService.Error error : result.errors) {
                    System.debug(label + ' creation failed: ' + error.message);
                }
            }
        }
    }
}