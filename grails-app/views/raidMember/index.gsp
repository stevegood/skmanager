
<%@ page import="org.stevegood.sk.RaidMember" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'raidMember.label', default: 'RaidMember')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-raidMember" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-raidMember" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="note" title="${message(code: 'raidMember.note.label', default: 'Note')}" />
					
						<th><g:message code="raidMember.raid.label" default="Raid" /></th>
					
						<th><g:message code="raidMember.character.label" default="Character" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'raidMember.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'raidMember.lastUpdated.label', default: 'Last Updated')}" />
					
						<g:sortableColumn property="onLeave" title="${message(code: 'raidMember.onLeave.label', default: 'On Leave')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${raidMemberInstanceList}" status="i" var="raidMemberInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${raidMemberInstance.id}">${fieldValue(bean: raidMemberInstance, field: "note")}</g:link></td>
					
						<td>${fieldValue(bean: raidMemberInstance, field: "raid")}</td>
					
						<td>${fieldValue(bean: raidMemberInstance, field: "character")}</td>
					
						<td><g:formatDate date="${raidMemberInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${raidMemberInstance.lastUpdated}" /></td>
					
						<td><g:formatBoolean boolean="${raidMemberInstance.onLeave}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${raidMemberInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
