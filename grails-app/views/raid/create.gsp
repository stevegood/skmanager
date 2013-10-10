<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'raid.label', default: 'Raid')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>

    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-lg-offset-3">
                    <h1><g:message code="default.create.label" args="[entityName]" /></h1>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-lg-offset-3">

                <div class="panel panel-default">
                    <div class="panel-body">
                        <div id="create-raid" class="content scaffold-create" role="main">
                            <g:form url="[resource:raidInstance, action:'save']" role="form" class="form form-horizontal">
                                <g:render template="form"/>
                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                                    </div>
                                </div>
                            </g:form>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <g:if test="${flash.message}">
                            <div class="message" role="status">${flash.message}</div>
                        </g:if>
                        <g:hasErrors bean="${raidInstance}">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${raidInstance}" var="error">
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
