<%--
  Created by IntelliJ IDEA.
  User: steve
  Date: 10/9/13
  Time: 10:49 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Register New Account</title>
    <meta name="layout" content="main" />
    <r:require module="user_registration" />
</head>
<body>

<div class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-lg-offset-3">
                <h1>Register New Account</h1>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-6 col-lg-offset-3">
            <div class="panel panel-default">
                <div class="panel-body">
                    <g:form id="registration_form" url="[resource:userInstance, action:'saveRegistration']"
                            class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for='username' class="col-lg-3 control-label"><g:message code="springSecurity.login.username.label"/>:</label>
                            <div class="col-lg-9">
                                <input type='text' class='form-control' name='username' id='username' value="${userInstance?.username}"
                                       required placeholder="${message(code: 'springSecurity.login.username.label')}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for='password' class="col-lg-3 control-label"><g:message code="springSecurity.login.password.label"/>:</label>
                            <div class="col-lg-9">
                                <input type='password' class='form-control' name='password' id='password'
                                       required placeholder="${message(code: 'springSecurity.login.password.label')}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-lg-9 col-lg-offset-3">
                                <input type='password' class='form-control' name='password2' id='password2'
                                       required placeholder="Repeat ${message(code: 'springSecurity.login.password.label')}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-lg-offset-3 col-lg-9">
                                <button class="btn btn-primary" type="submit">
                                    <g:message code="register.button" default="Register" />
                                </button>
                            </div>
                        </div>
                    </g:form>
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

</body>
</html>