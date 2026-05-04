import { LightningElement, api, wire } from 'lwc';
import getCaseFiles from '@salesforce/apex/FF_CaseFilesController.getCaseFiles';
import { NavigationMixin } from 'lightning/navigation';

export default class Ff_caseFiles extends NavigationMixin(LightningElement) {
    @api recordId;
    files;
    error;

    @wire(getCaseFiles, { caseId: '$recordId' })
    wiredFiles({ data, error }) {
        if (data) {
            this.files = data.map(file => ({
                id: file.ContentDocumentId,
                title: file.ContentDocument.Title,
                type: file.ContentDocument.FileType,
                owner: file.ContentDocument.CreatedBy.Name,
                date: file.ContentDocument.CreatedDate,
                versionId: file.ContentDocument.LatestPublishedVersionId
            }));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.files = undefined;
        }
    }

    get hasFiles() {
        return this.files && this.files.length > 0;
    }

    handlePreview(event) {
        const versionId = event.currentTarget.dataset.versionid;
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'filePreview'
            },
            state: {
                selectedRecordId: versionId
            }
        });
    }
}