<%@ page import="org.stevegood.sec.User" %>

<g:set var="canManage" value="${sec.username() == userInstance.username}" />
<sec:ifAllGranted roles="ROLE_ADMIN">
    <g:set var="canManage" value="${true}" />
</sec:ifAllGranted>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-lg-9">
                <h1>${userInstance.username}</h1>
            </div>
            <div class="col-lg-3 btns">
                <sec:ifLoggedIn>
                    <g:if test="${canManage}">
                        <div class="pull-right">
                            <div class="btn-group">
                                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                    <span class="glyphicon glyphicon-cog dropdown-toggle" data-toggle="dropdown"></span> <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li>
                                        <g:link action="edit" resource="${userInstance}">
                                            <span class="glyphicon glyphicon-pencil"></span>
                                            <g:message code="default.button.edit.label" default="Edit"/>
                                        </g:link>
                                    </li>
                                    <sec:ifAllGranted roles="ROLE_ADMIN">
                                        <li class="divider"></li>
                                        <li>
                                            <g:link controller="user" action="enableDisable" id="${userInstance.id}">
                                                <span class="glyphicon glyphicon-${userInstance.enabled ? 'remove' : 'ok'}"></span>
                                                ${userInstance.enabled ? 'Disable' : 'Enable'} Account
                                            </g:link>
                                        </li>

                                        <li>
                                            <g:link controller="user" action="lockUnlock" id="${userInstance.id}">
                                                <span class="glyphicon glyphicon-${userInstance.accountLocked ? 'ok' : 'remove'}"></span>
                                                ${userInstance.accountLocked ? 'Unlock' : 'Lock'} Account
                                            </g:link>
                                        </li>

                                        <li>
                                            <g:link controller="user" action="expireActivateAccount" id="${userInstance.id}">
                                                <span class="glyphicon glyphicon-${userInstance.accountExpired ? 'ok' : 'remove'}"></span>
                                                ${userInstance.accountExpired ? 'Activate' : 'Expire'} Account
                                            </g:link>
                                        </li>

                                        <li>
                                            <g:link controller="user" action="expireActivatePassword" id="${userInstance.id}">
                                                <span class="glyphicon glyphicon-${userInstance.passwordExpired ? 'ok' : 'remove'}"></span>
                                                ${userInstance.passwordExpired ? 'Activate' : 'Expire'} Password
                                            </g:link>
                                        </li>
                                    </sec:ifAllGranted>
                                </ul>
                            </div>
                        </div>
                    </g:if>
                </sec:ifLoggedIn>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-12">

            <table class="table table-responsive table-striped">
                <thead>
                    <tr>
                        <th>Account Enabled</th>
                        <th>Account Locked</th>
                        <th>Account Expired</th>
                        <th>Password Expired</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><skm:formatBoolean boolean="${userInstance.enabled}" /></td>
                        <td><skm:formatBoolean boolean="${userInstance.accountLocked}" /></td>
                        <td><skm:formatBoolean boolean="${userInstance.accountExpired}" /></td>
                        <td><skm:formatBoolean boolean="${userInstance.passwordExpired}" /></td>

                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
