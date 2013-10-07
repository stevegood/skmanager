<%@ page import="org.stevegood.sk.RaidManager" %>



<div class="fieldcontain ${hasErrors(bean: raidManagerInstance, field: 'raid', 'error')} required">
	<label for="raid">
		<g:message code="raidManager.raid.label" default="Raid" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="raid" name="raid.id" from="${org.stevegood.sk.Raid.list()}" optionKey="id" required="" value="${raidManagerInstance?.raid?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: raidManagerInstance, field: 'manager', 'error')} required">
	<label for="manager">
		<g:message code="raidManager.manager.label" default="Manager" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="manager" name="manager.id" from="${org.stevegood.sec.User.list()}" optionKey="id" required="" value="${raidManagerInstance?.manager?.id}" class="many-to-one"/>
</div>

