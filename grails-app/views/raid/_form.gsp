<%@ page import="org.stevegood.sk.Raid" %>



<div class="fieldcontain ${hasErrors(bean: raidInstance, field: 'owner', 'error')} required">
	<label for="owner">
		<g:message code="raid.owner.label" default="Owner" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="owner" name="owner.id" from="${org.stevegood.sec.User.list()}" optionKey="id" required="" value="${raidInstance?.owner?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: raidInstance, field: 'hidden', 'error')} ">
	<label for="hidden">
		<g:message code="raid.hidden.label" default="Hidden" />
		
	</label>
	<g:checkBox name="hidden" value="${raidInstance?.hidden}" />
</div>

<div class="fieldcontain ${hasErrors(bean: raidInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="raid.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${raidInstance?.name}"/>
</div>

