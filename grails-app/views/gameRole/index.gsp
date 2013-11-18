
<%@ page import="org.stevegood.game.GameRole" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'gameRole.label', default: 'GameRole')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="nav" role="navigation">
                        <ul>
                            <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                            <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                        </ul>
                    </div>
                    <div id="list-gameRole" class="content scaffold-list" role="main">
                        <h1><g:message code="default.list.label" args="[entityName]" /></h1>
                        <g:if test="${flash.message}">
                            <div class="message" role="status">${flash.message}</div>
                        </g:if>
                        <table>
                            <thead>
                            <tr>
                                <th></th>
                                <g:sortableColumn property="name" title="${message(code: 'gameRole.name.label', default: 'Name')}" />

                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${gameRoleInstanceList}" status="i" var="gameRoleInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                    <td>
                                        <span class="role-icon-tiny">
                                            <g:if test="${gameRoleInstance.icon}">
                                                <g:link controller="gameRole" action="show" id="${gameRoleInstance.id}">
                                                    <img src="${createLink(controller: 'gameRole', action: 'icon', id: gameRoleInstance.id)}"
                                                         alt="${gameRoleInstance.name}"/>
                                                </g:link>
                                            </g:if>
                                        </span>
                                    </td>
                                    <td><g:link action="show" id="${gameRoleInstance.id}">${fieldValue(bean: gameRoleInstance, field: "name")}</g:link></td>

                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                        <div class="pagination">
                            <g:paginate total="${gameRoleInstanceCount ?: 0}" />
                        </div>
                    </div>
                </div>
            </div>
		</div>
	</body>
</html>
