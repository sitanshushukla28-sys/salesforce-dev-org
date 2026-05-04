import { LightningElement, track } from 'lwc';
export default class ChildToParentParent extends LightningElement {
    @track messageFromChild = '';

    handleChildMessage(event) {
        // Handle message from child component
        this.messageFromChild = event.detail;
        console.log('Message from child:', this.messageFromChild);
    }
}