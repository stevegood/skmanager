<%@ page import="org.stevegood.sk.RaidMember" %>



<div class="fieldcontain ${hasErrors(bean: raidMemberInstance, field: 'note', 'error')} ">
	<label for="note">
		<g:message code="raidMember.note.label" default="Note" />
		
	</label>
	<g:textField name="note" value="${raidMemberInstance?.note}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: raidMemberInstance, field: 'raid', 'error')} required">
	<label for="raid">
		<g:message code="raidMember.raid.label" default="Raid" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="raid" name="raid.id" from="${org.stevegood.sk.Raid.list()}" optionKey="id" required="" value="${raidMemberInstance?.raid?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: raidMemberInstance, field: 'character', 'error')} required">
	<label for="character">
		<g:message code="raidMember.character.label" default="Character" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="character" name="character.id" from="${org.stevegood.game.PlayerCharacter.list()}" optionKey="id" required="" value="${raidMemberInstance?.character?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: raidMemberInstance, field: 'onLeave', 'error')} ">
	<label for="onLeave">
		<g:message code="raidMember.onLeave.label" default="On Leave" />
		
	</label>
	<g:checkBox name="onLeave" value="${raidMemberInstance?.onLeave}" />
</div>

<div class="fieldcontain ${hasErrors(bean: raidMemberInstance, field: 'substitute', 'error')} ">
	<label for="substitute">
		<g:message code="raidMember.substitute.label" default="Substitute" />
		
	</label>
	<g:checkBox name="substitute" value="${raidMemberInstance?.substitute}" />
</div>

