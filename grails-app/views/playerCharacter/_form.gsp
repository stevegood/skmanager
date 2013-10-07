<%@ page import="org.stevegood.game.PlayerCharacter" %>



<div class="fieldcontain ${hasErrors(bean: playerCharacterInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="playerCharacter.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${playerCharacterInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playerCharacterInstance, field: 'characterClass', 'error')} required">
	<label for="characterClass">
		<g:message code="playerCharacter.characterClass.label" default="Character Class" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="characterClass" name="characterClass.id" from="${org.stevegood.game.CharacterClass.list()}" optionKey="id" required="" value="${playerCharacterInstance?.characterClass?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playerCharacterInstance, field: 'level', 'error')} required">
	<label for="level">
		<g:message code="playerCharacter.level.label" default="Level" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="level" type="number" min="1" value="${playerCharacterInstance.level}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: playerCharacterInstance, field: 'note', 'error')} ">
	<label for="note">
		<g:message code="playerCharacter.note.label" default="Note" />
		
	</label>
	<g:textField name="note" value="${playerCharacterInstance?.note}"/>
</div>

