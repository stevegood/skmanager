<%@ page import="org.stevegood.sec.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

    <skm:pageHeader>
        <h1>Users</h1>
    </skm:pageHeader>

    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <table class="table table-responsive table-striped">
                    <thead>
                    <tr>

                        <g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}" />

                        <g:sortableColumn property="enabled" title="${message(code: 'user.enabled.label', default: 'Enabled')}" />

                        <g:sortableColumn property="accountLocked" title="${message(code: 'user.accountLocked.label', default: 'Account Locked')}" />

                        <g:sortableColumn property="accountExpired" title="${message(code: 'user.accountExpired.label', default: 'Account Expired')}" />

                        <g:sortableColumn property="passwordExpired" title="${message(code: 'user.passwordExpired.label', default: 'Password Expired')}" />

                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${userInstanceList}" var="userInstance">
                        <tr>

                            <td><skm:userLink user="${userInstance}" /></td>

                            <td><skm:formatBoolean boolean="${userInstance.enabled}" /></td>

                            <td><skm:formatBoolean boolean="${userInstance.accountLocked}" /></td>

                            <td><skm:formatBoolean boolean="${userInstance.accountExpired}" /></td>

                            <td><skm:formatBoolean boolean="${userInstance.passwordExpired}" /></td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <g:if test="${userInstanceCount > 10}">
                    <bootstrap:paginate total="${userInstanceCount ?: 0}" />
                </g:if>
            </div>
        </div>
    </div>
	</body>
</html>
