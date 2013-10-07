
<%@ page import="org.stevegood.sk.RaidManager" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'raidManager.label', default: 'RaidManager')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-raidManager" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-raidManager" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="raidManager.raid.label" default="Raid" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'raidManager.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'raidManager.lastUpdated.label', default: 'Last Updated')}" />
					
						<th><g:message code="raidManager.manager.label" default="Manager" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${raidManagerInstanceList}" status="i" var="raidManagerInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${raidManagerInstance.id}">${fieldValue(bean: raidManagerInstance, field: "raid")}</g:link></td>
					
						<td><g:formatDate date="${raidManagerInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${raidManagerInstance.lastUpdated}" /></td>
					
						<td>${fieldValue(bean: raidManagerInstance, field: "manager")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${raidManagerInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
