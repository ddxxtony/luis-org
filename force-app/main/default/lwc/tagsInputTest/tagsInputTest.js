import { api, LightningElement } from 'lwc';

export default class TagsInputTest extends LightningElement {

    
    _selectedEmails = [{email: 'luis.aguilar@hotmail.com', key: ''}];
    showError = false;

    @api
    get selectedEmails(){
        return this._selectedEmails;
    }
    set selectedEmails(value){
        this._selectedEmails = JSON.parse(JSON.stringify(value));
    }
    showError = false;

    handleKeyPress (e){
        const value = e.target.value.replace(/,/g, '');
        if((e.keyCode === 13 || e.keyCode === 188) && value ){ // enter button
            e.target.value = '';
            this._selectedEmails = [...this.selectedEmails, { email: value.trim(), key: this. getUniqueID() }]; 
          } 
    } 

    handleCrossClick(e){
        const key = e.target.dataset.key;
        this._selectedEmails = this._selectedEmails.filter(({ key: itemKey })=> itemKey !== key );
    }
    
    getUniqueID (){
        return Date.now().toString(36) + Math.random().toString(36).substr(2);
    }
}