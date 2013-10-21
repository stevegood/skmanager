<%@ page import="org.stevegood.game.PlayerCharacter" %>

<div class="form-group ${hasErrors(bean: playerCharacterInstance, field: 'name', 'error')} required">
	<label for="name" class="col-lg-3 control-label">
		<g:message code="playerCharacter.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-lg-9">
        <g:textField name="name" class="form-control" required="" value="${playerCharacterInstance?.name}"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: playerCharacterInstance, field: 'characterClass', 'error')} required">
	<label for="characterClass" class="col-lg-3 control-label">
		<g:message code="playerCharacter.characterClass.label" default="Class" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-lg-9">
        <g:select id="characterClass" name="characterClass.id" from="${org.stevegood.game.CharacterClass.list()}" optionKey="id" required="" value="${playerCharacterInstance?.characterClass?.id}" class="many-to-one form-control"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: playerCharacterInstance, field: 'level', 'error')} required">
	<label for="level" class="col-lg-3 control-label">
		<g:message code="playerCharacter.level.label" default="Level" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-lg-9">
        <g:field name="level" class="form-control" type="number" min="1" value="${playerCharacterInstance.level}" required=""/>
	</div>
</div>

<div class="form-group">
    <label class="col-lg-3 control-label" for="roles">
        Roles
        <span class="required-indicator">*</span>
    </label>
    <div class="col-lg-9">
        <g:select name="roles" from="${roleInstanceList}" optionKey="id" value="${playerCharacterInstance?.roles}"
                  multiple="multiple" class="form-control" required="required" />
    </div>
</div>

<div class="form-group ${hasErrors(bean: playerCharacterInstance, field: 'note', 'error')} ">
	<label for="note" class="col-lg-3 control-label">
		<g:message code="playerCharacter.note.label" default="Note" />
		
	</label>
	<div class="col-lg-9">
        <g:textArea name="note" value="${playerCharacterInstance?.note}" class="form-control" rows="3"/>
	</div>
</div>

