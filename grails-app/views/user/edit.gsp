<%@ page import="org.stevegood.sec.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>

    <skm:pageHeader class="col-lg-6 col-lg-offset-3">
        <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
    </skm:pageHeader>

    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-lg-offset-3">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">${userInstance.username}</h3>
                    </div>
                    <div class="panel-body">
                        <g:form url="[resource:userInstance, action:'update']" method="PUT" class="form form-horizontal">
                            <g:hiddenField name="version" value="${userInstance?.version}" />

                            <g:render template="form"/>

                            <div class="form-group">
                                <div class="col-lg-8 col-lg-offset-4">
                                    <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                                </div>
                            </div>
                        </g:form>
                    </div>
                    <g:hasErrors bean="${userInstance}">
                        <div class="panel-footer">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${userInstance}" var="error">
                                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                                </g:eachError>
                            </ul>
                        </div>
                    </g:hasErrors>
                </div>
            </div>
        </div>
    </div>
	</body>
</html>
