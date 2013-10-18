
<%@ page import="org.stevegood.game.PlayerCharacter" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'playerCharacter.label', default: 'PlayerCharacter')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>

    <skm:pageHeader class="col-lg-12">
        <h1>
            ${playerCharacterInstance.name}
            <span class="small text-muted">Level ${playerCharacterInstance.level} ${playerCharacterInstance.characterClass.name}</span>
            <sec:ifAllGranted roles="ROLE_ADMIN">
                <g:form url="[resource:playerCharacterInstance, action:'delete']" method="DELETE" class="pull-right">
                    <g:link controller="playerCharacter" action="edit" resource="${playerCharacterInstance}" class="btn btn-info">
                        <span class="glyphicon glyphicon-pencil"></span>
                    </g:link>
                    <button type="submit" name="_action_delete" class="btn btn-danger" onclick="return confirm('Are you sure?');">
                        <span class="glyphicon glyphicon-trash"></span>
                    </button>
                </g:form>
            </sec:ifAllGranted>
        </h1>
    </skm:pageHeader>

    <g:if test="${playerCharacterInstance.note?.size()}">
        <skm:pageHeader class="col-lg-12">
            <h3>Note</h3>
        </skm:pageHeader>

        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    ${playerCharacterInstance.note?.encodeAsHTML()}
                </div>
            </div>
        </div>
    </g:if>

	</body>
</html>
