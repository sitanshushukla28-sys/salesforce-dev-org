import { LightningElement, api, wire } from 'lwc';
import getAccountFiles from '@salesforce/apex/FF_AccountFilesController.getAccountFiles';
import { refreshApex } from '@salesforce/apex';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';

export default class Ff_accountFiles extends NavigationMixin(LightningElement) {
    @api recordId;
    wiredResult;
    files;
    error;

    @wire(getAccountFiles, { accountId: '$recordId' })
    wiredFiles(result) {
        this.wiredResult = result;
        const { data, error } = result;

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

    connectedCallback() {
        // periodically refresh without reload
        this.startAutoRefresh();
    }

    disconnectedCallback() {
        clearInterval(this.interval);
    }

    startAutoRefresh() {
        // Poll every 10 seconds (you can adjust)
        this.interval = setInterval(() => {
            refreshApex(this.wiredResult);
            getRecordNotifyChange([{ recordId: this.recordId }]);
        }, 10000);
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