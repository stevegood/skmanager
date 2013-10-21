<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userRole.label', default: 'UserRole')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>

    <skm:pageHeader class="col-lg-4 col-lg-offset-4">
        <h1>Add Role to User</h1>
    </skm:pageHeader>

    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-lg-offset-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            Select User and Role
                        </h3>
                    </div>

                    <div class="panel-body">
                        <g:if test="${flash.message}">
                            <div class="message" role="status">${flash.message}</div>
                        </g:if>
                        <g:hasErrors bean="${userRoleInstance}">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${userRoleInstance}" var="error">
                                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                                </g:eachError>
                            </ul>
                        </g:hasErrors>

                        <g:form url="[resource:userRoleInstance, action:'save']" class="form form-horizontal" role="form">

                                <g:render template="form"/>

                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                                    </div>
                                </div>

                        </g:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
	</body>
</html>
