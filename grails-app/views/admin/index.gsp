<%--
  Created by IntelliJ IDEA.
  User: steve
  Date: 10/8/13
  Time: 3:28 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name='layout' content='main'/>
  <title>Admin</title>
</head>
<body>

<skm:pageHeader class="col-lg-12">
    <h1>
        Admin
        <span class="pull-right">
            <g:link controller="playerCharacter" action="importCharacterData" class="btn btn-primary" data-toggle="tooltip" title="Import Character Data">
                <span class="glyphicon glyphicon-import"></span>
            </g:link>
            <g:link controller="admin" action="exportAllData" class="btn btn-success" data-toggle="tooltip" title="Export All Data">
                <span class="glyphicon glyphicon-export"></span>
            </g:link>
        </span>
    </h1>
</skm:pageHeader>

<div class="container">
    <div class="row">
        %{-- users --}%
        <div class="col-lg-4">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <g:link controller="user" action="index">Users</g:link>
                        <span class="pull-right badge">${userCount}</span>
                    </h3>
                </div>
                <div class="panel-body">
                    Recent Registrations
                    <ul class="list-group">
                        <g:each in="${recentUsers}">
                            <li class="list-group-item">
                                <skm:userLink user="${it}"/>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </div>

        %{-- Classes --}%
        <div class="col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <g:link controller="characterClass" action="index">Classes</g:link>
                        <span class="pull-right badge">${classCount}</span>
                    </h3>
                </div>
                <div class="panel-body">
                    <ul class="list-group">
                        <g:each in="${classesWithCharacterCount}">
                            <li class="list-group-item">
                                <span class="badge">${it.characterCount}</span>
                                <g:link controller="characterClass" action="show" id="${it.characterClass.id}">
                                    ${it.characterClass.name}
                                </g:link>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </div>

        %{-- roles --}%
        <div class="col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <g:link controller="gameRole" action="index">Roles</g:link>
                        <span class="pull-right badge">${roleCount}</span>
                    </h3>
                </div>
                <div class="panel-body">
                    <ul class="list-group">
                        <g:each in="${rolesWithCaracterCount}">
                            <li class="list-group-item">
                                <span class="badge">${it.characterCount}</span>
                                <g:link controller="gameRole" action="show" id="${it.role.id}">
                                    ${it.role.name}
                                </g:link>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="row">

        %{-- User Roles --}%
        <div class="col-lg-4">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-9">
                            <h3 class="panel-title">
                                <g:link controller="userRole" action="index">User Roles</g:link>
                            </h3>
                        </div>
                        <div class="col-lg-1">
                            <g:link controller="userRole" action="create" class="btn btn-primary btn-xs">
                                <span class="glyphicon glyphicon-plus"></span>
                            </g:link>
                        </div>
                        <div class="col-lg-1">
                            <span class="badge">${userRoleCount}</span>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <ul class="list-group">
                        <g:each in="${userRolesWithUserCount}">
                            <li class="list-group-item">
                                <g:link controller="role" action="show" id="${it.role.id}">${it.role.authority}</g:link>
                                <span class="pull-right badge">${it.userCount}</span>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </div>

        %{-- characters --}%
        <div class="col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <g:link controller="playerCharacter" action="index">Chracters</g:link>
                        <span class="pull-right badge">${characterCount}</span>
                    </h3>
                </div>
                <div class="panel-body">
                    <ul class="list-group"></ul>
                </div>
            </div>
        </div>

        %{-- raids --}%
        <div class="col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <g:link controller="raid" action="index">Raids</g:link>
                        <span class="pull-right badge">${raidCount}</span>
                    </h3>
                </div>
                <div class="panel-body">
                    <ul class="list-group"></ul>
                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>
