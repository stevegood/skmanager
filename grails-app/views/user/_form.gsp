<%@ page import="org.stevegood.sec.User" %>



<div class="form-group ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label class="control-label col-lg-4" for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-lg-8">
        <g:textField name="username" required="" value="${userInstance?.username}" class="form-control"/>
	</div>
</div>

<hr>

<div class="form-group ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password" class="control-label col-lg-4">
		<g:message code="user.password.label" default="Password" />
	</label>
	<div class="col-lg-8">
        <g:passwordField name="password" class="form-control"/>
	</div>
</div>

<div class="form-group ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
    <label for="password2" class="control-label col-lg-4">
        Repeat <g:message code="user.password.label" default="Password" />
    </label>
	<div class="col-lg-8">
        <g:passwordField name="password2" class="form-control"/>
	</div>
</div>

