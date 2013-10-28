<%@ page import="org.stevegood.sk.RaidManager" %>

<g:hiddenField name="raid.id" value="${raidManagerInstance?.raid?.id}" />

<div class="form-group ${hasErrors(bean: raidManagerInstance, field: 'manager', 'error')} required">
	<label for="manager" class="control-label col-lg-3">
		<g:message code="raidManager.manager.label" default="Manager" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-lg-9">
        <g:select id="manager" name="manager.id" from="${users}" optionKey="id" required="" value="${raidManagerInstance?.manager?.id}" class="form-control"/>
	</div>
</div>

