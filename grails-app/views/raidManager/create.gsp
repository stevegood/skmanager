<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Add Manager to ${raidManagerInstance?.raid?.name}</title>
	</head>
	<body>

    <skm:pageHeader class="col-lg-6 col-lg-offset-3">
        <h1>Add Manager</h1>
    </skm:pageHeader>

    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-lg-offset-3">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Select a user to add as a manager to ${raidManagerInstance?.raid?.name}</h3>
                    </div>
                    <div class="panel-body">
                        <g:form url="[resource:raidManagerInstance, action:'save']" class="form form-horizontal">
                            <g:render template="form" model="${[raidManagerInstance: raidManagerInstance, users: users]}"/>

                            <div class="form-group">
                                <div class="col-lg-9 col-lg-offset-3">
                                    <g:submitButton name="create" class="btn btn-primary" value="Add Manager" />
                                </div>
                            </div>
                        </g:form>
                    </div>
                    <g:hasErrors bean="${raidManagerInstance}">
                        <div class="panel-footer">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${raidManagerInstance}" var="error">
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
