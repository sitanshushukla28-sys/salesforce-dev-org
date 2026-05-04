import { LightningElement, track } from 'lwc';

export default class ChildToParentChild extends LightningElement {
    @track childMessage = '';

    handleChange(event) {
        this.childMessage = event.target.value;
    }

    handleClick() {
        const message = this.childMessage;
        // Dispatch custom event to send message to parent
        this.dispatchEvent(new CustomEvent('message', { detail: message }));
    }
}