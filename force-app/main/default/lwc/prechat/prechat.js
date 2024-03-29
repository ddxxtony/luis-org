import BasePrechat from 'lightningsnapin/basePrechat';
import { api, track } from 'lwc';

export default class Prechat extends BasePrechat {

    _prechatFields = {};
    get prechatFields(){
        return _prechatFields;
    }
    @api
    set prechatFields(value){
        this._prechatFields = value
    }
    @api fbackgroundImgURL;
    @track fields;
    @track namelist;
    startChatLabel;

    /**
     * Set the button label and prepare the prechat fields to be shown in the form.
     */
    connectedCallback() {
        console.log('changes here luis');
        this.startChatLabel = 'Welcome'; 
        this.fields = this._prechatFields.map(field => {
            const { label, name, value, required, maxLength } = field;

            return { label, value, name, required, maxLength };
        });
        this.namelist = this.fields.map(field => field.name);
    }

    /**
     * Focus on the first input after this component renders.
     */
    renderedCallback() {
        this.template.querySelector("lightning-input").focus();
    }

    /**
     * On clicking the 'Start Chatting' button, send a chat request.
     */
    handleStartChat() {
        this.template.querySelectorAll("lightning-input").forEach(input => {
            this.fields[this.namelist.indexOf(input.name)].value = input.value;
        });
        if (this.validateFields(this.fields).valid) {

            var event = new CustomEvent(
                "setCustomField",
                { 
                    detail: {
                        callback: this.startChat.bind(this, this.fields), 
                        customField: "Luis From  ssdfds sldfsldfsLWC"  
                    }
                }
            ); 
            // Dispatch the event.
            document.dispatchEvent(event);  
           // this.startChat(this.fields);

        } else {
            // Error handling if fields do not pass validation.
        }
    }
}