
<%@ page import="org.stevegood.game.PlayerCharacter" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'playerCharacter.label', default: 'PlayerCharacter')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h1>
                        Characters
                        <sec:ifLoggedIn>
                            <span class="pull-right">
                                <g:link controller="playerCharacter" action="create" class="btn btn-primary">
                                    <span class="glyphicon glyphicon-plus"></span>
                                </g:link>
                            </span>
                        </sec:ifLoggedIn>
                    </h1>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="table-responsive">
                    <table class="table table-horizontal table-striped">
                        <thead>
                        <tr>
                            <g:sortableColumn property="name" title="${message(code: 'playerCharacter.name.label', default: 'Name')}" />
                            <th><g:message code="playerCharacter.level.label" default="Level" /></th>
                            <th><g:message code="playerCharacter.characterClass.label" default="Class" /></th>
                            <th><g:message code="playerCharacter.note.label" default="Note" /></th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${playerCharacterInstanceList}" status="i" var="playerCharacterInstance">
                            <tr>
                                <td>
                                    <g:link action="show" id="${playerCharacterInstance.id}">${fieldValue(bean: playerCharacterInstance, field: "name")}</g:link>
                                </td>
                                <td>${fieldValue(bean: playerCharacterInstance, field: "level")}</td>
                                <td>${fieldValue(bean: playerCharacterInstance, field: "characterClass")}</td>
                                <td>${fieldValue(bean: playerCharacterInstance, field: "note")}</td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
                <div class="pagination">
                    <g:paginate total="${playerCharacterInstanceCount ?: 0}" />
                </div>
            </div>
        </div>
    </div>

		%{--<div id="list-playerCharacter" class="content scaffold-list" role="main">--}%
			%{--<g:if test="${flash.message}">--}%
				%{--<div class="message" role="status">${flash.message}</div>--}%
			%{--</g:if>--}%
		%{--</div>--}%
	</body>
</html>
