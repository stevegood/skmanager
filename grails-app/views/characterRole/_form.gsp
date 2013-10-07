<%@ page import="org.stevegood.game.CharacterRole" %>

<div class="fieldcontain ${hasErrors(bean: characterRoleInstance, field: 'character', 'error')} required">
    <label for="character">
        <g:message code="characterRole.character.label" default="Character" />
        <span class="required-indicator">*</span>
    </label>
    <g:select id="character" name="character.id" from="${org.stevegood.game.PlayerCharacter.list()}" optionKey="id" required="" value="${characterRoleInstance?.character?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: characterRoleInstance, field: 'role', 'error')} required">
	<label for="role">
		<g:message code="characterRole.role.label" default="Role" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="role" name="role.id" from="${org.stevegood.game.GameRole.list()}" optionKey="id" required="" value="${characterRoleInstance?.role?.id}" class="many-to-one"/>
</div>


