<%@ page import="org.stevegood.game.PlayerCharacter" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'playerCharacter.label', default: 'PlayerCharacter')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>

    <skm:pageHeader class="col-lg-6 col-lg-offset-3">
        <h1>Edit ${playerCharacterInstance.name}</h1>
    </skm:pageHeader>

    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-lg-offset-3">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <g:form url="[resource:playerCharacterInstance, action:'update']" class="form form-horizontal" role="form">

                            <g:render template="form"/>

                            <div class="form-group">
                                <div class="col-lg-offset-3 col-lg-2">
                                    <g:submitButton name="update" class="btn btn-primary" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                                </div>

                                <div class="col-lg-7">
                                    <g:link controller="playerCharacter" action="show" id="${playerCharacterInstance.id}" class="btn btn-danger">
                                        Cancel
                                    </g:link>
                                </div>
                            </div>

                        </g:form>
                    </div>
                    <div class="panel-footer">
                        <g:if test="${flash.message}">
                            <div class="message" role="status">${flash.message}</div>
                        </g:if>
                        <g:hasErrors bean="${playerCharacterInstance}">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${playerCharacterInstance}" var="error">
                                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                                </g:eachError>
                            </ul>
                        </g:hasErrors>
                    </div>
                </div>
            </div>
        </div>
    </div>
	</body>
</html>
