<aura:application >
	<aura:handler name="testingEvent" event="c:testingEvent" action="{!c.handleEvent}" ></aura:handler>
   <div style="padding:30px;background-color:Blue">
            <h1>App</h1>
           
        <c:parentEventComponent></c:parentEventComponent>
    </div>
</aura:application>