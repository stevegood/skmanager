
<%@ page import="org.stevegood.game.GameRole" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'gameRole.label', default: 'GameRole')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="nav" role="navigation">
                        <ul>
                            <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                            <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                            <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                        </ul>
                    </div>
                    <div id="show-gameRole" class="content scaffold-show" role="main">
                        <h1>
                            <span class="role-icon-small">
                                <g:if test="${gameRoleInstance.icon}">
                                    <img src="${createLink(controller: 'gameRole', action: 'icon', id: gameRoleInstance.id)}"
                                         alt="${gameRoleInstance.name}"/>
                                </g:if>
                            </span>
                            <g:message code="default.show.label" args="[entityName]" />
                        </h1>
                        <g:if test="${flash.message}">
                            <div class="message" role="status">${flash.message}</div>
                        </g:if>
                        <ol class="property-list gameRole">

                            <g:if test="${gameRoleInstance?.name}">
                                <li class="fieldcontain">
                                    <span id="name-label" class="property-label"><g:message code="gameRole.name.label" default="Name" /></span>

                                    <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${gameRoleInstance}" field="name"/></span>

                                </li>
                            </g:if>

                        </ol>
                        <g:form url="[resource:gameRoleInstance, action:'delete']" method="DELETE">
                            <fieldset class="buttons">
                                <g:link class="edit" action="edit" resource="${gameRoleInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                                <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                            </fieldset>
                        </g:form>
                    </div>
                </div>
            </div>
		</div>
	</body>
</html>
