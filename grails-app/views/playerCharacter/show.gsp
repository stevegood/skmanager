
<%@ page import="org.stevegood.game.PlayerCharacter" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'playerCharacter.label', default: 'PlayerCharacter')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-playerCharacter" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-playerCharacter" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list playerCharacter">
			
				<g:if test="${playerCharacterInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="playerCharacter.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${playerCharacterInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerCharacterInstance?.characterClass}">
				<li class="fieldcontain">
					<span id="characterClass-label" class="property-label"><g:message code="playerCharacter.characterClass.label" default="Character Class" /></span>
					
						<span class="property-value" aria-labelledby="characterClass-label"><g:link controller="characterClass" action="show" id="${playerCharacterInstance?.characterClass?.id}">${playerCharacterInstance?.characterClass?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerCharacterInstance?.level}">
				<li class="fieldcontain">
					<span id="level-label" class="property-label"><g:message code="playerCharacter.level.label" default="Level" /></span>
					
						<span class="property-value" aria-labelledby="level-label"><g:fieldValue bean="${playerCharacterInstance}" field="level"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerCharacterInstance?.note}">
				<li class="fieldcontain">
					<span id="note-label" class="property-label"><g:message code="playerCharacter.note.label" default="Note" /></span>
					
						<span class="property-value" aria-labelledby="note-label"><g:fieldValue bean="${playerCharacterInstance}" field="note"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerCharacterInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="playerCharacter.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${playerCharacterInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerCharacterInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="playerCharacter.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${playerCharacterInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:playerCharacterInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${playerCharacterInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
