<%@ page import="org.stevegood.game.GameRole" %>



<div class="fieldcontain ${hasErrors(bean: gameRoleInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="gameRole.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${gameRoleInstance?.name}"/>
</div>

