
<%@ page import="org.stevegood.sk.Raid" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'raid.label', default: 'Raid')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-raid" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-raid" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="raid.owner.label" default="Owner" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'raid.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="hidden" title="${message(code: 'raid.hidden.label', default: 'Hidden')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'raid.lastUpdated.label', default: 'Last Updated')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'raid.name.label', default: 'Name')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${raidInstanceList}" status="i" var="raidInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${raidInstance.id}">${fieldValue(bean: raidInstance, field: "owner")}</g:link></td>
					
						<td><g:formatDate date="${raidInstance.dateCreated}" /></td>
					
						<td><g:formatBoolean boolean="${raidInstance.hidden}" /></td>
					
						<td><g:formatDate date="${raidInstance.lastUpdated}" /></td>
					
						<td>${fieldValue(bean: raidInstance, field: "name")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${raidInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
