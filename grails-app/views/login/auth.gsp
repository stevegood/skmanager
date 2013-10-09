<html>
<head>
	<meta name='layout' content='main'/>
	<title><g:message code="springSecurity.login.title"/></title>
</head>

<body>

<div id="login-panel" class="container">
    <div class="row">
        <div class="col-lg-4 col-lg-offset-4">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <g:message code="springSecurity.login.header"/>
                    </h3>
                </div>
                <div class="panel-body">
                    <form action='${postUrl}' method='POST' class='form-horizontal' role="form" autocomplete='off'>
                        <div class="form-group">
                            <label for='username' class="col-lg-3 control-label"><g:message code="springSecurity.login.username.label"/>:</label>
                            <div class="col-lg-9">
                                <input type='text' class='form-control' name='j_username' id='username' value="${params?.username}"
                                       placeholder="${message(code: 'springSecurity.login.username.label')}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for='password' class="col-lg-3 control-label"><g:message code="springSecurity.login.password.label"/>:</label>
                            <div class="col-lg-9">
                                <input type='password' class='form-control' name='j_password' id='password'
                                       placeholder="${message(code: 'springSecurity.login.password.label')}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-lg-offset-3 col-lg-9">
                                <div class="checkbox">
                                    <label>
                                        <input type='checkbox' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/> <g:message code="springSecurity.login.remember.me.label"/>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-lg-offset-3 col-lg-9">
                                <button class="btn btn-primary" type="submit">
                                    <g:message code="springSecurity.login.button" />
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="panel-footer">
                    <span class="text-muted">Don't have an account? <g:link controller="user" action="register">Register now!</g:link></span>
                </div>
            </div>

            <g:if test='${flash.message}'>
                <div class='alert alert-danger'>
                    ${flash.message}
                </div>
            </g:if>

        </div>
    </div>
</div>

<script type='text/javascript'>
	<!--
	(function() {
		document.forms['loginForm'].elements['j_username'].focus();
	})();
	// -->
</script>
</body>
</html>
