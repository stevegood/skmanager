
<%@ page import="org.stevegood.sec.UserRole" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userRole.label', default: 'UserRole')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>

    <skm:pageHeader class="col-lg-12">
        <h1>${userRoleInstance.role.authority} for ${userRoleInstance.user.username}</h1>
    </skm:pageHeader>

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-lg-offset-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            Actions
                        </h3>
                    </div>

                    <div class="panel-body">
                        <ul class="list-group">

                            <g:if test="${userRoleInstance?.user}">
                                <li class="list-group-item">
                                    <span id="user-label" class="property-label"><g:message code="userRole.user.label" default="User" /></span>

                                    <span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${userRoleInstance?.user?.id}">${userRoleInstance?.user?.encodeAsHTML()}</g:link></span>

                                </li>
                            </g:if>

                            <g:if test="${userRoleInstance?.role}">
                                <li class="list-group-item">
                                    <span id="role-label" class="property-label"><g:message code="userRole.role.label" default="Role" /></span>

                                    <span class="property-value" aria-labelledby="role-label">
                                        <g:link controller="role" action="show" id="${userRoleInstance?.role?.id}">${userRoleInstance?.role?.authority?.encodeAsHTML()}</g:link>
                                    </span>

                                </li>
                            </g:if>

                        </ul>
                        <sec:ifAllGranted roles="ROLE_ADMIN">
                            <g:if test="${sec.username() != userRoleInstance.user.username}">
                                <g:form url="[resource:userRoleInstance, action:'delete']" method="DELETE">
                                    <g:hiddenField name="userid" value="${userRoleInstance.user.id}" />
                                    <g:hiddenField name="roleid" value="${userRoleInstance.role.id}" />
                                    <fieldset class="buttons">
                                        <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                    </fieldset>
                                </g:form>
                            </g:if>
                        </sec:ifAllGranted>
                    </div>
                </div>
            </div>
        </div>
    </div>
	</body>
</html>
