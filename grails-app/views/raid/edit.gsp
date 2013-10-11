<%@ page import="org.stevegood.sk.Raid" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Edit Raid</title>
	</head>
	<body>

    <div class="page-header">
        <div class="container">
            <div class="col-lg-6 col-lg-offset-3">
                <h1>Edit Raid</h1>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-lg-offset-3">

                <div class="panel panel-default">
                    <div class="panel-body">
                        <div id="create-raid" class="content scaffold-create" role="main">
                            <g:form url="[resource:raidInstance, action:'update']" role="form" class="form form-horizontal" method="PUT">
                                <g:hiddenField name="version" value="${raidInstance?.version}" />
                                <g:render template="form"/>
                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <g:submitButton name="update" class="btn btn-primary" value="${message(code: 'default.button.update.label', default: 'Update')}" />
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
