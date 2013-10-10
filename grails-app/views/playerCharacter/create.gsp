<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'playerCharacter.label', default: 'PlayerCharacter')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>

    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-lg-offset-3">
                    <h1>Create Character</h1>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-lg-offset-3">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <g:form url="[resource:playerCharacterInstance, action:'save']" class="form form-horizontal" role="form">

                            <g:render template="form"/>

                            <div class="form-group">
                                <div class="col-lg-offset-4 col-lg-8">
                                    <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
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
