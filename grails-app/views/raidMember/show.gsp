
<%@ page import="org.stevegood.sk.RaidMember" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'raidMember.label', default: 'RaidMember')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-raidMember" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-raidMember" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list raidMember">
			
				<g:if test="${raidMemberInstance?.note}">
				<li class="fieldcontain">
					<span id="note-label" class="property-label"><g:message code="raidMember.note.label" default="Note" /></span>
					
						<span class="property-value" aria-labelledby="note-label"><g:fieldValue bean="${raidMemberInstance}" field="note"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${raidMemberInstance?.raid}">
				<li class="fieldcontain">
					<span id="raid-label" class="property-label"><g:message code="raidMember.raid.label" default="Raid" /></span>
					
						<span class="property-value" aria-labelledby="raid-label"><g:link controller="raid" action="show" id="${raidMemberInstance?.raid?.id}">${raidMemberInstance?.raid?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${raidMemberInstance?.character}">
				<li class="fieldcontain">
					<span id="character-label" class="property-label"><g:message code="raidMember.character.label" default="Character" /></span>
					
						<span class="property-value" aria-labelledby="character-label"><g:link controller="playerCharacter" action="show" id="${raidMemberInstance?.character?.id}">${raidMemberInstance?.character?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${raidMemberInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="raidMember.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${raidMemberInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${raidMemberInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="raidMember.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${raidMemberInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${raidMemberInstance?.onLeave}">
				<li class="fieldcontain">
					<span id="onLeave-label" class="property-label"><g:message code="raidMember.onLeave.label" default="On Leave" /></span>
					
						<span class="property-value" aria-labelledby="onLeave-label"><g:formatBoolean boolean="${raidMemberInstance?.onLeave}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${raidMemberInstance?.substitute}">
				<li class="fieldcontain">
					<span id="substitute-label" class="property-label"><g:message code="raidMember.substitute.label" default="Substitute" /></span>
					
						<span class="property-value" aria-labelledby="substitute-label"><g:formatBoolean boolean="${raidMemberInstance?.substitute}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:raidMemberInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${raidMemberInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
