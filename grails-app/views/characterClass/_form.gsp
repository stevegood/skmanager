<%@ page import="org.stevegood.game.CharacterClass" %>



<div class="fieldcontain ${hasErrors(bean: characterClassInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="characterClass.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${characterClassInstance?.name}"/>
</div>

