<!-- Lightning Application extending slds -->
<aura:application extends="force:slds">
	
    <aura:handler event="c:LightningApplicationEvent" action="{!c.handleApplicationEventInDEfault}" phase="bubble"/>
    <aura:registerEvent name="myAppEvent" type="c:LightningApplicationEvent" />
    <lightning:button onclick="{!c.fireApplicationEvent}">Fire Event</lightning:button>
    <!-- Calling the application event container components -->
    <div class="slds-box">
	    <div class="slds-text-heading_medium slds-text-align_center">Application Event Below</div>
        <c:LightningEventsAppContainer id="1" />
        <br />
        <c:LightningEventsAppContainer id="2" />    
    </div>
</aura:application>