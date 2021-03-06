
<%@ page import="org.stevegood.game.CharacterRole" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'characterRole.label', default: 'CharacterRole')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-characterRole" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-characterRole" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="characterRole.role.label" default="Role" /></th>
					
						<th><g:message code="characterRole.character.label" default="Character" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${characterRoleInstanceList}" status="i" var="characterRoleInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${characterRoleInstance.id}">${fieldValue(bean: characterRoleInstance, field: "role")}</g:link></td>
					
						<td>${fieldValue(bean: characterRoleInstance, field: "character")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${characterRoleInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
