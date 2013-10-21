
<%@ page import="org.stevegood.sec.UserRole" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userRole.label', default: 'UserRole')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

    <skm:pageHeader class="col-lg-12">
        <h1>User Roles</h1>
    </skm:pageHeader>

    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table class="table table-striped">
                    <thead>
                    <tr>

                        <th><g:message code="userRole.user.label" default="User" /></th>
                        <th><g:message code="userRole.role.label" default="Role" /></th>

                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${userRoleInstanceList}" status="i" var="userRoleInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td>
                            <g:link action="show" params="${[userid: userRoleInstance.user.id, roleid: userRoleInstance.role.id]}">
                                ${fieldValue(bean: userRoleInstance, field: "user")}</td>
                            </g:link>
                            <td>${userRoleInstance.role.authority}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="pagination">
                    <g:paginate total="${userRoleInstanceCount ?: 0}" />
                </div>
            </div>
        </div>
    </div>
	</body>
</html>
