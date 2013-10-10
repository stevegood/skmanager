<%@ page import="org.stevegood.game.PlayerCharacter" %>

<div class="form-group ${hasErrors(bean: playerCharacterInstance, field: 'name', 'error')} required">
	<label for="name" class="col-lg-4 control-label">
		<g:message code="playerCharacter.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-lg-8">
        <g:textField name="name" class="form-control" required="" value="${playerCharacterInstance?.name}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: playerCharacterInstance, field: 'characterClass', 'error')} required">
	<label for="characterClass" class="col-lg-4 control-label">
		<g:message code="playerCharacter.characterClass.label" default="Character Class" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-lg-8">
        <g:select id="characterClass" name="characterClass.id" from="${org.stevegood.game.CharacterClass.list()}" optionKey="id" required="" value="${playerCharacterInstance?.characterClass?.id}" class="many-to-one form-control"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: playerCharacterInstance, field: 'level', 'error')} required">
	<label for="level" class="col-lg-4 control-label">
		<g:message code="playerCharacter.level.label" default="Level" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-lg-8">
        <g:field name="level" class="form-control" type="number" min="1" value="${playerCharacterInstance.level}" required=""/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: playerCharacterInstance, field: 'note', 'error')} ">
	<label for="note" class="col-lg-4 control-label">
		<g:message code="playerCharacter.note.label" default="Note" />
		
	</label>
	<div class="col-lg-8">
        <g:textArea name="note" value="${playerCharacterInstance?.note}" class="form-control" rows="3"/>
	</div>
</div>

